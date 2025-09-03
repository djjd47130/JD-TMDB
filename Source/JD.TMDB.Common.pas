unit JD.TMDB.Common;

interface

uses
  System.Types, System.SysUtils,
  XSuperObject;

const
  { Default Constants }
  TMDB_API_ROOT = 'https://api.themoviedb.org/3/';
  TMDB_API_USERAGENT = 'JD TMDB API Wrapper for Delphi (https://github.com/djjd47130/JD-TMDB)';
  DEFAULT_IMAGE_BASE = 'https://image.tmdb.org/t/p/';

  { TMDB Error Code Constants }
  TMDB_ERR_SUCCESS = 1;
  TMDB_ERR_INVALID_SERVICE = 2;
  TMDB_ERR_AUTH_FAILED_PERMISSION = 3;
  TMDB_ERR_INVALID_FORMAT = 4;
  TMDB_ERR_INVALID_PARAMS = 5;
  TMDB_ERR_INVALID_ID_PREREQUISITE = 6;
  TMDB_ERR_INVALID_API_KEY = 7;
  TMDB_ERR_DUPLICATE_ENTRY = 8;
  TMDB_ERR_SERVICE_OFFLINE = 9;
  TMDB_ERR_SUSPENDED_API_KEY = 10;
  TMDB_ERR_INTERNAL_ERROR = 11;
  TMDB_ERR_UPDATED_SUCCESSFULLY = 12;
  TMDB_ERR_DELETED_SUCCESSFULLY = 13;
  TMDB_ERR_AUTH_FAILED = 14;
  TMDB_ERR_FAILED = 15;
  TMDB_ERR_DEVICE_DENIED = 16;
  TMDB_ERR_SESSION_DENIED = 17;
  TMDB_ERR_VALIDATION_FAILED = 18;
  TMDB_ERR_INVALID_ACCEPT_HEADER = 19;
  TMDB_ERR_INVALID_DATE_RANGE = 20;
  TMDB_ERR_ENTRY_NOT_FOUND = 21;
  TMDB_ERR_INVALID_PAGE = 22;
  TMDB_ERR_INVALID_DATE = 23;
  TMDB_ERR_REQUEST_TIMED_OUT = 24;
  TMDB_ERR_REQUEST_RATE_LIMITED = 25;
  TMDB_ERR_USER_PASS_REQUIRED = 26;
  TMDB_ERR_TOO_MANY_APPENDED = 27;
  TMDB_ERR_INVALID_TIMEZONE = 28;
  TMDB_ERR_CONFIRM_ACTION = 29;
  TMDB_ERR_INVALID_USER_PASS = 30;
  TMDB_ERR_ACCOUNT_DISABLED = 31;
  TMDB_ERR_EMAIL_NOT_VERIFIED = 32;
  TMDB_ERR_INVALID_REQUEST_TOKEN = 33;
  TMDB_ERR_RESOURCE_NOT_FOUND = 34;
  TMDB_ERR_INVALID_TOKEN = 35;
  TMDB_ERR_TOKEN_NOT_GRANTED = 36;
  TMDB_ERR_SESSION_NOT_FOUND = 37;
  TMDB_ERR_NO_PERMISSION = 38;
  TMDB_ERR_PRIVATE_RESOURCE = 39;
  TMDB_ERR_NOTHING_TO_UPDATE = 40;
  TMDB_ERR_TOKEN_NOT_APPROVED = 41;
  TMDB_ERR_METHOD_NOT_SUPPORTED = 42;
  TMDB_ERR_BACKEND_SERVER_CONN = 43;
  TMDB_ERR_INVALID_ID = 44;
  TMDB_ERR_USER_SUSPENDED = 45;
  TMDB_ERR_API_MAINTENANCE = 46;
  TMDB_ERR_INVALID_INPUT = 47;
  //Issue #44
  //https://developer.themoviedb.org/docs/errors


type

  { Common Types }

  /// <summary>
  /// Exception class for TMDB exceptions.
  /// </summary
  ETMDBException = class(Exception)
  private
    FCode: Integer;
    FHttpCode: Integer;
  public
    constructor Create(const Msg: String; const ErrCode: Integer;
      const HttpCode: Integer); reintroduce;
    property Code: Integer read FCode;
    property HttpCode: Integer read FHttpCode;
  end;

  /// <summary>
  /// Array of String, as used across TMDB library.
  /// </summary>
  TTMDBStrArray = TArray<WideString>;

  /// <summary>
  /// Array of Integer, as used across TMDB library.
  /// </summary>
  TTMDBIntArray = TArray<Integer>;

  /// <summary>
  /// Enum representing a boolean with a default. Used to ensure queries can
  /// be made without forcing a true/false selection.
  /// Issue #38
  /// </summary>
  TTMDBBoolean = (bDefault, bFalse, bTrue);

  /// <summary>
  /// An event triggered when a login request requires a browser
  ///   to be opened to a URL to authenticate.
  /// </summary>
  TTMDBUserAuthRequestEvent = procedure(Sender: TObject;
    const URL: WideString; var Result: Boolean) of object;



  { Common Enum / Set Types }

  /// <summary>
  /// Application / API Authentication Method
  /// </summary>
  TTMDBAuthMethod = (amAPIKey, amAccessToken);

  /// <summary>
  /// TMDB User Account Authentication
  /// </summary>
  TTMDBUserAuth = (uaUnauthorized, uaGuest, uaNormal, uaCredentials);

  /// <summary>
  /// Type of media content found in TMDB
  /// </summary>
  TTMDBMediaType = (mtUnspecified, mtMovie, mtTV, mtPerson);

  /// <summary>
  /// Type of media translations found in TMDB
  /// </summary>
  TTMDBTranslationType =  (ttMovie, ttCollection, ttPerson, ttTVSeries,
    ttTVSeason, ttTVEpisode);

  /// <summary>
  /// Type of list content found in TMDB
  /// </summary>
  TTMDBListType = (ltMovie, ltTVSeries, ltTVSeason, ltTVEpisode, ltPerson);

  /// <summary>
  /// Type of media release as defined in TMDB
  /// </summary>
  TTMDBReleaseType = (rtUnknown = 0, rtPremiere = 1, rtTheatricalLimited = 2,
    rtTheatrical = 3, rtDigital = 4, rtPhysical = 5, rtTV = 6);

  /// <summary>
  /// Type of credit as defined in TMDB
  /// </summary>
  TTMDBCreditType = (ctCast, ctCrew);

  /// <summary>
  /// Gender of a person as defined in TMDB
  /// </summary>
  TTMDBGender = (gNotSpecified = 0, gFemale = 1, gMale = 2, gNonBinary = 3);

  /// <summary>
  /// Type of episode group as defined in TMDB
  /// </summary>
  TTMDBEpisodeGroupType = (gtOrigAirDate = 1, gtAbsolute = 2, gtDVD = 3, gtDigital = 4,
    gtStoryArc = 5, gtProduction = 6, gtTV = 7);

  /// <summary>
  /// Type of episode group
  /// </summary>
  TTMDBTVEpisodeGroupType = (egtUnknown = 0, egtOriginalAirDate = 1,
    egtAbsolute = 2, egtDVD = 3, egtDigital = 4, egtStoryArc = 5,
    egtProduction = 6, egtTV = 7);

  /// <summary>
  /// Set of TTMDBEpisodeGroupType to define the type of episode group object.
  /// </summary>
  TTMDBTVEpisodeGroupTypes = set of TTMDBTVEpisodeGroupType;

  /// <summary>
  ///
  /// </summary>
  TTMDBTimeWindow = (twDay, twWeek);

  /// <summary>
  ///
  /// </summary>
  TTMDBChangeAction = (caCreated, caUpdated, caDeleted);






{ Append To Result Related }

type

  /// <summary>
  /// Type of movie details that can be returned with AppendToResponse
  /// </summary>
  TTMDBMovieRequest = (mrAccountStates, mrAlternativeTitles, mrChanges, mrCredits,
    mrExternalIDs, mrImages, mrKeywords, mrLists, mrRecommendations,
    mrReleaseDates, mrReviews, mrSimilar, mrTranslations, mrVideos);
  /// <summary>
  /// Set of TTMDBMovieRequest to define what to return with AppendToResponse
  /// </summary>
  TTMDBMovieRequests = set of TTMDBMovieRequest;

  TTMDBTVSeriesRequest = (trAccountStates, trAggregateCredits, trAlternativeTitles,
    trChanges, trContentRatings, trCredits, trEpisodeGroups, trExternalIDs,
    trImages, trKeywords, trLists, trRecommendations, trReviews, trScreenedTheatrically,
    trSimilar, trTranslations, trVideos);
  TTMDBTVSeriesRequests = set of TTMDBTVSeriesRequest;

  TTMDBTVSeasonRequest = (tsrAccountStates, tsrAggregateCredits, tsrChanges, tsrCredits,
    tsrExternalIDs, tsrImages, tsrTranslations, tsrVideos);
  TTMDBTVSeasonRequests = set of TTMDBTVSeasonRequest;

  TTMDBTVEpisodeRequest = (terAccountStates, terChanges, terCredits, terExternalIDs,
    terImages, terTranslations, terVideos);
  TTMDBTVEpisodeRequests = set of TTMDBTVEpisodeRequest;

  TTMDBPersonRequest = (prChanges, prCombinedCredits, prEdternalIDs, prImages,
    prMovieCredits, prTVCredits, prTranslations);
  TTMDBPersonRequests = set of TTMDBPersonRequest;

const

  TMDB_MOVIE_REQUEST: Array of WideString = ['account_states', 'alternative_titles',
    'changes', 'credits', 'external_ids', 'images', 'keywords', 'lists',
    'recommendations', 'release_dates', 'reviews', 'similar', 'translations',
    'videos'];

  TMDB_TV_SERIES_REQUEST: Array of WideString = ['account_states', 'aggregate_credits',
    'alternative_titles', 'changes', 'content_ratings', 'credits', 'episode_groups',
    'external_ids', 'images', 'keywords', 'lists', 'recommendations', 'reviews',
    'screened_theatrically', 'similar', 'translations', 'videos'];

  TMDB_TV_SEASON_REQUEST: Array of WideString = ['account_states', 'aggregate_credits',
    'changes', 'credits', 'external_ids', 'images', 'translations', 'videos'];

  TMDB_TV_EPISODE_REQUEST: Array of WideString = ['account_states', 'changes',
    'credits', 'external_ids', 'images', 'translations', 'videos'];

  TMDB_PERSON_REQUEST: Array of WideString = ['changes', 'combined_credits',
    'external_ids', 'images', 'movie_credits', 'tv_credits', 'translations'];






//Similar to TPath.Combine but more general-purpose
function URLCombine(P1, P2: String; const Delim: String = '/'): String; overload;
function URLCombine(P1, P2: Integer; const Delim: String = '/'): String; overload;
function URLCombine(P1: String; P2: Integer; const Delim: String = '/'): String; overload;
function URLCombine(P1: Integer; P2: String; const Delim: String = '/'): String; overload;

//Convert JSON in ISuperArray to String Array or Integer Array
function JSONToStrArray(Arr: ISuperArray): TTMDBStrArray;
function JSONToIntArray(Arr: ISuperArray): TTMDBIntArray;

//Convert a date from string to TDateTime
function TMDBConvertDate(const S: String): TDateTime;

function TMDBDateTimeToStr(const AValue: TDateTime): String;

function TMDBStrArrayToStr(const AValue: TTMDBStrArray): String;

function TMDBBoolToStr(const AValue: TTMDBBoolean): String;

function TMDBListTypeToStr(const AListType: TTMDBListType): String;
function TMDBStrToListType(const AListType: String): TTMDBListType;

function TMDBAuthMethodToStr(const AAuthMethod: TTMDBAuthMethod): WideString;
function TMDBStrToAuthMethod(const AAuthMethod: WideString): TTMDBAuthMethod;

function TMDBUserAuthToStr(const AUserAuth: TTMDBUserAuth): WideString;
function TMDBStrToUserAuth(const AUserAuth: WideString): TTMDBUserAuth;

function TMDBMediaTypeToStr(const AMediaType: TTMDBMediaType): WideString;
function TMDBStrToMediaType(const AMediaType: WideString): TTMDBMediaType;

function TMDBGenderToStr(const AGender: TTMDBGender): WideString;
function TMDBStrToGender(const AGender: WideString): TTMDBGender;

function TMDBMovieRequestToStr(const AValue: TTMDBMovieRequest): WideString;
function TMDBStrToMovieRequest(const AValue: WideString): TTMDBMovieRequest;

function TMDBReleaseTypeToStr(const AValue: TTMDBReleaseType): String;

function TMDBStrToCreditType(const AValue: WideString): TTMDBCreditType;

//Append to Result Related
function TMDBMovieRequestsToStr(const AValue: TTMDBMovieRequests): WideString;
function TMDBTVSeriesRequestsToStr(const AValue: TTMDBTVSeriesRequests): WideString;
function TMDBTVSeasonRequestsToStr(const AValue: TTMDBTVSeasonRequests): WideString;
function TMDBTVEpisodeRequestsToStr(const AValue: TTMDBTVEpisodeRequests): WideString;
function TMDBPersonRequestsToStr(const AValue: TTMDBPersonRequests): WideString;

implementation

{ ETMDBException }

constructor ETMDBException.Create(const Msg: String; const ErrCode,
  HttpCode: Integer);
begin
  inherited Create(Msg);
  FCode:= ErrCode;
  FHttpCode:= HttpCode;
end;

{ General }

function TMDBListTypeToStr(const AListType: TTMDBListType): String;
begin
  //TTMDBListType = (ltMovie, ltTVSeries, ltTVSeason, ltTVEpisode, ltPerson);
  case AListType of
    ltMovie:      Result:= 'movie';
    ltTVSeries:   Result:= 'tv_series';
    ltTVSeason:   Result:= 'tv_season';
    ltTVEpisode:  Result:= 'tv_episode';
    ltPerson:     Result:= 'person';
  end;
end;

function TMDBStrToListType(const AListType: String): TTMDBListType;
  procedure Chk(const T: TTMDBListType; const S: String);
  begin
    if AListType = S then
      Result:= T;
  end;
begin
  Result:= ltMovie;
  Chk(ltMovie, 'movie');
  Chk(ltTVSeries, 'tv_series');
  Chk(ltTVSeason, 'tv_season');
  Chk(ltTVEpisode, 'tv_episode');
  Chk(ltPerson, 'person');
end;

function JSONToStrArray(Arr: ISuperArray): TTMDBStrArray;
var
  X: Integer;
begin
  SetLength(Result, Arr.Length);
  for X := 0 to Arr.Length-1 do begin
    Result[X]:= Arr.S[X];
  end;
end;

function JSONToIntArray(Arr: ISuperArray): TTMDBIntArray;
var
  X: Integer;
begin
  SetLength(Result, Arr.Length);
  for X := 0 to Arr.Length-1 do begin
    Result[X]:= Arr.I[X];
  end;
end;

function TMDBStrArrayToStr(const AValue: TTMDBStrArray): String;
var
  X: Integer;
begin
  Result:= '';
  for X := 0 to Length(AValue)-1 do begin
    if Result <> '' then
      Result:= Result + ', ';
    Result:= Result + AValue[X];
  end;
end;

function TMDBBoolToStr(const AValue: TTMDBBoolean): String;
begin
  case AValue of
    bFalse: Result:= 'false';
    bTrue:  Result:= 'true';
    else    Result:= '';
  end;
end;

function TMDBConvertDate(const S: String): TDateTime;
var
  F: TFormatSettings;
begin
  F:= TFormatSettings.Create;
  F.ShortDateFormat:= 'yyyy-mm-dd';
  F.ShortTimeFormat:= 'hh:nn:ss.zzz';
  F.DateSeparator:= '-';
  F.TimeSeparator:= ':';
  Result:= StrToDateTimeDef(S, 0, F);
end;

function TMDBDateTimeToStr(const AValue: TDateTime): String;
begin
  if AValue > 0 then
    Result:= FormatDateTime('yyyy-mm-dd', AValue)
  else
    Result:= '(Not Specified)';
end;

function TMDBAuthMethodToStr(const AAuthMethod: TTMDBAuthMethod): WideString;
begin
  case AAuthMethod of
    amAPIKey: Result:= 'API Key';
    amAccessToken: Result:= 'Access Token';
  end;
end;

function TMDBStrToAuthMethod(const AAuthMethod: WideString): TTMDBAuthMethod;
  procedure Chk(const S: String; const T: TTMDBAuthMethod);
  begin
    if SameText(AAuthMethod, S) then
      Result:= T;
  end;
begin
  Chk('API Key', amAPIKey);
  Chk('Key', amAPIKey);
  Chk('Access Token', amAccessToken);
  Chk('Token', amAccessToken);
end;

function TMDBUserAuthToStr(const AUserAuth: TTMDBUserAuth): WideString;
begin
  case AUserAuth of
    uaUnauthorized: Result:= 'Unauthorized';
    uaGuest: Result:= 'Guest';
    uaNormal: Result:= 'Normal';
    uaCredentials: Result:= 'Credentials';
  end;
end;

function TMDBStrToUserAuth(const AUserAuth: WideString): TTMDBUserAuth;
  procedure Chk(const S: String; const T: TTMDBUserAuth);
  begin
    if SameText(AUserAuth, S) then
      Result:= T;
  end;
begin
  Chk('Unauthorized', uaUnauthorized);
  Chk('Guest', uaGuest);
  Chk('Normal', uaNormal);
  Chk('Credentials', uaCredentials);
end;

function TMDBMediaTypeToStr(const AMediaType: TTMDBMediaType): WideString;
begin
  case AMediaType of
    mtUnspecified: Result:= '(Unspecified)';
    mtMovie: Result:= 'Movie';
    mtTV: Result:= 'TV';
    mtPerson: Result:= 'Person';
  end;
end;

function TMDBStrToMediaType(const AMediaType: WideString): TTMDBMediaType;
  procedure Chk(const S: String; const T: TTMDBMediaType);
  begin
    if SameText(AMediaType, S) then
      Result:= T;
  end;
begin
  Chk('movie', mtMovie);
  Chk('tv', mtTV);
  Chk('person', mtPerson);
  Chk('(Unspecified)', mtUnspecified);
  Chk('Unspecified', mtUnspecified);
  Chk('', mtUnspecified);
end;

function TMDBGenderToStr(const AGender: TTMDBGender): WideString;
begin
  case AGender of
    gNotSpecified: Result:= 'Not Specified';
    gFemale: Result:= 'Female';
    gMale: Result:= 'Male';
    gNonBinary: Result:= 'Non-Binary';
  end;
end;

function TMDBStrToGender(const AGender: WideString): TTMDBGender;
  procedure Chk(const S: String; const T: TTMDBGender);
  begin
    if SameText(AGender, S) then
      Result:= T;
  end;
begin
  Chk('', gNotSpecified);
  Chk('Not Specified', gNotSpecified);
  Chk('Unspecified', gNotSpecified);
  Chk('Unknown', gNotSpecified);
  Chk('Female', gFemale);
  Chk('F', gFemale);
  Chk('Male', gMale);
  Chk('M', gMale);
  Chk('Non-Binary', gNonBinary);
  Chk('Non Binary', gNonBinary);
  Chk('NonBinary', gNonBinary);
end;

function TMDBMovieRequestToStr(const AValue: TTMDBMovieRequest): WideString;
begin
  Result:= TMDB_MOVIE_REQUEST[Integer(AValue)];
end;

function TMDBStrToMovieRequest(const AValue: WideString): TTMDBMovieRequest;
var
  X: Integer;
begin
  Result:= TTMDBMovieRequest.mrAccountStates;
  for X := 0 to Length(TMDB_MOVIE_REQUEST)-1 do begin
    if SameText(AValue, TMDB_MOVIE_REQUEST[X]) then begin
      Result:= TTMDBMovieRequest(X);
    end;
  end;
end;

function TMDBStrToCreditType(const AValue: WideString): TTMDBCreditType;
  procedure Chk(const S: String; const T: TTMDBCreditType);
  begin
    if SameText(AValue, S) then
      Result:= T;
  end;
begin
  Chk('cast', ctCast);
  Chk('crew', ctCrew);
end;

function URLCombine(P1, P2: String; const Delim: String = '/'): String;
var
  T: String;
begin
  //Last char of P1 - no delimiter
  T:= Copy(P1, Length(P1), 1);
  if T = Delim then
    Delete(P1, Length(P1), 1);
  //First char of P2 - with delimiter
  T:= Copy(P2, 1, 1);
  if T <> Delim then
    P2:= Delim + P2;
  //Combine both strings
  Result:= Concat(P1, P2);
end;

function URLCombine(P1: String; P2: Integer; const Delim: String = '/'): String;
begin
  Result:= URLCombine(P1, IntToStr(P2));
end;

function URLCombine(P1: Integer; P2: String; const Delim: String = '/'): String;
begin
  Result:= URLCombine(IntToStr(P1), P2);
end;

function URLCombine(P1, P2: Integer; const Delim: String = '/'): String;
begin
  Result:= URLCombine(IntToStr(P1), P2);
end;

function TMDBReleaseTypeToStr(const AValue: TTMDBReleaseType): String;
begin
  case AValue of
    rtUnknown: Result:= 'Unknown';
    rtPremiere: Result:= 'Premier';
    rtTheatricalLimited: Result:= 'Theatrical (Limited)';
    rtTheatrical: Result:= 'Theatrical';
    rtDigital: Result:= 'Digital';
    rtPhysical: Result:= 'Physical';
    rtTV: Result:= 'TV';
  end;
end;

function TMDBMovieRequestsToStr(const AValue: TTMDBMovieRequests): WideString;
var
  R: TTMDBMovieRequest;
begin
  Result:= '';
  for R in AValue do begin
    if Result <> '' then
      Result:= Result + ',';
    Result:= Result + TMDB_MOVIE_REQUEST[Integer(R)];
  end;
end;

function TMDBTVSeriesRequestsToStr(const AValue: TTMDBTVSeriesRequests): WideString;
var
  R: TTMDBTVSeriesRequest;
begin
  Result:= '';
  for R in AValue do begin
    if Result <> '' then
      Result:= Result + ',';
    Result:= Result + TMDB_TV_SERIES_REQUEST[Integer(R)];
  end;
end;

function TMDBTVSeasonRequestsToStr(const AValue: TTMDBTVSeasonRequests): WideString;
var
  R: TTMDBTVSeasonRequest;
begin
  Result:= '';
  for R in AValue do begin
    if Result <> '' then
      Result:= Result + ',';
    Result:= Result + TMDB_TV_SEASON_REQUEST[Integer(R)];
  end;
end;

function TMDBTVEpisodeRequestsToStr(const AValue: TTMDBTVEpisodeRequests): WideString;
var
  R: TTMDBTVEpisodeRequest;
begin
  Result:= '';
  for R in AValue do begin
    if Result <> '' then
      Result:= Result + ',';
    Result:= Result + TMDB_TV_EPISODE_REQUEST[Integer(R)];
  end;
end;

function TMDBPersonRequestsToStr(const AValue: TTMDBPersonRequests): WideString;
var
  R: TTMDBPersonRequest;
begin
  Result:= '';
  for R in AValue do begin
    if Result <> '' then
      Result:= Result + ',';
    Result:= Result + TMDB_PERSON_REQUEST[Integer(R)];
  end;
end;

end.
