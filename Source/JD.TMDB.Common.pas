unit JD.TMDB.Common;

interface

uses
  Types, SysUtils,
  XSuperObject;

{ TMDB Error Code Constants }

const
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
function ConvertDateTime(const S: String): TDateTime;

implementation

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

function ConvertDateTime(const S: String): TDateTime;
var
  F: TFormatSettings;
begin
  F:= TFormatSettings.Create;
  F.ShortDateFormat:= 'yyyy-mm-dd';
  F.DateSeparator:= '-';
  F.TimeSeparator:= ':';
  Result:= StrToDateTimeDef(S, 0, F);
end;

end.
