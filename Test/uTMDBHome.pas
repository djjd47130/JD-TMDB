unit uTMDBHome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uContentBase, JD.Common, JD.Ctrls,
  JD.Ctrls.FontButton, Vcl.ExtCtrls,

  JD.TMDB.Common,
  JD.TMDB.Intf,

  uTMDBAppSetup,
  uContentCertsMovies,
  uContentCertsTV,
  uContentGenresMovie,
  uContentGenresTV,
  uContentSearchCollections,
  uContentSearchCompanies,
  uContentSearchKeywords,
  uContentSearchMovies,
  uContentSearchMulti,
  uContentSearchPeople,
  uContentSearchTV,
  uContentConfigCountries,
  uContentConfigLanguages,
  uContentConfigTimezones,
  uContentConfigJobs,
  uContentBrowser,
  uContentMoviePage,
  uContentDiscoverMovies,
  Vcl.StdCtrls;

type
  TfrmTMDBHome = class(TfrmContentBase)
    SB: TScrollBox;
    pMovies: TPanel;
    Label1: TLabel;
    btnMovieCertifications: TJDFontButton;
    btnMovieGenres: TJDFontButton;
    btnMyMovieWatchlist: TJDFontButton;
    btnMyFavoriteMovies: TJDFontButton;
    btnMyRatedMovies: TJDFontButton;
    btnTopRatedMovies: TJDFontButton;
    btnUpcomingMovies: TJDFontButton;
    btnPopularMovies: TJDFontButton;
    btnNowPlayingMovies: TJDFontButton;
    btnDiscoverMovies: TJDFontButton;
    btnSearchCollections: TJDFontButton;
    btnSearchMovies: TJDFontButton;
    pTV: TPanel;
    Label2: TLabel;
    btnSearchTV: TJDFontButton;
    btnDiscoverTV: TJDFontButton;
    JDFontButton4: TJDFontButton;
    JDFontButton31: TJDFontButton;
    JDFontButton7: TJDFontButton;
    JDFontButton8: TJDFontButton;
    JDFontButton10: TJDFontButton;
    JDFontButton28: TJDFontButton;
    JDFontButton13: TJDFontButton;
    pMisc: TPanel;
    Label3: TLabel;
    pConfig: TPanel;
    Label4: TLabel;
    JDFontButton26: TJDFontButton;
    JDFontButton45: TJDFontButton;
    JDFontButton47: TJDFontButton;
    JDFontButton44: TJDFontButton;
    JDFontButton5: TJDFontButton;
    JDFontButton3: TJDFontButton;
    JDFontButton22: TJDFontButton;
    JDFontButton21: TJDFontButton;
    JDFontButton20: TJDFontButton;
    JDFontButton19: TJDFontButton;
    JDFontButton18: TJDFontButton;
    JDFontButton17: TJDFontButton;
    JDFontButton49: TJDFontButton;
    pPeople: TPanel;
    Label5: TLabel;
    JDFontButton48: TJDFontButton;
    JDFontButton6: TJDFontButton;
    JDFontButton11: TJDFontButton;
    JDFontButton2: TJDFontButton;
    JDFontButton9: TJDFontButton;
    JDFontButton12: TJDFontButton;
    JDFontButton14: TJDFontButton;
    JDFontButton15: TJDFontButton;
    JDFontButton16: TJDFontButton;
    JDFontButton23: TJDFontButton;
    JDFontButton1: TJDFontButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchMoviesClick(Sender: TObject);
    procedure btnSearchCollectionsClick(Sender: TObject);
    procedure JDFontButton44Click(Sender: TObject);
    procedure JDFontButton45Click(Sender: TObject);
    procedure JDFontButton47Click(Sender: TObject);
    procedure JDFontButton48Click(Sender: TObject);
    procedure btnSearchTVClick(Sender: TObject);
    procedure JDFontButton49Click(Sender: TObject);
    procedure CategoryPanelGroup1MouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure CategoryPanelGroup1MouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure btnMovieCertificationsClick(Sender: TObject);
    procedure JDFontButton13Click(Sender: TObject);
    procedure btnMovieGenresClick(Sender: TObject);
    procedure JDFontButton28Click(Sender: TObject);
    procedure JDFontButton18Click(Sender: TObject);
    procedure JDFontButton20Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure JDFontButton22Click(Sender: TObject);
    procedure JDFontButton19Click(Sender: TObject);
    procedure JDFontButton1Click(Sender: TObject);
    procedure btnNowPlayingMoviesClick(Sender: TObject);
    procedure btnPopularMoviesClick(Sender: TObject);
    procedure btnUpcomingMoviesClick(Sender: TObject);
    procedure btnTopRatedMoviesClick(Sender: TObject);
    procedure btnMyFavoriteMoviesClick(Sender: TObject);
    procedure btnMyMovieWatchlistClick(Sender: TObject);
    procedure JDFontButton23Click(Sender: TObject);
    procedure btnDiscoverMoviesClick(Sender: TObject);
  private
    procedure CalcScrollHeight;
    procedure SetNarrowMode(const Value: Boolean);
  protected
  public
    function CanClose: Boolean; override;
    procedure HideMenu;
  end;

var
  frmTMDBHome: TfrmTMDBHome;

implementation

{$R *.dfm}

uses
  uMain,
  JD.TabController;

type
  THackCategoryPanelGroup = class(TCategoryPanelGroup)
  protected
    procedure CreateParams (var Params: TCreateParams); override;
  end;

{ THackCategoryPanelGroup }

procedure THackCategoryPanelGroup.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style:= Params.Style  and  not  WS_BORDER;

end;

procedure TfrmTMDBHome.FormCreate(Sender: TObject);
begin
  inherited;
  TabCaption:= 'Main Menu';
  CalcScrollHeight;
  SB.VertScrollBar.Position:= 0;
end;

procedure TfrmTMDBHome.FormResize(Sender: TObject);
begin
  inherited;
  if Width >= 120 then begin
    SetNarrowMode(False);
  end else begin
    SetNarrowMode(True);
  end;
end;

procedure TfrmTMDBHome.HideMenu;
begin
  frmMain.ShowMenu(False);
end;

procedure TfrmTMDBHome.SetNarrowMode(const Value: Boolean);
const
  BTN_HEIGHT = 38;
var
  X, Y: Integer;
  P: TPanel;
  C: TControl;
  L: TLabel;
  B: TJDFontButton;
begin
  for X := 0 to SB.ControlCount-1 do begin
    if SB.Controls[X] is TPanel then begin
      L:= nil;
      P:= SB.Controls[X] as TPanel;
      for Y := 0 to P.ControlCount-1 do begin
        if P.Controls[Y] is TLabel then begin
          L:= P.Controls[Y] as TLabel;
          Break;
        end;
      end;
      if Assigned(L) then begin
        L.Visible:= not Value;
        L.Top:= -1;
      end;
      for Y := 0 to P.ControlCount-1 do begin
        C:= P.Controls[Y];
        if C is TJDFontButton then begin
          B:= C as TJDFontButton;

          B.Height:= BTN_HEIGHT;
          B.Font.Size:= 14;
          B.Margins.Top:= 0;
          B.Margins.Bottom:= 0;

          B.Image.Font.Size:= 24;

          B.ShowHint:= True;
          B.Hint:= B.Text;
          if Assigned(L) then begin
            B.Hint:= L.Caption + ' - ' + B.Hint;
          end;
          if Value then begin
            B.ImagePosition:= fpImgOnly;
            B.Margins.Left:= 5;
            B.Margins.Right:= 5;
          end else begin
            B.ImagePosition:= fpImgLeft;
            B.Margins.Left:= 20;
            B.Margins.Right:= 20;
          end;

        end;
      end;
      if Value then begin
        P.ClientHeight:= ((P.ControlCount-1) * BTN_HEIGHT) + 20;
      end else begin
        P.ClientHeight:= ((P.ControlCount-1) * BTN_HEIGHT) + L.Height + 10;
      end;
    end;
  end;
  CalcScrollHeight;
end;

procedure TfrmTMDBHome.CalcScrollHeight;
var
  X: Integer;
  H: Integer;
begin
  H:= 1;
  for X := 0 to SB.ControlCount-1 do begin
    H:= H + SB.Controls[X].Height;
  end;
  SB.VertScrollBar.Range:= H;
end;

function TfrmTMDBHome.CanClose: Boolean;
begin
  Result:= False;
end;

procedure TfrmTMDBHome.CategoryPanelGroup1MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  SB.VertScrollBar.Position:= SB.VertScrollBar.Position + 20;
end;

procedure TfrmTMDBHome.CategoryPanelGroup1MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  inherited;
  SB.VertScrollBar.Position:= SB.VertScrollBar.Position - 20;
end;

procedure TfrmTMDBHome.btnDiscoverMoviesClick(Sender: TObject);
begin
  inherited;

  TabController.CreateTab(TfrmContentDiscoverMovies);
  HideMenu;

end;

procedure TfrmTMDBHome.btnMovieCertificationsClick(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentCertsMovies);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton13Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentCertsTV);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton18Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentConfigCountries);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton19Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentConfigJobs);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton1Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentBrowser);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton20Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentConfigLanguages);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton22Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentConfigTimezones);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton23Click(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
  //W: TTMDBTimeWindow;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'Trending Movies';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      //TODO: Handle time window option...
      Data:= TMDB.Trending.GetMovies(twDay, AppSetup.Language, Page);
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.btnMovieGenresClick(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentGenresMovie);
  HideMenu;
end;

procedure TfrmTMDBHome.btnMyFavoriteMoviesClick(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'My Favorite Movies';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      Data:= TMDB.Account.GetFavoriteMovies(TMDB.LoginState.AccountID, Page,
        AppSetup.Language, TMDB.LoginState.SessionID);
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.btnMyMovieWatchlistClick(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'My Movie Watchlist';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      Data:= TMDB.Account.GetWatchlistMovies(TMDB.LoginState.AccountID, Page,
        AppSetup.Language, TMDB.LoginState.SessionID);
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.btnNowPlayingMoviesClick(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'Now Playing Movies';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      Data:= TMDB.MovieLists.GetNowPlaying(AppSetup.Language, Page, '');
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.btnPopularMoviesClick(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'Popular Movies';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      Data:= TMDB.MovieLists.GetPopular(AppSetup.Language, Page, '');
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton28Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentGenresTV);
  HideMenu;
end;

procedure TfrmTMDBHome.btnSearchCollectionsClick(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchCollections);
  HideMenu;
end;

procedure TfrmTMDBHome.btnSearchTVClick(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchTV);
  HideMenu;
end;

procedure TfrmTMDBHome.btnTopRatedMoviesClick(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'Top Rated Movies';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      Data:= TMDB.MovieLists.GetTopRated(AppSetup.Language, Page, '');
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.btnUpcomingMoviesClick(Sender: TObject);
var
  T: TJDTabRef;
  F: TfrmContentMoviePage;
begin
  inherited;
  T:= TabController.CreateTab(TfrmContentMoviePage);
  F:= TfrmContentMoviePage(T.Content);
  F.BaseName:= 'Upcoming Movies';
  F.OnGetPage:=
    procedure(Sender: TObject;
      const Page: Integer; var Data: ITMDBMoviePage)
    begin
      Data:= TMDB.MovieLists.GetUpcoming(AppSetup.Language, Page, '');
    end;
  F.RefreshData;
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton44Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchCompanies);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton45Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchKeywords);
  HideMenu;
end;

procedure TfrmTMDBHome.btnSearchMoviesClick(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchMovies);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton47Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchMulti);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton48Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmContentSearchPeople);
  HideMenu;
end;

procedure TfrmTMDBHome.JDFontButton49Click(Sender: TObject);
begin
  inherited;
  TabController.CreateTab(TfrmTMDBAppSetup);
  HideMenu;
end;

end.
