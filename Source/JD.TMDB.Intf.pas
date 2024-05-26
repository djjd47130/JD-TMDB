unit JD.TMDB.Intf;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  TMDB Object Interface Definitions

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils,
  XSuperObject;

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
  /// Type of media release.
  /// </summary>
  TTMDBReleaseType = (rtUnknown = 0, rtPremiere = 1, rtTheatricalLimited = 2,
    rtTheatrical = 3, rtDigital = 4, rtPhysical = 5, rtTV = 6);

  TTMDBGender = (gNotSpecified = 0, gFemale = 1, gMale = 2, gNonBinary = 3);

  TTMDBAPIEpisodeGroupType = (gtOrigAirDate = 1, gtAbsolute = 2, gtDVD = 3, gtDigital = 4,
    gtStoryArc = 5, gtProduction = 6, gtTV = 7);



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

const

  TMDB_MOVIE_REQUEST: Array of WideString = ['account_states', 'alternative_titles',
    'changes', 'credits', 'external_ids', 'images', 'keywords', 'lists',
    'recommendations', 'release_dates', 'reviews', 'similar', 'translations',
    'videos'];



type

  TTMDBTVRequest = (trAccountStates, trAggregateCredits, trAlternativeTitles,
    trChanges, trContentRatings, trCredits, trEpisodeGroups, trExternalIDs,
    trImages, trKeywords, trLists, trRecommendations, trReviews, trScreenedTheatrically,
    trSimilar, trTranslations, trVideos);

  TTMDBTVRequests = set of TTMDBTVRequest;

const

  TMDB_TV_REQUEST: Array of WideString = ['account_states', 'aggregate_credits',
    'alternative_titles', 'changes', 'content_ratings', 'credits', 'episode_groups',
    'external_ids', 'images', 'keywords', 'lists', 'recommendations', 'reviews',
    'screened_theatrically', 'similar', 'translations', 'videos'];



type

  TTMDBPersonRequest = (pr);

  TTMDBPersonRequests = set of TTMDBPersonRequest;



type

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







////////////////////////////////////////////////////////////////////////////////







type

  { Forward Definitions }

  ITMDBPage = interface;

  ITMDBPageItem = interface;

  ITMDBAccountDetail = interface;

  ITMDBAccountAddFavoriteResult = interface;

  ITMDBAccountAddWatchlistResult = interface;

  ITMDBAuthGuestSessionResult = interface;

  ITMDBAuthRequestTokenResult = interface;

  ITMDBAuthSessionResult = interface;

  ITMDBAuthSessionResultLogin = interface;

  ITMDBAuthDeleteSessionResult = interface;

  ITMDBAuthValidateKeyResult = interface;

  ITMDBCertificationItem = interface;

  ITMDBCertificationCountry = interface;

  ITMDBCertificationCountries = interface;

  ITMDBChangeValue = interface;

  ITMDBChangeRecord = interface;

  ITMDBChangeItem = interface;

  ITMDBChangePage = interface;

  ITMDBCollectionPage = interface;

  ITMDBCollectionItem = interface;

  ITMDBCompanyItem = interface;

  ITMDBCompanyList = interface;

  ITMDBConfigurationImages = interface;

  ITMDBConfiguration = interface;

  ITMDBCountryList = interface;

  ITMDBCountryItem = interface;

  ITMDBJobDepartmentItem = interface;

  ITMDBJobDepartmentList = interface;

  ITMDBLanguageList = interface;

  ITMDBLanguageItem = interface;

  ITMDBTimezoneItem = interface;

  ITMDBTimezoneList = interface;

  ITMDBCredits = interface;

  ITMDBGenreList = interface;

  ITMDBGenreItem = interface;

  ITMDBKeywordItem = interface;

  ITMDBPersonItem = interface;

  ITMDBPersonPage = interface;

  ITMDBMovieItem = interface;

  ITMDBMoviePage = interface;

  ITMDBRatedMovieItem = interface;

  ITMDBRatedMoviePage = interface;

  ITMDBMovieCollectionRef = interface;

  ITMDBMovieDetail = interface;

  ITMDBTVNetworkItem = interface;

  //ITMDBNetworkList = interface;

  //ITMDBNetworkDetail = interface;

  ITMDBTVPage = interface;

  ITMDBTVItem = interface;

  ITMDBTVEpisodePage = interface;

  ITMDBTVEpisodeItem = interface;

  ITMDBRatedTVPage = interface;

  ITMDBRatedTVItem = interface;

  ITMDBRatedTVEpisodePage = interface;

  ITMDBRatedTVEpisodeItem = interface;

  ITMDBTVSeriesPage = interface;

  ITMDBTVSeriesItem = interface;

  ITMDBTVSeriesDetail = interface;

  ITMDBTVSeasonPage = interface;

  ITMDBTVSeasonItem = interface;

  ITMDBTVEpisodeGroupResponse = interface;

  //ITMDBTVEpisodeGroup = interface;

  //ITMDBTVEpisodeGroupItem = interface;

  ITMDBListPage = interface;

  ITMDBListPageItem = interface;

  ITMDBDiscoverMoviePage = interface;

  ITMDBDiscoverMovieItem = interface;

  ITMDBDiscoverTVPage = interface;

  ITMDBDiscoverTVItem = interface;

  ITMDBItemList = interface;

  ITMDBMovieList = interface;

  ITMDBPersonList = interface;

  ITMDBTVList = interface;

  ITMDBTVEpisodeList = interface;

  ITMDBFindResults = interface;







////////////////////////////////////////////////////////////////////////////////







  { Pagination Related }

  /// <summary>
  /// A single page of results, following TMDB's pagination standards.
  /// [DONE]
  /// </summary>
  ITMDBPage = interface
    ['{F95555BF-1E0C-4E95-AE81-93A09EFA4EA3}']
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem; stdcall;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
  end;

  /// <summary>
  /// A single item found on a page of results, following TMDB's pagination standards.
  /// [DONE]
  /// </summary>
  ITMDBPageItem = interface
    ['{9909E734-78DB-4CBB-B84D-A8E16315DA4E}']
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;

    property Owner: ITMDBPage read GetOwner;
    property Index: Integer read GetIndex;
  end;

  /// <summary>
  /// Base for each list of items
  /// [DONE]
  /// </summary>
  ITMDBItemList = interface
    ['{3159DDC3-F510-4353-B24A-ACFD459948C9}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
  end;



  { Account Related }

  /// <summary>
  /// The details of a given user account.
  /// [DONE]
  /// </summary>
  ITMDBAccountDetail = interface
    ['{DE0E4519-BED8-4218-BE84-A4C0AC5C6DBD}']
    function GetID: Integer; stdcall;
    function GetUserName: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetIncludeAdult: Boolean; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetLanguageCode: WideString; stdcall;
    function GetGravatarHash: WideString; stdcall;
    function GetTMDBAvatarPath: WideString; stdcall;

    property ID: Integer read GetID;
    property UserName: WideString read GetUserName;
    property Name: WideString read GetName;
    property IncludeAdult: Boolean read GetIncludeAdult;
    property CountryCode: WideString read GetCountryCode;
    property LanguageCode: WideString read GetLanguageCode;
    property GravatarHash: WideString read GetGravatarHash;
    property TMDBAvatarPath: WideString read GetTMDBAvatarPath;
  end;

  /// [DONE]
  ITMDBAccountAddFavoriteResult = interface
    ['{03377611-F4BC-4FF1-A446-0AEE7A8878BA}']
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  /// [DONE]
  ITMDBAccountAddWatchlistResult = interface
    ['{03DDF702-8AE6-48A6-AB10-75468CC9CE51}']
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;



  { Authentication Related }

  /// <summary>
  /// The result of creating a new guest session.
  /// [DONE]
  /// </summary>
  ITMDBAuthGuestSessionResult = interface
    ['{4C790F86-60C7-4C4E-ACF0-D6C2FB5E3534}']
    function GetSuccess: Boolean; stdcall;
    function GetGuestSessionID: WideString; stdcall;
    function GetExpiresAt: TDateTime; stdcall;

    property Success: Boolean read GetSuccess;
    property GuestSessionID: WideString read GetGuestSessionID;
    property ExpiresAt: TDateTime read GetExpiresAt;
  end;

  /// <summary>
  /// The result of creating a new request token.
  /// [DONE]
  /// </summary>
  ITMDBAuthRequestTokenResult = interface
    ['{84A78372-DE91-4D30-89AD-8DCA3B3A2871}']
    function GetSuccess: Boolean; stdcall;
    function GetRequestToken: WideString; stdcall;
    function GetExpiresAt: TDateTime; stdcall;

    property Success: Boolean read GetSuccess;
    property RequestToken: WideString read GetRequestToken;
    property ExpiresAt: TDateTime read GetExpiresAt;
  end;

  /// <summary>
  /// The result of creating a new user session.
  /// [DONE]
  /// </summary>
  ITMDBAuthSessionResult = interface
    ['{5671A7BD-6B4E-49AB-8AA9-237C7FC42E02}']
    function GetSuccess: Boolean; stdcall;
    function GetSessionID: WideString; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property SessionID: WideString read GetSessionID;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of creating a new user session using user credentials.
  /// [DONE]
  /// </summary>
  ITMDBAuthSessionResultLogin = interface
    ['{7744853D-5EC2-4B0B-9207-9008BAC2D12E}']
    function GetSuccess: Boolean; stdcall;
    function GetExpiresAt: TDateTime; stdcall;
    function GetRequestToken: WideString; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property ExpiresAt: TDateTime read GetExpiresAt;
    property RequestToken: WideString read GetRequestToken;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessag: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of deleting a user session (or "logging out").
  /// [DONE]
  /// </summary>
  ITMDBAuthDeleteSessionResult = interface
    ['{7857764E-1768-4755-B794-D71411E38A7A}']
    function GetSuccess: Boolean; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessag: WideString read GetStatusMessage;
  end;

  /// <summary>
  /// The result of validating the API Key / Application authentication
  /// [DONE]
  /// </summary>
  ITMDBAuthValidateKeyResult = interface
    ['{5EF18F33-1051-4A4A-A779-2D63FEA70F30}']
    function GetSuccess: Boolean; stdcall;
    function GetStatusCode: Integer; stdcall;
    function GetStatusMessage: WideString; stdcall;

    property Success: Boolean read GetSuccess;
    property StatusCode: Integer read GetStatusCode;
    property StatusMessage: WideString read GetStatusMessage;
  end;



  { Certifications Related }

  /// [DONE]
  ITMDBCertificationItem = interface
    ['{02B6525F-7A01-4FDC-B39F-2F276D999827}']
    function GetCertification: WideString; stdcall;
    function GetMeaning: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    property Certification: WideString read GetCertification;
    property Meaning: WideString read GetMeaning;
    property Order: Integer read GetOrder;
  end;

  /// [DONE]
  ITMDBCertificationCountry = interface
    ['{4BE1C674-3BFE-464D-8595-67567687A7E3}']
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertificationItem; stdcall;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBCertificationCountries = interface
    ['{F907A3E0-B9A4-45B8-A7BC-B10FEC984CEF}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCertificationCountry; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCertificationCountry read GetItem; default;
  end;



  { Changes Related }

  //TODO: This is quite a complex structure, because the data types dynamically differ
  //  depending on the type of change...
  //https://developer.themoviedb.org/docs/tracking-content-changes

  //TODO: Confusion between structure of object in "Chages" namespace and
  //  "Changes" request in specific namespaces...

  ITMDBChangeValue = interface
    ['{D44D0AA2-5EB9-458F-A0CD-FFCE923C571A}']
    function GetKey: WideString;
    function GetS: WideString;
    function GetI: Integer;
    function GetB: Boolean;
    function GetF: Double;
    function GetD: TDateTime;
    function GetO: ISuperObject;
    function GetA: ISuperArray;

    //TODO: Properties...
  end;

  ITMDBChangeRecord = interface
    ['{27B8CA5E-D72C-4298-92D9-012A58450CAA}']
    function GetID: WideString;
    function GetAction: WideString; //TODO: Change to enum...
    function GetTime: TDateTime;
    function GetISO639_1: WideString;
    function GetISO3166_1: WideString;
    function GetValue: ITMDBChangeValue;

    //TODO: Properties...
  end;

  ITMDBChangeItem = interface(ITMDBPageItem)
    ['{04186AE5-0DFE-4E30-99A8-8B8CBC98E17F}']
    function GetKey: WideString; stdcall;
    function GetItem(const Index: Integer): ITMDBChangeRecord; stdcall;

  end;

  ITMDBChangePage = interface(ITMDBPage)
    ['{EEBB8A61-5597-4B56-B8AF-82E3C1F54F75}']
    function GetItem(const Index: Integer): ITMDBChangeItem; stdcall;

    property Items[const Index: Integer]: ITMDBChangeItem read GetItem; default;
  end;



  { Collections Related }

  ITMDBCollectionPage = interface(ITMDBPage)
    ['{7A7ADCD0-8062-4CF3-8D07-903DCCDA42E8}']

  end;

  ITMDBCollectionItem = interface(ITMDBPageItem)
    ['{C0911ACB-C909-438A-8DC3-5A67E5F4CB4F}']

  end;



  { Companies Related }

  ITMDBCompanyItem = interface
    ['{491A255A-0E29-43B3-8AAC-5F727D74DD98}']

  end;

  ITMDBCompanyList = interface
    ['{BF6B6EC5-C0E1-4D7B-B987-8F2BE6AD4211}']

  end;




  { Configuration Related }

  /// <summary>
  /// The "Images" section of system configuration.
  /// [DONE]
  /// </summary>
  ITMDBConfigurationImages = interface
    ['{E258E153-9527-4993-B9B9-4E8A1513D84D}']
    function GetBaseURL: WideString; stdcall;
    function GetSecureBaseURL: WideString; stdcall;
    function GetBackdropSizes: TTMDBStrArray; stdcall;
    function GetLogoSizes: TTMDBStrArray; stdcall;
    function GetPosterSizes: TTMDBStrArray; stdcall;
    function GetProfileSizes: TTMDBStrArray; stdcall;
    function GetStillSizes: TTMDBStrArray; stdcall;

    property BaseURL: WideString read GetBaseURL;
    property SecureBaseURL: WideString read GetSecureBaseURL;
    property BackdropSizes: TTMDBStrArray read GetBackdropSizes;
    property LogoSizes: TTMDBStrArray read GetLogoSizes;
    property PosterSizes: TTMDBStrArray read GetPosterSizes;
    property ProfileSizes: TTMDBStrArray read GetProfileSizes;
    property StillSizes: TTMDBStrArray read GetStillSizes;
  end;

  /// <summary>
  /// The result of base system configuration.
  /// [DONE]
  /// </summary>
  ITMDBConfiguration = interface
    ['{F8527F61-7BE9-47D7-997D-C8FDCF54CEE0}']
    function GetImages: ITMDBConfigurationImages; stdcall;
    function GetChangeKeys: TTMDBStrArray; stdcall;

    property Images: ITMDBConfigurationImages read GetImages;
    property ChangeKeys: TTMDBStrArray read GetChangeKeys;
  end;

  { Countries Related }

  /// <summary>
  /// A list containing all possible countries supported by TMDB.
  /// [DONE]
  /// </summary>
  ITMDBCountryList = interface
    ['{A1081041-E5B2-46C4-9905-EF7984C45FCA}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCountryItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCountryItem read GetItem; default;
  end;

  /// <summary>
  /// A single country record within ITMDBCountryList.
  /// [DONE]
  /// </summary>
  ITMDBCountryItem = interface
    ['{8E894D16-379C-431B-9F27-6FBB80F761B0}']
    function GetISO3166_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetNativeName: WideString; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property EnglishName: WideString read GetEnglishName;
    property NativeName: WideString read GetNativeName;
  end;

  { Jobs / Departments Related }

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBJobDepartmentList = interface
    ['{2B9A1DF6-2CA9-48E2-886C-179F7F92383C}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBJobDepartmentItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBJobDepartmentItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBJobDepartmentItem = interface
    ['{847352D6-4054-4E62-897C-258305FBEDE2}']
    function GetDepartment: WideString; stdcall;
    function GetJobs: TTMDBStrArray; stdcall;

    property Department: WideString read GetDepartment;
    property Jobs: TTMDBStrArray read GetJobs;
  end;

  { Languages Related }

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBLanguageList = interface
    ['{B08908B7-3C02-4BF9-8B94-AECF0EEC8D49}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBLanguageItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBLanguageItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBLanguageItem = interface
    ['{CBEECBBE-5CBE-4592-9C65-B82F1D07CCF7}']
    function GetISO639_1: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetName: WideString; stdcall;

    property ISO639_1: WideString read GetISO639_1;
    property EnglishName: WideString read GetEnglishName;
    property Name: WideString read GetName;
  end;

  { Timezones Related }

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBTimezoneList = interface
    ['{E120B06B-06AC-4591-9469-1173DA85C199}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTimezoneItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTimezoneItem read GetItem; default;
  end;

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBTimezoneItem = interface
    ['{58364B5B-DC6E-4A66-B3A5-7D812382C720}']
    function GetISO3166_1: WideString; stdcall;
    function GetZones: TTMDBStrArray; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property Zones: TTMDBStrArray read GetZones;
  end;



  { Genres Related }

  /// <summary>
  /// A list of genres.
  /// [DONE]
  /// </summary>
  ITMDBGenreList = interface
    ['{8C26B769-0488-47B8-BFBA-DA1D8DAA05E4}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBGenreItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem; default;
  end;

  /// <summary>
  /// A specific genre within a genre list.
  /// [DONE]
  /// </summary>
  ITMDBGenreItem = interface
    ['{6C6A1423-D7D9-473D-86C7-07A7FAB64AE7}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;



  { Guest Session Related }



  { Keyword Related }

  ITMDBKeywordItem = interface
    ['{98460089-3E55-4022-A8AC-863EDBB8567A}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;




  { Lists Related }

  //TODO: Terminology will be awkward referencing a list within a list...



  { People Related }

  /// [DONE]
  ITMDBPersonPage = interface(ITMDBPage)
    ['{88C5FCB1-50A7-4D3A-AB69-95B542D77FD5}']
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;

    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;

  ITMDBPersonItem = interface(ITMDBPageItem)
    ['{28C68CE8-358F-4C6E-B4D1-E859D8CCBD65}']
    function GetAdult: Boolean; stdcall;
    function GetGender: TTMDBGender; stdcall;
    function GetID: Integer; stdcall;
    function GetKnownForDepartment: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetProfilePath: WideString; stdcall;
    //TODO: GetKnownFor (array of media item objects)

    property Adult: Boolean read GetAdult;
    property Gender: TTMDBGender read GetGender;
    property ID: Integer read GetID;
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property Name: WideString read GetName;
    property Popularity: Single read GetPopularity;
    property ProfilePath: WideString read GetProfilePath;
    //TODO: KnownFor
  end;

  /// <summary>
  /// A list of people
  /// [DONE]
  /// </summary>
  ITMDBPersonList = interface(ITMDBItemList)
    ['{80B66DAA-C18D-427B-9A0C-B0F070725B83}']
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;

    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;



  { Cast Related }

  /// [DONE]
  ITMDBCastItem = interface(ITMDBPersonItem)
    ['{9CCB9511-A5A5-4BE2-9991-D8A388F7439C}']
    function GetCastID: Integer; stdcall;
    function GetCharacter: WideString; stdcall;
    function GetCreditID: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    property CastID: Integer read GetCastID;
    property Character: WideString read GetCharacter;
    property CreditID: WideString read GetCreditID;
    property Order: Integer read GetOrder;
  end;

  /// [DONE]
  ITMDBCastList = interface(ITMDBPersonList)
    ['{EE41CD2D-6271-48D8-8A5F-646646C44F30}']
    function GetItem(const Index: Integer): ITMDBCastItem; stdcall;

    property Items[const Index: Integer]: ITMDBCastItem read GetItem; default;
  end;



  { Crew Related }

  /// [DONE]
  ITMDBCrewItem = interface(ITMDBPersonItem)
    ['{51AE4CAA-1698-4AF6-B05C-D55E45BAE4ED}']
    function GetCreditID: WideString; stdcall;
    function GetDepartment: WideString; stdcall;
    function GetJob: WideString; stdcall;

    property CreditID: WideString read GetCreditID;
    property Department: WideString read GetDepartment;
    property Job: WideString read GetJob;
  end;

  /// [DONE]
  ITMDBCrewList = interface(ITMDBPersonList)
    ['{1FF0C1A1-EB42-4EF9-8C1B-DEA3AFBD6777}']
    function GetItem(const Index: Integer): ITMDBCrewItem; stdcall;

    property Items[const Index: Integer]: ITMDBCrewItem read GetItem; default;
  end;



  { Credit Related }

  /// [DONE]
  ITMDBCredits = interface
    ['{6A1470C6-79DA-4EE8-B43E-F76EEA9015B9}']
    function GetCast: ITMDBCastList; stdcall;
    function GetCrew: ITMDBCrewList; stdcall;

    property Cast: ITMDBCastList read GetCast;
    property Crew: ITMDBCrewList read GetCrew;
  end;



  { Image Related }

  /// [DONE]
  ITMDBMediaImage = interface
    ['{5E421D4C-DD05-4F49-84C7-0FC5A3A9BCE6}']
    function GetAspectRatio: Single; stdcall;
    function GetHeight: Integer; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetFilePath: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
    function GetWidth: Integer; stdcall;

    property AspectRatio: Single read GetAspectRatio;
    property Height: Integer read GetHeight;
    property ISO639_1: WideString read GetISO639_1;
    property FilePath: WideString read GetFilePath;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
    property Width: Integer read GetWidth;
  end;

  /// [DONE]
  ITMDBMediaImageList = interface
    ['{124D54B5-7433-4C5B-8907-C5D5700D970E}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBMediaImage; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBMediaImage read GetItem; default;
  end;

  /// [DONE]
  ITMDBMediaImages = interface
    ['{FD622861-6E8C-49DE-8151-3E072AF39299}']
    function GetBackdrops: ITMDBMediaImageList; stdcall;
    function GetLogos: ITMDBMediaImageList; stdcall;
    function GetPosters: ITMDBMediaImageList; stdcall;

    property Backdrops: ITMDBMediaImageList read GetBackdrops;
    property Logos: ITMDBMediaImageList read GetLogos;
    property Posters: ITMDBMediaImageList read GetPosters;
  end;



  { Movie Lists Related }

  //TODO: Needs to inherit from base list concept above...



  { Movies Related }

  /// <summary>
  /// A paginated list containing movie results.
  /// [DONE]
  /// </summary>
  ITMDBMoviePage = interface(ITMDBPage)
    ['{D35DC3E6-D4BB-416D-9A43-348C0FCAABB1}']
    function GetItem(const Index: Integer): ITMDBMovieItem; stdcall;

    property Items[const Index: Integer]: ITMDBMovieItem read GetItem; default;
  end;

  /// <summary>
  /// A single movie in an ITMDBMoviePage.
  /// [DONE]
  /// </summary>
  ITMDBMovieItem = interface(ITMDBPageItem)
    ['{00EB49F1-F0EA-4E7A-859E-38632667BA87}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetID: Integer; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenreList read GetGenres;
    property ID: Integer read GetID;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Title: WideString read GetTitle;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  /// [DONE]
  ITMDBRatedMoviePage = interface(ITMDBMoviePage)
    ['{5E267356-3F72-4C5B-87B6-B1D596FDD037}']
    function GetItem(const Index: Integer): ITMDBRatedMovieItem; stdcall;

    property Items[const Index: Integer]: ITMDBRatedMovieItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBRatedMovieItem = interface(ITMDBMovieItem)
    ['{8C67545E-20BB-4A32-8FB7-136C642F73A9}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

  /// <summary>
  /// A list of movies
  /// [DONE]
  /// </summary>
  ITMDBMovieList = interface(ITMDBItemList)
    ['{AC2F3E06-A3C5-4B7B-B83C-23258F6E2FEF}']
    function GetItem(const Index: Integer): ITMDBMovieItem; stdcall;

    property Items[const Index: Integer]: ITMDBMovieItem read GetItem; default;
  end;



  { Movie Details Related }

  /// <summary>
  /// Reference to a collection which a movie belongs to.
  /// [DONE]
  /// </summary>
  ITMDBMovieCollectionRef = interface
    ['{7BA3E60C-FE29-4C8E-ADC4-4F8F8900E7C8}']
    function GetBelongsToCollection: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;

    property BelongsToCollection: Boolean read GetBelongsToCollection;
    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
  end;

  /// [DONE]
  ITMDBAlternativeTitleItem = interface
    ['{AEB8181D-8409-4834-8515-29EB7651FA7A}']
    function GetISO3166_1: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetType: WideString; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property Title: WideString read GetTitle;
    property &Type: WideString read GetType;
  end;

  /// [DONE]
  ITMDBAlternativeTitleList = interface
    ['{C8AD733E-B9C2-4C41-948E-D9B3F9DE81D4}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBAlternativeTitleItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBAlternativeTitleItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBAccountStates = interface
    ['{A83C88DC-B507-4825-8338-8DD67B545059}']
    function GetFavorite: Boolean; stdcall;
    function GetRatedValue: Single; stdcall;
    function GetWatchlist: Boolean; stdcall;

    property Favorite: Boolean read GetFAvorite;
    property RatedValue: Single read GetRatedValue;
    property Watchlist: Boolean read GetWatchlist;
  end;

  /// <summary>
  /// Details of a specific movie.
  /// [DONE]
  /// </summary>
  ITMDBMovieDetail = interface
    ['{9F2CC08D-6D65-4C6E-AEB0-8CEF4748B501}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetCollection: ITMDBMovieCollectionRef; stdcall;
    function GetBudget: Currency; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetIMDBID: WideString; stdcall;
    function GetOriginalCountry: TTMDBStrArray; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetProductionCompanies: ITMDBCompanyList; stdcall;
    function GetProductionCountries: ITMDBCountryList; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetRevenue: Currency; stdcall;
    function GetRuntime: Integer; stdcall;
    function GetSpokenLanguages: ITMDBLanguageList; stdcall;
    function GetStatus: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    function AppendedAccountStates: ITMDBAccountStates; stdcall;
    function AppendedAlternativeTitles: ITMDBAlternativeTitleList; stdcall;
    //function AppendedChanges: ITMDBChangeList; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    //function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImages; stdcall;
    //function AppendedKeywords: ITMDBKeywordList; stdcall;
    //function AppendedLists: ITMDB; stdcall;
    //function AppendedRecommendations: ITMDB; stdcall;
    //function AppendedReleaseDates: ITMDB; stdcall;
    //function AppendedReviews: ITMDBReviewList; stdcall;
    //function AppendedSimilar: ITMDB; stdcall;
    //function AppendedTranslations: ITMDB; stdcall;
    //function AppendedVideos: ITMDB; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Collection: ITMDBMovieCollectionRef read GetCollection;
    property Budget: Currency read GetBudget;
    property Genres: ITMDBGenreList read GetGenres;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property ITMDBID: WideString read GetIMDBID;
    property OriginalCountry: TTMDBStrArray read GetOriginalCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ProductionCompanies: ITMDBCompanyList read GetProductionCompanies;
    property ProductionCountries: ITMDBCountryList read GetProductionCountries;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Revenue: Currency read GetRevenue;
    property Runtime: Integer read GetRuntime;
    property SpokenLanguages: ITMDBLanguageList read GetSpokenLanguages;
    property Status: WideString read GetStatus;
    property Tagline: WideString read GetTagline;
    property Title: WideString read GetTitle;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;



  { Network Related }

  ITMDBTVNetworkList = interface
    ['{2569A653-F292-4E48-8FE1-DBBCCE289102}']
    function GetCount: Integer;
    function GetItem(const Index: Integer): ITMDBTVNetworkItem;

  end;

  ITMDBTVNetworkItem = interface
    ['{BCC9E4A7-07DD-416E-9F04-54CDC2A50DA3}']
    function GetID: Integer;
    function GetLogoPath: WideString;
    function GetName: WideString;
    function GetOriginCountry: WideString;

  end;

  ITMDBTVNetworkDetail = interface
    ['{B3293FC5-F238-4B3D-B3F2-CF4C894BD0EE}']
    function GetHeadquarters: WideString;
    function GetHomepage: WideString;
    function GetID: Integer;
    function GetLogoPath: WideString;
    function GetName: WideString;
    function GetOriginCountry: WideString;

  end;



  { TV Related }

  /// <summary>
  /// A paginated list containing TV results.
  /// [DONE]
  /// </summary>
  ITMDBTVPage = interface(ITMDBPage)
    ['{05742B99-FDCC-47E5-B34F-987ECA5DEBA2}']
    function GetItem(const Index: Integer): ITMDBTVItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVItem read GetItem; default;
  end;

  /// <summary>
  /// A single TV Show in an ITMDBTVPage.
  /// [DONE]
  /// </summary>
  ITMDBTVItem = interface(ITMDBPageItem)
    ['{7907FF27-E02F-4270-9AAB-322E6C31516D}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetID: Integer; stdcall;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetFirstAirDate: TDateTime; stdcall;
    function GetName: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenreList read GetGenres;
    property ID: Integer read GetID;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property Name: WideString read GetName;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  /// [DONE]
  ITMDBTVEpisodePage = interface(ITMDBPage)
    ['{BB238B34-1BA9-411C-92AF-B43C6DD6702A}']
    function GetItem(const Index: Integer): ITMDBTVEpisodeItem;

    property Items[const Index: Integer]: ITMDBTVEpisodeItem read GetItem; default;
  end;

  ITMDBTVEpisodeItem = interface(ITMDBPageItem)
    ['{2B2377B6-CEB0-47E0-9B64-D259600DECB4}']

  end;

  /// [DONE]
  ITMDBRatedTVPage = interface(ITMDBTVPage)
    ['{AD5E62E1-41CE-4564-8407-DCEE9F2F0756}']
    function GetItem(const Index: Integer): ITMDBRatedTVItem; stdcall;

    property Items[const Index: Integer]: ITMDBRatedTVItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBRatedTVItem = interface(ITMDBTVItem)
    ['{D48E190F-3095-452A-AE5C-75E70DB7C709}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

  /// [DONE]
  ITMDBRatedTVEpisodePage = interface(ITMDBTVEpisodePage)
    ['{DDC4B9FA-AC4B-4EAC-B9B8-78464034BC68}']
    function GetItem(const Index: Integer): ITMDBRatedTVEpisodeItem; stdcall;

    property Items[const Index: Integer]: ITMDBRatedTVEpisodeItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBRatedTVEpisodeItem = interface(ITMDBTVEpisodeItem)
    ['{0FDB3732-0EB1-43FF-A006-4E6EFC411C54}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

  /// [DONE]
  ITMDBTVSeriesPage = interface(ITMDBTVPage)
    ['{D224BCE1-3711-4CD5-B34A-885B13DA667A}']
    function GetItem(const Index: Integer): ITMDBTVSeriesItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVSeriesItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBTVSeriesItem = interface(ITMDBTVItem)
    ['{F54A4871-4A24-4597-9C03-F0156905E6EB}']

  end;

  ITMDBTVSeriesDetail = interface
    ['{21659C51-7E37-4353-A47E-B1D5C31B456D}']
    function GetAdult: Boolean;
    function GetBackdropPath: WideString;
    function GetCreatedBy: ITMDBPersonList;
    function GetEpisodeRunTime: TTMDBIntArray;
    function GetFirstAirDate: TDateTime;
    function GetGenres: ITMDBGenreList;
    function GetHomepage: WideString;
    function GetID: Integer;
    function GetInProduction: Boolean;
    function GetLanguages: TTMDBStrArray;
    function GetLastAirDate: TDateTime;
    function GetLastEpisodeToAir: ITMDBTVEpisodeItem;
    function GetName: WideString;
    function GetNextEpisodeToAir: TDateTime;
    function GetNetworks: ITMDBTVNetworkList;
    function GetNumberOfEpisodes: Integer;
    function GetNumberOfSeasons: Integer;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString;
    function GetOriginalName: WideString;
    function GetOverview: WideString;
    function GetPopularity: Single;
    function GetPosterPath: WideString;
    function GetProductionCompanies: ITMDBCompanyList;
    function GetProductionCountries: ITMDBCountryList;
    //function GetSeasons: ITMDBTVSeasonList;
    function GetSpokenLanguages: ITMDBLanguageList;
    function GetStatus: WideString;
    function GetTagline: WideString;
    function GetType: WideString;
    function GetVoteAverage: Single;
    function GetVoteCount: Integer;
  end;

  /// [DONE]
  ITMDBTVSeasonPage = interface(ITMDBPage)
    ['{697CDF42-1FE5-49C3-92C5-87BE730AD427}']
    function GetItem(const Index: Integer): ITMDBTVSeasonItem;

    property Items[const Index: Integer]: ITMDBTVSeasonItem read GetItem; default;
  end;

  ITMDBTVSeasonItem = interface(ITMDBPageItem)
    ['{A3291740-EB50-467E-8B82-ED5F3463A882}']
    function GetID: Integer;
    function GetSeasonNumber: Integer;

  end;



  { Episode Group Related }

  ITMDBTVEpisodeGroup = interface;

  ITMDBTVEpisodeGroupItem = interface;

  ITMDBTVEpisodeGroupResponse = interface
    ['{14C7DEAF-20B9-4541-BBF8-D9A9A8E8205E}']
    function GetDescription: WideString;
    function GetEpisodeCount: Integer;
    function GetGroupCount: Integer;
    function GetGroup(const Index: Integer): ITMDBTVEpisodeGroup;
    function GetID: WideString;
    function GetName: WideString;
    function GetNetwork: ITMDBTVNetworkItem;
    function GetType: TTMDBTVEpisodeGroupType;

  end;

  ITMDBTVEpisodeGroup = interface
    ['{EBECFB23-6043-4830-8497-EAE3A6AD5E6B}']
    function GetID: WideString;
    function GetName: WideString;
    function GetOrder: Integer;
    function GetCount: Integer;
    function GetEpisode(const Index: Integer): ITMDBTVEpisodeGroupItem;
    function GetLocked: Boolean;

  end;

  //TODO: Can this be reused / shared with ITMDBTVEpisodeItem?
  //  As seen in details of a TV Season (ITMDBTVSeasonItem), each episode
  //  object contains even more details than is found here in episode groups...
  ITMDBTVEpisodeGroupItem = interface
    ['{11318A52-2ECD-454F-89BF-4655C58DC3DC}']
    function GetAirDate: TDateTime;
    function GetEpisodeNumber: Integer;
    function GetID: Integer;
    function GetName: WideString;
    function GetOverview: WideString;
    function GetProductionCode: WideString;
    function GetRuntime: Integer;
    function GetSeasonNumber: Integer;
    function GetShowID: Integer;
    function GetStillPath: WideString;
    function GetVoteAverage: Single;
    function GetVoteCount: Integer;
    function GetOrder: Integer;

  end;



  { Lists Related}

  /// [DONE]
  ITMDBListPage = interface(ITMDBPage)
    ['{6B0E3282-73BC-4DF8-9097-089F41BEE53B}']
    function GetItem(const Index: Integer): ITMDBListPageItem;

    property Items[const Index: Integer]: ITMDBListPageItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBListPageItem = interface(ITMDBPageItem)
    ['{7B153F3B-E562-45AC-8708-6C1F3E6EE6B2}']
    function GetDescription: WideString;
    function GetFavoriteCount: Integer;
    function GetID: Integer;
    function GetItemCount: Integer;
    function GetISO639_1: WideString;
    function GetListType: TTMDBListType;
    function GetName: WideString;
    function GetPosterPath: WideString;

    property Description: WideString read GetDescription;
    property FavoriteCount: Integer read GetFavoriteCount;
    property ID: Integer read GetID;
    property ItemCount: Integer read GetItemCount;
    property ISO639_1: WideString read GetISO639_1;
    property ListType: TTMDBListType read GetListType;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
  end;



  { Discover Related }

  ITMDBDiscoverMoviePage = interface(ITMDBMoviePage)
    ['{DF3A6755-6B14-4A74-832F-865B4764D012}']

  end;

  ITMDBDiscoverMovieItem = interface(ITMDBMovieItem)
    ['{183EA5A3-E50B-4002-8B6F-A388C19DDF66}']

  end;

  ITMDBDiscoverTVPage = interface(ITMDBTVPage)
    ['{A2A8C881-C40C-4115-A4FA-F28BCF281F40}']

  end;

  ITMDBDiscoverTVItem = interface(ITMDBTVItem)
    ['{41B039D6-31F6-42B9-B69F-7D9F8B6E6DAD}']

  end;



  /// <summary>
  /// A list of TV series
  /// [DONE]
  /// </summary>
  ITMDBTVList = interface(ITMDBItemList)
    ['{13D059E8-BC04-423B-AA5B-8590DFA6E97F}']
    function GetItem(const Index: Integer): ITMDBTVItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVItem read GetItem; default;
  end;

  /// <summary>
  /// A list of TV episodes
  /// [DONE]
  /// </summary>
  ITMDBTVEpisodeList = interface(ITMDBItemList)
    ['{C574FEB8-2F01-408A-95B5-6B80E218EECD}']
    function GetItem(const Index: Integer): ITMDBTVEpisodeItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVEpisodeItem read GetItem; default;
  end;

  /// <summary>
  /// A list of TV seasons
  /// [DONE]
  /// </summary>
  ITMDBTVSeasonList = interface(ITMDBItemList)
    ['{BA1F02CD-9D5F-4AC7-B849-7B524C3B25F1}']
    function GetItem(const Index: Integer): ITMDBTVSeasonItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVSeasonItem read GetItem; default;
  end;



  { Find Related }

  /// <summary>
  /// The resposne of calling Find By ID containing several lists of results.
  /// [DONE]
  /// </summary>
  ITMDBFindResults = interface
    ['{4A7BEA80-3F67-4CF2-8A79-31CA9E19EB0D}']
    function GetMovieResults: ITMDBMovieList;
    function GetPersonResults: ITMDBPersonList;
    function GetTVResults: ITMDBTVList;
    function GetTVEpisodeResults: ITMDBTVEpisodeList;
    function GetTVSeasonResults: ITMDBTVSeasonList;

    property MovieResults: ITMDBMovieList read GetMovieResults;
    property PersonResults: ITMDBPersonList read GetPersonResults;
    property TVResults: ITMDBTVList read GetTVResults;
    property TVEpisodeResults: ITMDBTVEpisodeList read GetTVEpisodeResults;
    property TVSeasonResults: ITMDBTVSeasonList read GetTVSeasonResults;
  end;



  { Watch Provider Related }

  /// [DONE]
  ITMDBWatchProviderPriority = interface
    ['{9C41902E-4F0B-452E-8B80-40A3B139061B}']
    function GetCountryCode: WideString; stdcall;
    function GetPriority: Integer; stdcall;

    property CountryCode: WideString read GetCountryCode;
    property Priority: Integer read GetPriority;
  end;

  // [DONE]
  ITMDBWatchProviderPriorities = interface
    ['{256F86BF-7470-40AE-B5C6-128960948240}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBWatchProviderPriority; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBWatchProviderPriority read GetItem; default;
  end;

  /// [DONE]
  ITMDBWatchProviderItem = interface
    ['{D94AA552-F436-494D-881B-7FEEBC429068}']
    function GetDisplayPriorities: ITMDBWatchProviderPriorities; stdcall;
    function GetDisplayPriority: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetProviderName: WideString; stdcall;
    function GetProviderID: Integer; stdcall;

    property DisplayPriorities: ITMDBWatchProviderPriorities read GetDisplayPriorities;
    property DisplayPriority: Integer read GetDisplayPriority;
    property LogoPath: WideString read GetLogoPath;
    property ProviderName: WideString read GetProviderName;
    property ProviderID: Integer read GetProviderID;
  end;

  /// [DONE]
  ITMDBWatchProviderList = interface
    ['{59B51A31-211F-48CD-BED4-B61E9EAA3EB1}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBWatchProviderItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBWatchProviderItem read GetItem; default;
  end;







////////////////////////////////////////////////////////////////////////////////







type

  { Forward Definitions }

  ITMDBService = interface;

  ITMDBServiceAccount = interface;

  ITMDBServiceAuthentication = interface;

  ITMDBServiceCertifications = interface;

  ITMDBServiceChanges = interface;

  ITMDBServiceCollections = interface;

  ITMDBServiceCompanies = interface;

  ITMDBServiceConfiguration = interface;

  ITMDBServiceCredits = interface;

  ITMDBServiceDiscover = interface;

  ITMDBServiceFind = interface;

  ITMDBServiceGenres = interface;

  ITMDBServiceGuestSessions = interface;

  ITMDBServiceKeywords = interface;

  ITMDBServiceLists = interface;

  ITMDBServiceMovieLists = interface;

  ITMDBServiceMovies = interface;

  ITMDBServiceNetworks = interface;

  ITMDBServicePeopleLists = interface;

  ITMDBServicePeople = interface;

  ITMDBServiceReviews = interface;

  ITMDBServiceSearch = interface;

  ITMDBServiceTrending = interface;

  ITMDBServiceTVSeriesLists = interface;

  ITMDBServiceTVSeries = interface;

  ITMDBServiceTVSeasons = interface;

  ITMDBServiceTVEpisodes = interface;

  ITMDBServiceTVEpisodeGroups = interface;

  ITMDBServiceWatchProviders = interface;

  ITMDB = interface;



  { API Services }

  /// <summary>
  /// Base interface for each possible TMDB service category.
  /// [DONE]
  /// </summary>
  ITMDBService = interface
    ['{0E665C12-812B-4B2D-8A48-17A16740290C}']
    function GetOwner: ITMDB;

    property Owner: ITMDB read GetOwner;
  end;

  /// [DONE]
  ITMDBServiceAccount = interface(ITMDBService)
    ['{E690DF1A-6680-4040-BBC6-ABE0D4CC6916}']
    function GetDetails(AAccountID: Integer;
      ASessionID: WideString = ''): ITMDBAccountDetail; stdcall;
    function SetFavorite(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Favorite: Boolean; const SessionID: WideString = ''): ITMDBAccountAddFavoriteResult; stdcall;
    function SetWatchlist(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Watchlist: Boolean; const SessionID: WideString = ''): ITMDBAccountAddWatchlistResult; stdcall;
    function GetFavoriteMovies(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetFavoriteTV(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBTVPage; stdcall;
    function GetLists(const AccountID: Integer; const Page: Integer = 1;
      const SessionID: WideString = ''): ITMDBListPage; stdcall;
    function GetRatedMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedMoviePage; stdcall;
    function GetRatedTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVPage; stdcall;
    function GetRatedTVEpisodes(AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVEpisodePage; stdcall;
    function GetWatchlistMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetWatchlistTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBTVPage; stdcall;
  end;

  /// [DONE]
  ITMDBServiceAuthentication = interface(ITMDBService)
    ['{2144056B-54A4-49C4-AE3E-E0701B10E218}']
    function CreateGuestSession: ITMDBAuthGuestSessionResult; stdcall;
    function CreateRequestToken: ITMDBAuthRequestTokenResult; stdcall;
    function CreateSession(const ARequestToken: WideString): ITMDBAuthSessionResult; stdcall;
    function CreateSessionV4(const AAccessToken: WideString): ITMDBAuthSessionResult; stdcall;
    function CreateSessionLogin(const AUsername, APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin; stdcall;
    function DeleteSession(const SessionID: WideString): ITMDBAuthDeleteSessionResult; stdcall;
    function ValidateKey: ITMDBAuthValidateKeyResult; stdcall;
  end;

  /// [DONE]
  ITMDBServiceCertifications = interface(ITMDBService)
    ['{C6FCB00E-CDCA-46EA-B44B-A3CA2570774B}']
    function GetMovieCertifications: ITMDBCertificationCountries; stdcall;
    function GetTVCertifications: ITMDBCertificationCountries; stdcall;
  end;

  ITMDBServiceChanges = interface(ITMDBService)
    ['{944AE998-E4B0-49DA-924E-2272AEF9F8A0}']
    //MovieList
    //PeopleList
    //TVList
  end;

  ITMDBServiceCollections = interface(ITMDBService)
    ['{C0040473-5A07-493B-9771-2EAF58CD5DB0}']
    //GetDetails
    //GetImages
    //GetTranslations
  end;

  ITMDBServiceCompanies = interface(ITMDBService)
    ['{13F92C49-85D1-4C7F-BBA6-8B815B23EDDE}']
    //GetDetails
    //GetAlternativeNames
    //GetImages
  end;

  /// [DONE]
  ITMDBServiceConfiguration = interface(ITMDBService)
    ['{A459EFE0-D167-4247-8EAD-319021284D10}']
    function GetDetails: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountryList; stdcall;
    function GetJobs: ITMDBJobDepartmentList; stdcall;
    function GetLanguages: ITMDBLanguageList; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezoneList; stdcall;
  end;

  ITMDBServiceCredits = interface(ITMDBService)
    ['{B5BDB2EC-A303-474B-B71F-C329100CC378}']
    //GetDetails
  end;

  ITMDBServiceDiscover = interface(ITMDBService)
    ['{F3D713B4-04D6-48D8-A4C9-6505CD361694}']
    //GetMovies
    //GetTV
  end;

  /// [DONE]
  ITMDBServiceFind = interface(ITMDBService)
    ['{82DB20C9-8E71-4151-9E76-B173CA5F1B97}']
    function FindByID(const ExternalID: String; const ExternalSource: String;
      const Language: String = ''): ITMDBFindResults; stdcall;
  end;

  /// [DONE]
  ITMDBServiceGenres = interface(ITMDBService)
    ['{E21E59C6-5416-4D9A-B6EB-33E004A5622D}']
    function GetMovieList(const Language: WideString = ''): ITMDBGenreList; stdcall;
    function GetTVList(const Language: WideString = ''): ITMDBGenreList; stdcall;
  end;

  ITMDBServiceGuestSessions = interface(ITMDBService)
    ['{FDF85071-F2F4-49A6-BAAD-6ECD96BE3CBD}']
    //GetRatedMovies
    //GetRatedTV
    //GetRatedTVEpisodes
  end;

  ITMDBServiceKeywords = interface(ITMDBService)
    ['{8FE0FEB6-511B-4704-A71A-BA8B5C8E912C}']
    //GetDetails
  end;

  ITMDBServiceLists = interface(ITMDBService)
    ['{9516AD42-A8CC-47E8-9CDB-4E2C8C48E028}']
    //AddMovie
    //CheckItemStatus
    //Clear
    //Create
    //Delete
    //GetDetails
    //RemoveMovie
  end;

  ITMDBServiceMovieLists = interface(ITMDBService)
    ['{FAFB9948-B099-47AD-8C0F-74FE3A1B2E0E}']
    //GetNowPlaying
    //GetPopular
    //GetTopRated
    //GetUpcoming
  end;

  ITMDBServiceMovies = interface(ITMDBService)
    ['{93A8FDCA-9C30-4BC5-BEFC-BB066A5ADE6F}']
    function GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieRequests = [];
      const Language: WideString = ''): ITMDBMovieDetail; stdcall;
    //GetAccountStates
    //GetAlternativeTitles
    //GetChanges
    //GetCredits
    //GetExternalIDs
    //GetImages
    //GetKeywords
    //GetLatest
    //GetLists
    //GetRecommendations
    //GetReleaseDates
    //GetReviews
    //GetSimilar
    //GetTranslations
    //GetVideos
    //GetWatchProviders
    //AddRating
    //DeleteRating
  end;

  ITMDBServiceNetworks = interface(ITMDBService)
    ['{766C690C-DD9A-4E3B-A611-F93B1CFE1DF6}']
    //GetDetails
    //GetAlternativeNames
    //GetImages
  end;

  ITMDBServicePeopleLists = interface(ITMDBService)
    ['{24DB64CB-1303-4CF5-86D9-F007E773C869}']
    //GetPopular
  end;

  ITMDBServicePeople = interface(ITMDBService)
    ['{7A209CC2-3BB0-4AC7-AD28-9466ACC666EA}']
    //GetDetails
    //GetChanges
    //GetCombinedCredits
    //GetExternalIDs
    //GetImages
    //GetLatest
    //GetMovieCredits
    //GetTVCredits
    //GetTaggedImages [DEPRECATED]
    //GetTranslations
  end;

  ITMDBServiceReviews = interface(ITMDBService)
    ['{FD2277E9-2A59-413D-B67B-B210D32F1133}']
    //GetDetails
  end;

  ITMDBServiceSearch = interface(ITMDBService)
    ['{D7E9618F-ED5C-4D9A-93FF-CF109294DA0F}']
    //SearchCollections
    //SearchCompanies
    //SearchKeywords
    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //SearchMulti
    //SearchPeople
    //SearchTV
  end;

  ITMDBServiceTrending = interface(ITMDBService)
    ['{54784907-ACC7-40D1-81D5-109FB413F18A}']
    //GetAll
    //GetMovies
    //GetPeople
    //GetTV
  end;

  ITMDBServiceTVSeriesLists = interface(ITMDBService)
    ['{7CFA63BE-1377-446E-AE16-D6EB8FF74074}']
    //GetAiringToday
    //GetOnTheAir
    //GetPopular
    //GetTopRated
  end;

  ITMDBServiceTVSeries = interface(ITMDBService)
    ['{A72F79E7-A3C2-4105-B0F0-3D53B59352B2}']
    //GetDetails
    //GetAccountStates
    //GetAggregateCredits
    //GetAlternativeTitles
    //GetChanges
    //GetContentRatings
    //GetCredits
    //GetEpisodeGroups
    //GetExternalIDs
    //GetImages
    //GetKeywords
    //GetLatest
    //GetLists
    //GetRecommendations
    //GetReviews
    //GetScreenedTheatrically
    //GetSimilar
    //GetTranslations
    //GetVideos
    //GetWatchProviders
    //AddRating
    //DeleteRating
  end;

  ITMDBServiceTVSeasons = interface(ITMDBService)
    ['{89A1F3C8-F032-4B36-8481-DFE5291EBDA3}']
    //GetDetails
    //GetAccountStates
    //GetAggregateCredits
    //GetChanges
    //GetCredits
    //GetExternalIDs
    //GetImages
    //GetTranslations
    //GetVideos
    //GetWatchProviders
  end;

  ITMDBServiceTVEpisodes = interface(ITMDBService)
    ['{CD87A380-130A-46CD-9661-6CE1CE30CD82}']
    //GetDetails
    //GetAccountStates
    //GetChanges
    //GetCredits
    //GetExternalIDs
    //GetImages
    //GetTranslations
    //GetVideos
    //AddRating
    //DeleteRating
  end;

  ITMDBServiceTVEpisodeGroups = interface(ITMDBService)
    ['{B55FFFC4-7C29-4BA1-89C5-0CF1A8D88943}']
    //GetDetails
  end;

  //NOTE: Be sure to attribute "JustWatch" if your solution uses watch providers.
  ITMDBServiceWatchProviders = interface(ITMDBService)
    ['{FDB079FA-C25C-4337-BDD7-C4E4A9186A36}']
    function GetAvailableRegions(const Language: WideString = ''): ITMDBCountryList; stdcall;
    function GetMovieProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
    function GetTVProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
  end;




////////////////////////////////////////////////////////////////////////////////





  { Core Access }

  ITMDB = interface
    ['{FB7CAA70-63BE-4BAC-9BE8-4E0E0225A9C3}']

    { Authentication }

    function GetAPIKey: WideString; stdcall;
    procedure SetAPIKey(const Value: WideString); stdcall;
    function GetAccessToken: WideString; stdcall;
    procedure SetAccessToken(const Value: WideString); stdcall;
    function GetAuthMethod: TTMDBAuthMethod; stdcall;
    procedure SetAuthMethod(const Value: TTMDBAuthMethod); stdcall;
    function GetUserAuth: TTMDBUserAuth; stdcall;
    procedure SetUserAuth(const Value: TTMDBUserAuth); stdcall;

    { Services }

    function Account: ITMDBServiceAccount; stdcall;
    function Authentication: ITMDBServiceAuthentication; stdcall;
    function Certifications: ITMDBServiceCertifications; stdcall;
    function Changes: ITMDBServiceChanges; stdcall;
    function Collections: ITMDBServiceCollections; stdcall;
    function Companies: ITMDBServiceCompanies; stdcall;
    function Configuration: ITMDBServiceConfiguration; stdcall;
    function Credits: ITMDBServiceCredits; stdcall;
    function Discover: ITMDBServiceDiscover; stdcall;
    function Find: ITMDBServiceFind; stdcall;
    function Genres: ITMDBServiceGenres; stdcall;
    function GuestSessions: ITMDBServiceGuestSessions; stdcall;
    function Keywords: ITMDBServiceKeywords; stdcall;
    function Lists: ITMDBServiceLists; stdcall;
    function MovieLists: ITMDBServiceMovieLists; stdcall;
    function Movies: ITMDBServiceMovies; stdcall;
    function Networks: ITMDBServiceNetworks; stdcall;
    function PeopleLists: ITMDBServicePeopleLists; stdcall;
    function People: ITMDBServicePeople; stdcall;
    function Reviews: ITMDBServiceReviews; stdcall;
    function Search: ITMDBServiceSearch; stdcall;
    function Trending: ITMDBServiceTrending; stdcall;
    function TVSeriesLists: ITMDBServiceTVSeriesLists; stdcall;
    function TVSeries: ITMDBServiceTVSeries; stdcall;
    function TVSeasons: ITMDBServiceTVSeasons; stdcall;
    function TVEpisodes: ITMDBServiceTVEpisodes; stdcall;
    function TVEpisodeGroups: ITMDBServiceTVEpisodeGroups; stdcall;
    //NOTE: Be sure to attribute "JustWatch" if your solution uses watch providers.
    function WatchProviders: ITMDBServiceWatchProviders; stdcall;

    property APIKey: WideString read GetAPIKey write SetAPIKey;
    property AccessToken: WideString read GetAccessToken write SetAccessToken;
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property UserAuth: TTMDBUserAuth read GetUserAuth write SetUserAuth;

  end;

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

implementation

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

end.
