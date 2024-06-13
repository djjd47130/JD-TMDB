unit uContentListBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfrmContentBase1 = class(TfrmContentBase)
    lstGenreMovies: TListView;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContentBase1: TfrmContentBase1;

implementation

{$R *.dfm}

end.
