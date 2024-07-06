unit uCommonReviews;

(*
  TODO: Change to be a paginated list!
*)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCommonFormBase, Vcl.ComCtrls,
  JD.TMDB.Common,
  JD.TMDB.Intf;

type
  TfrmCommonReviews = class(TfrmCommonFormBase)
    lstReviews: TListView;
  private
    FObj: ITMDBReviewPage;
  public
    procedure LoadReviewList(const Reviews: ITMDBReviewPage);
  end;

var
  frmCommonReviews: TfrmCommonReviews;

implementation

{$R *.dfm}

{ TfrmCommonReviews }

procedure TfrmCommonReviews.LoadReviewList(const Reviews: ITMDBReviewPage);
var
  X: Integer;
  R: ITMDBReview;
  I: TListItem;
begin
  FObj:= Reviews;
  lstReviews.Items.BeginUpdate;
  try
    lstReviews.Items.Clear;
    for X := 0 to FObj.Items.Count-1 do begin
      R:= FObj.Items[X];
      I:= lstReviews.Items.Add;
      I.Caption:= R.Author;
      I.SubItems.Add(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', R.CreatedAt));
      I.SubItems.Add(FormatFloat('0.0', R.AuthorDetail.Rating));
      I.SubItems.Add(R.Content);
    end;
  finally
    lstReviews.Items.EndUpdate;
  end;
end;

end.
