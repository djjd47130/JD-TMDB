unit JD.TMDB.Common;

interface

uses
  Types, SysUtils,
  XSuperObject;

{ TMDB Error Code Constants }

const
  TMDB_API_ROOT = 'https://api.themoviedb.org/3/';
  TMDB_API_USERAGENT = 'JD TMDB API Wrapper for Delphi (https://github.com/djjd47130/JD-TMDB)';

  //TMDB Error Codes
  TMDB_ERR_SUCCESS = 1;
  TMDB_ERR_INVALID_SERVICE = 2;
  TMDB_ERR_AUTH_FAILED = 3;
  TMDB_ERR_INVALID_FORMAT = 4;
  //TODO: All the way to code 47...


type

  { Common Types }

  /// <summary>
  /// Array of String, as used across TMDB library.
  /// </summary>
  TTMDBStrArray = TArray<WideString>;

  /// <summary>
  /// Array of Integer, as used across TMDB library.
  /// </summary>
  TTMDBIntArray = TArray<Integer>;



  { Common Enum / Set Types }

  /// <summary>
  /// Application / API Authentication Method
  /// </summary>
  TTMDBAuthMethod = (amAPIKey, amAccessToken);

  /// <summary>
  /// TMDB user Account Authentication
  /// </summary>
  TTMDBUserAuth = (uaUnauthorized, uaGuest, uaNormal, uaCredentials);

  /// <summary>
  /// Type of media content found in TMDB
  /// </summary>
  TTMDBMediaType = (mtMovie, mtTV, mtPerson);

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







{ Append To Result Related }

type

  /// <summary>
  /// Type of movie details that can be returned with AppendToResponse
  /// TODO: Some use pagination...
  /// </summary>
  TTMDBMovieRequest = (mrAccountStates, mrAlternativeTitles, mrChanges, mrCredits,
    mrExternalIDs, mrImages, mrKeywords, mrLists, mrRecommendations,
    mrReleaseDates, mrReviews, mrSimilar, mrTranslations, mrVideos);
  /// <summary>
  /// Set of TTMDBMovieRequest to define what to return with AppendToResponse
  /// </summary>
  TTMDBMovieRequests = set of TTMDBMovieRequest;

  TTMDBTVRequest = (trAccountStates, trAggregateCredits, trAlternativeTitles,
    trChanges, trContentRatings, trCredits, trEpisodeGroups, trExternalIDs,
    trImages, trKeywords, trLists, trRecommendations, trReviews, trScreenedTheatrically,
    trSimilar, trTranslations, trVideos);
  TTMDBTVRequests = set of TTMDBTVRequest;

  TTMDBPersonRequest = (prChanges, prCombinedCredits, prEdternalIDs, prImages,
    prMovieCredits, prTVCredits, prTranslations);
  TTMDBPersonRequests = set of TTMDBPersonRequest;

const

  TMDB_MOVIE_REQUEST: Array of WideString = ['account_states', 'alternative_titles',
    'changes', 'credits', 'external_ids', 'images', 'keywords', 'lists',
    'recommendations', 'release_dates', 'reviews', 'similar', 'translations',
    'videos'];

  TMDB_TV_REQUEST: Array of WideString = ['account_states', 'aggregate_credits',
    'alternative_titles', 'changes', 'content_ratings', 'credits', 'episode_groups',
    'external_ids', 'images', 'keywords', 'lists', 'recommendations', 'reviews',
    'screened_theatrically', 'similar', 'translations', 'videos'];

  TMDB_PERSON_REQUEST: Array of WideString = ['changes', 'combined_credits',
    'external_ids', 'images', 'movie_credits', 'tv_credits', 'translations'];





function JSONToStrArray(Arr: ISuperArray): TTMDBStrArray;
function JSONToIntArray(Arr: ISuperArray): TTMDBIntArray;

function ConvertDate(const S: String): TDateTime;
function ConvertDateTime(const S: String): TDateTime;

function TMDBStrArrayToStr(const AValue: TTMDBStrArray): String;

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

function TMDBMovieRequestsToStr(const AValue: TTMDBMovieRequests): WideString;

function URLCombine(P1, P2: String; const Delim: String = '/'): String; overload;
function URLCombine(P1, P2: Integer; const Delim: String = '/'): String; overload;
function URLCombine(P1: String; P2: Integer; const Delim: String = '/'): String; overload;
function URLCombine(P1: Integer; P2: String; const Delim: String = '/'): String; overload;

function TMDBReleaseTypeToStr(const AValue: TTMDBReleaseType): String;

implementation

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

function ConvertDate(const S: String): TDateTime;
var
  F: TFormatSettings;
begin
  F:= TFormatSettings.Create;
  F.ShortDateFormat:= 'yyyy-mm-dd';
  F.DateSeparator:= '-';
  F.TimeSeparator:= ':';
  Result:= StrToDateTimeDef(S, 0, F);
end;

function ConvertDateTime(const S: String): TDateTime;
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
    mtMovie: Result:= 'movie';
    mtTV: Result:= 'tv';
    mtPerson: Result:= 'person';
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

end.
