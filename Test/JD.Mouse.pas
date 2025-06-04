unit JD.Mouse;

interface

uses
  Windows, Classes, SysUtils, Messages, Controls;

type
  TJDMouseButtonPoints = Array[TMouseButton] of TPoint;
  TJDMouseButtonStates = Array[TMouseButton] of Boolean;

  TJDMouse = class(TComponent)
  private
    FOnButtonUp: TMouseEvent;
    FOnMove: TMouseMoveEvent;
    FOnButtonDown: TMouseEvent;
    FButtonPoints: TJDMouseButtonPoints;
    FButtonStates: TJDMouseButtonStates;
    procedure SetCursorPos(const Value: TPoint);
    function GetCursorPos: TPoint;
    procedure DoButtonDown(const IsDown: Boolean; const Button: TMouseButton;
      const Shift: TShiftState; const X, Y: Integer);
    procedure DoMove(const Shift: TShiftState; const X, Y: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CursorPos: TPoint read GetCursorPos write SetCursorPos;
    property OnButtonDown: TMouseEvent read FOnButtonDown write FOnButtonDown;
    property OnButtonUp: TMouseEvent read FOnButtonUp write FOnButtonUp;
    property OnMove: TMouseMoveEvent read FOnMove write FOnMove;
  end;

implementation

var
  _Hook: Cardinal;
  _Bucket: TList;
  _Lock: TRTLCriticalSection;

procedure LockMouse;
begin
  EnterCriticalSection(_Lock);
end;

procedure UnlockMouse;
begin
  LeaveCriticalSection(_Lock);
end;

type
  tagMSLLHOOKSTRUCT = record
    POINT: TPoint;
    mouseData: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: DWORD;
  end;
  TMSLLHOOKSTRUCT = tagMSLLHOOKSTRUCT;
  PMSLLHOOKSTRUCT = ^TMSLLHOOKSTRUCT;

function LowLevelMouseProc(nCode: Integer; wParam: wParam; lParam: lParam): LRESULT; stdcall;
var
  X: Integer;
  Delta: Smallint;
  M: TJDMouse;
  P: TPoint;
  Shift: TShiftState;
begin
  if (nCode >= 0) then begin
    LockMouse;
    try
      Delta := PMSLLHOOKSTRUCT(lParam)^.mouseData shr 16;
      try
        for X := 0 to _Bucket.Count - 1 do begin
          try
            M:= TJDMouse(_Bucket[X]);
            P:= Controls.Mouse.CursorPos;
            //Shift:= .....;   //TODO
            case wParam of
              WM_LBUTTONDOWN: begin
                M.DoButtonDown(True, mbLeft, Shift, P.X, P.Y);
              end;
              WM_LBUTTONUP: begin
                M.DoButtonDown(False, mbLeft, Shift, P.X, P.Y);
              end;
              WM_RBUTTONDOWN: begin
                M.DoButtonDown(True, mbRight, Shift, P.X, P.Y);
              end;
              WM_RBUTTONUP: begin
                M.DoButtonDown(False, mbRight, Shift, P.X, P.Y);
              end;
              WM_MBUTTONDOWN: begin
                M.DoButtonDown(True, mbMiddle, Shift, P.X, P.Y);
              end;
              WM_MBUTTONUP: begin
                M.DoButtonDown(False, mbMiddle, Shift, P.X, P.Y);
              end;
              WM_MOUSEMOVE: begin
                M.DoMove(Shift, P.X, P.Y);
              end;
              WM_MOUSEWHEEL: begin
                //TODO
              end;
              WM_MOUSEHWHEEL: begin
                //TODO
              end;
            end;
          except
            on e: exception do begin
              //TODO
            end;
          end;
        end;
      except
        on e: exception do begin
          //TODO
        end;
      end;
    finally
      UnlockMouse;
    end;
  end;
  Result:= CallNextHookEx(_Hook, nCode, wParam, lParam);
end;

{ TJDMouse }

constructor TJDMouse.Create(AOwner: TComponent);
begin
  LockMouse;
  try
    _Bucket.Add(Self); //Add self to bucket, registering to get events
  finally
    UnlockMouse;
  end;
end;

destructor TJDMouse.Destroy;
begin
  LockMouse;
  try
    _Bucket.Delete(_Bucket.IndexOf(Self)); //Remove self from bucket
  finally
    UnlockMouse;
  end;
  inherited;
end;

procedure TJDMouse.DoButtonDown(const IsDown: Boolean;
  const Button: TMouseButton; const Shift: TShiftState; const X, Y: Integer);
begin
  //Do not use lock, this is called from the lock already
  if IsDown then begin
    if assigned(FOnButtonDown) then
      FOnButtonDown(Self, Button, Shift, X, Y);
  end else begin
    if assigned(FOnButtonUp) then
      FOnButtonUp(Self, Button, Shift, X, Y);
  end;
end;

procedure TJDMouse.DoMove(const Shift: TShiftState; const X, Y: Integer);
begin
  //Do not use lock, this is called from the lock already
  if assigned(FOnMove) then
    FOnMove(Self, Shift, X, Y);
end;

function TJDMouse.GetCursorPos: TPoint;
begin
  LockMouse;
  try
    Result:= Controls.Mouse.CursorPos;
  finally
    UnlockMouse;
  end;
end;

procedure TJDMouse.SetCursorPos(const Value: TPoint);
begin
  LockMouse;
  try
    Controls.Mouse.CursorPos:= Value;
  finally
    UnlockMouse;
  end;
end;

initialization
  InitializeCriticalSection(_Lock);
  _Bucket:= TList.Create;
  _Hook:= SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseProc, hInstance, 0);
finalization
  UnhookWindowsHookEx(_Hook);
  _Bucket.Free;
  DeleteCriticalSection(_Lock);
end.
