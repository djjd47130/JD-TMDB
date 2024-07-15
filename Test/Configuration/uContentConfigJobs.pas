unit uContentConfigJobs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ComCtrls,
  JD.TMDB.Intf;

type
  TfrmContentConfigJobs = class(TfrmContentBase)
    lstJobs: TListView;
    btnRefresh: TButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentConfigJobs: TfrmContentConfigJobs;

implementation

{$R *.dfm}

procedure TfrmContentConfigJobs.btnRefreshClick(Sender: TObject);
var
  X, Y: Integer;
  L: ITMDBJobDepartments;
  D: ITMDBJobDepartment;
  I: TListItem;
  S: String;
begin
  inherited;
  lstJobs.Items.BeginUpdate;
  try
    lstJobs.Items.Clear;
    L:= TMDB.Configuration.GetJobs;
    for X := 0 to L.Count-1 do begin
      D:= L[X];
      for Y := 0 to Length(D.Jobs)-1 do begin
        S:= D.Jobs[Y];
        I:= lstJobs.Items.Add;
        I.Caption:= D.Department;
        I.SubItems.Add(S);
      end;
    end;
  finally
    lstJobs.Items.EndUpdate;
  end;
end;

procedure TfrmContentConfigJobs.FormCreate(Sender: TObject);
begin
  inherited;
  btnRefreshClick(nil);
end;

end.
