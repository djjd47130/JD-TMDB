unit uContentPageBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmContentPageBase = class(TfrmContentBase)
    Panel11: TPanel;
    lstSearchMovies: TListView;
    Panel12: TPanel;
    lblSearchMoviesResults: TLabel;
    lblSearchMoviesPage: TLabel;
    btnSearchMoviesPagePrev: TButton;
    btnSearchMoviesPageNext: TButton;
    Panel6: TPanel;
    btnSearchMoviesApply: TButton;
  private
    { Private declarations }
  public
    //TODO: Implement standard methods of interacting with common paginated lists...

  end;

var
  frmContentPageBase: TfrmContentPageBase;

implementation

{$R *.dfm}

end.
