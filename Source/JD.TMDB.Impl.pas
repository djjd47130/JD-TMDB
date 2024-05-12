unit JD.TMDB.Impl;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  JD.TMDB.API, JD.TMDB.Intf,
  XSuperObject;

type
  TTMDBPageItem = class;


  TTMDBPage = class(TInterfacedObject, ITMDBPage)
  private
    FObj: ISuperObject;
    FItems: TList<ITMDBPageItem>;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem;
  end;

  TTMDBPageItem = class(TInterfacedObject, ITMDBPageItem)
  private
    FOwner: ITMDBPage;
    FObj: ISuperObject;
    FIndex: Integer;
  protected
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;
  public
    constructor Create(AOwner: ITMDBPage; AObj: ISuperObject;
      const AIndex: Integer); virtual;
    destructor Destroy; override;

    property Owner: ITMDBPage read GetOwner;
    property Index: Integer read GetIndex;
  end;


  { Genres }

  TTMDBGenreItem = class;

  TTMDBGenreList = class(TInterfacedObject, ITMDBGenreList)
  private
    FObj: ISuperObject;
    FItems: TList<ITMDBGenreItem>;
    procedure PopulateItems;
    procedure Clear;
  protected
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBGenreItem;
  public
    constructor Create(AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem;
  end;

  TTMDBGenreItem = class(TInterfacedObject, ITMDBGenreItem)
  private
    FObj: ISuperObject;
    FOwner: ITMDBGenreList;
  protected
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
  public
    constructor Create(AOwner: TTMDBGenreList; AObj: ISuperObject); virtual;
    destructor Destroy; override;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;


implementation

{ TTMDBPage }

constructor TTMDBPage.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBPageItem>.Create;
  PopulateItems;
end;

destructor TTMDBPage.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TTMDBPage.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBPage.GetItem(const Index: Integer): ITMDBPageItem;
begin
  Result:= FItems[Index];
end;

function TTMDBPage.GetPage: Integer;
begin
  Result:= FObj.I['page'];
end;

function TTMDBPage.GetTotalPages: Integer;
begin
  Result:= FObj.I['total_pages'];
end;

function TTMDBPage.GetTotalResults: Integer;
begin
  Result:= FObj.I['total_results'];
end;

procedure TTMDBPage.Clear;
begin
  //TODO: Reference counting?
  FItems.Clear;
end;

procedure TTMDBPage.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBPageItem;
begin
  Clear;
  for X := 0 to FObj.A['results'].Length-1 do begin
    O:= FObj.A['results'].O[X];
    I:= TTMDBPageItem.Create(Self, O, X);
    FItems.Add(I);
  end;
end;

{ TTMDBPageItem }

constructor TTMDBPageItem.Create(AOwner: ITMDBPage; AObj: ISuperObject;
  const AIndex: Integer);
begin
  FOwner:= AOwner;
  FObj:= AObj;
  FIndex:= AIndex;
end;

destructor TTMDBPageItem.Destroy;
begin

  inherited;
end;

function TTMDBPageItem.GetIndex: Integer;
begin
  Result:= FIndex;
end;

function TTMDBPageItem.GetOwner: ITMDBPage;
begin
  Result:= FOwner;
end;

{ TTMDBGenreList }

constructor TTMDBGenreList.Create(AObj: ISuperObject);
begin
  FObj:= AObj;
  FItems:= TList<ITMDBGenreItem>.Create;
  PopulateItems;
end;

destructor TTMDBGenreList.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

procedure TTMDBGenreList.Clear;
begin
  FItems.Clear;
end;

function TTMDBGenreList.GetCount: Integer;
begin
  Result:= FItems.Count;
end;

function TTMDBGenreList.GetItem(const Index: Integer): ITMDBGenreItem;
begin
  Result:= FItems[Index];
end;

procedure TTMDBGenreList.PopulateItems;
var
  X: Integer;
  O: ISuperObject;
  I: ITMDBGenreItem;
begin
  Clear;
  for X := 0 to FObj.A['results'].Length-1 do begin
    O:= FObj.A['results'].O[X];
    I:= TTMDBGenreItem.Create(Self, O);
    FItems.Add(I);
  end;
end;

{ TTMDBGenreItem }

constructor TTMDBGenreItem.Create(AOwner: TTMDBGenreList; AObj: ISuperObject);
begin
  FOwner:= AOwner;
  FObj:= AObj;
end;

destructor TTMDBGenreItem.Destroy;
begin

  inherited;
end;

function TTMDBGenreItem.GetID: Integer;
begin
  Result:= FObj.I['id'];
end;

function TTMDBGenreItem.GetName: WideString;
begin
  Result:= FObj.S['name'];
end;

end.
