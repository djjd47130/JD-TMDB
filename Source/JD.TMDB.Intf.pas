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
  System.Classes, System.SysUtils, IdSSLOpenSSLHeaders;

type

  { Common }

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

  /// <summary>
  /// Type of movie details that can be returned with AppendToResponse
  /// </summary>
  TTMDBMovieDetail = (mdAccountStates, mdAlternativeTitles, mdChanges, mdCredits,
    mdExternalIDs, mdImages, mdKeywords, mdLatest, mdLists, mdRecommendations,
    mdReleaseDates, mdReviews, mdSimilar, mdTranslations, mdVideos,
    mdWatchProviders);

  /// <summary>
  /// Set of TTMDBMovieDetail to define what to return with AppendToResponse
  /// </summary>
  TTMDBMovieDetails = set of TTMDBMovieDetail;



  { Pagination Related }

  ITMDBPageItem = interface;

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

  ITMDBCertificationItem = interface;
  ITMDBCertificationCountry = interface;

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



  { Collections Related }



  { Companies Related }



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

  ITMDBCountryItem = interface;

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

  ITMDBJobDepartmentItem = interface;

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

  ITMDBLanguageItem = interface;

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

  ITMDBTimezoneItem = interface;

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



  { Credit Related }



  { Discover Related }



  { Find Related }



  { Genres Related }

  ITMDBGenreItem = interface;

  /// <summary>
  ///
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
  ///
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



  { Lists Related }



  { Movie Lists Related }



  { Movies Related }

  ITMDBMovieItem = interface;

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

  ITMDBRatedMovieItem = interface;

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

  /// <summary>
  /// Details of a specific movie.
  /// </summary>
  ITMDBMovieDetail = interface
    ['{9F2CC08D-6D65-4C6E-AEB0-8CEF4748B501}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetCollection: ITMDBMovieCollectionRef; stdcall;
    function GetBudget: Currency; stdcall;
    function GetGenreIDs: TTMDBIntArray; stdcall;
    function GetGenreNames: TTMDBStrArray; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetIMDBID: WideString; stdcall;
    function GetOriginalCountry: TTMDBStrArray; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPopularity: Single; stdcall;
    function GetPosterPath: WideString; stdcall;
    //TODO: GetProductionCompanies array of ITMDBCompanyItem
    //TODO: GetProductionCountries array of ITMDBCountryItem
    function GetReleaseDate: TDateTime; stdcall;
    function GetRevenue: Currency; stdcall;
    function GetRuntime: Integer; stdcall;
    //TODO: GetSpokenLanguages array of ITMDBLanguageItem
    function GetStatus: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetTitle: WideString; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    //TODO: Properties
  end;



  { TV Related }

  ITMDBTVItem = interface;

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

  ITMDBRatedTVItem = interface;

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

  ITMDBTVSeriesItem = interface;

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
    //CreatedBy array of ITMDBPeopleItem
    function GetEpisodeRunTime: TTMDBIntArray;
    function GetFirstAirDate: TDateTime;
    function GetGenres: ITMDBGenreList;
    function GetHomepage: WideString;
    function GetID: Integer;
    function GetInProduction: Boolean;
    function GetLanguages: TTMDBStrArray;
    function GetLastAirDate: TDateTime;
    //LastEpisodeToAir ITMDBTVEpisodeItem
    function GetName: WideString;
    function GetNextEpisodeToAir: TDateTime;
    //Networks array of ITMDBNetworkItem
    function GetNumberOfEpisodes: Integer;
    function GetNumberOfSeasons: Integer;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString;
    function GetOriginalName: WideString;
    function GetOverview: WideString;
    function GetPopularity: Single;
    function GetPosterPath: WideString;
    //ProductionCompanies array of ITMDBCompanyItem
    //ProductionCountries array of ITMDBCountryItem
    //Seasons array of ITMDBTVSeasonItem
    //SpokenLanguages array of ITMDBLanguageItem
    function GetStatus: WideString;
    function GetTagline: WideString;
    function GetType: WideString;
    function GetVoteAverage: Single;
    function GetVoteCount: Integer;
  end;

  ITMDBTVSeasonItem = interface;

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

  ITMDBTVEpisodeItem = interface;

  ITMDBTVEpisodePage = interface(ITMDBPage)
    ['{BB238B34-1BA9-411C-92AF-B43C6DD6702A}']

  end;

  ITMDBTVEpisodeItem = interface(ITMDBPageItem)
    ['{2B2377B6-CEB0-47E0-9B64-D259600DECB4}']

  end;



  { Episode Group Related }



  { Lists Related}

  ITMDBListPageItem = interface;

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





type

  { Forward Definitions }

  ITMDB = interface;

  { API Services }

  /// <summary>
  /// Base interface for each possible TMDB service category.
  /// [DONE]
  /// </summary>
  ITMDBService = interface
    ['{0E665C12-812B-4B2D-8A48-17A16740290C}']

  end;

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
    //GetRatedTVEpisodes
    //GetWatchlistMovies
    //GetWatchlistTV
  end;

  /// [DONE]
  ITMDBServiceAuthentication = interface(ITMDBService)
    ['{2144056B-54A4-49C4-AE3E-E0701B10E218}']
    function CreateGuestSession: ITMDBAuthGuestSessionResult;
    function CreateRequestToken: ITMDBAuthRequestTokenResult;
    function CreateSession(const ARequestToken: WideString): ITMDBAuthSessionResult;
    function CreateSessionV4(const AAccessToken: WideString): ITMDBAuthSessionResult;
    function CreateSessionLogin(const AUsername, APassword, ARequestToken: WideString): ITMDBAuthSessionResultLogin;
    function DeleteSession(const SessionID: WideString): ITMDBAuthDeleteSessionResult;
    function ValidateKey: ITMDBAuthValidateKeyResult;
  end;

  /// [DONE]
  ITMDBServiceCertifications = interface(ITMDBService)
    ['{C6FCB00E-CDCA-46EA-B44B-A3CA2570774B}']
    function GetMovieCertifications: ITMDBCertificationCountries;
    function GetTVCertifications: ITMDBCertificationCountries;
  end;

  ITMDBServiceChanges = interface(ITMDBService)
    ['{944AE998-E4B0-49DA-924E-2272AEF9F8A0}']

  end;

  ITMDBServiceCollections = interface(ITMDBService)
    ['{C0040473-5A07-493B-9771-2EAF58CD5DB0}']

  end;

  ITMDBServiceCompanies = interface(ITMDBService)
    ['{13F92C49-85D1-4C7F-BBA6-8B815B23EDDE}']

  end;

  /// [DONE]
  ITMDBServiceConfiguration = interface(ITMDBService)
    ['{A459EFE0-D167-4247-8EAD-319021284D10}']
    function GetDetails: ITMDBConfiguration;
    function GetCountries: ITMDBCountryList;
    function GetJobs: ITMDBJobDepartmentList;
    function GetLanguages: ITMDBLanguageList;
    function GetPrimaryTranslations: TTMDBStrArray;
    function GetTimezones: ITMDBTimezoneList;
  end;

  ITMDBServiceCredits = interface(ITMDBService)
    ['{B5BDB2EC-A303-474B-B71F-C329100CC378}']

  end;

  ITMDBServiceDiscover = interface(ITMDBService)
    ['{F3D713B4-04D6-48D8-A4C9-6505CD361694}']

  end;

  ITMDBServiceFind = interface(ITMDBService)
    ['{82DB20C9-8E71-4151-9E76-B173CA5F1B97}']

  end;

  /// [DONE]
  ITMDBServiceGenres = interface(ITMDBService)
    ['{E21E59C6-5416-4D9A-B6EB-33E004A5622D}']
    function GetMovieList(const Language: WideString = ''): ITMDBGenreList; stdcall;
    function GetTVList(const Language: WideString = ''): ITMDBGenreList; stdcall;
  end;

  ITMDBServiceGuestSessions = interface(ITMDBService)
    ['{FDF85071-F2F4-49A6-BAAD-6ECD96BE3CBD}']

  end;

  ITMDBServiceKeywords = interface(ITMDBService)
    ['{8FE0FEB6-511B-4704-A71A-BA8B5C8E912C}']

  end;

  ITMDBServiceLists = interface(ITMDBService)
    ['{9516AD42-A8CC-47E8-9CDB-4E2C8C48E028}']

  end;

  ITMDBServiceMovieLists = interface(ITMDBService)
    ['{FAFB9948-B099-47AD-8C0F-74FE3A1B2E0E}']

  end;

  ITMDBServiceMovies = interface(ITMDBService)
    ['{93A8FDCA-9C30-4BC5-BEFC-BB066A5ADE6F}']
    function GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieDetails = [];
      const Language: WideString = ''): ITMDBMovieDetail; stdcall;

  end;

  ITMDBServiceNetworks = interface(ITMDBService)
    ['{766C690C-DD9A-4E3B-A611-F93B1CFE1DF6}']

  end;

  ITMDBServicePeopleLists = interface(ITMDBService)
    ['{24DB64CB-1303-4CF5-86D9-F007E773C869}']

  end;

  ITMDBServicePeople = interface(ITMDBService)
    ['{7A209CC2-3BB0-4AC7-AD28-9466ACC666EA}']

  end;

  ITMDBServiceReviews = interface(ITMDBService)
    ['{FD2277E9-2A59-413D-B67B-B210D32F1133}']

  end;

  ITMDBServiceSearch = interface(ITMDBService)
    ['{D7E9618F-ED5C-4D9A-93FF-CF109294DA0F}']

    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;

  end;

  ITMDBServiceTrending = interface(ITMDBService)
    ['{54784907-ACC7-40D1-81D5-109FB413F18A}']

  end;

  ITMDBServiceTVSeriesLists = interface(ITMDBService)
    ['{7CFA63BE-1377-446E-AE16-D6EB8FF74074}']

  end;

  ITMDBServiceTVSeries = interface(ITMDBService)
    ['{A72F79E7-A3C2-4105-B0F0-3D53B59352B2}']

  end;

  ITMDBServiceTVSeasons = interface(ITMDBService)
    ['{89A1F3C8-F032-4B36-8481-DFE5291EBDA3}']

  end;

  ITMDBServiceTVEpisodes = interface(ITMDBService)
    ['{CD87A380-130A-46CD-9661-6CE1CE30CD82}']

  end;

  ITMDBServiceTVEpisodeGroups = interface(ITMDBService)
    ['{B55FFFC4-7C29-4BA1-89C5-0CF1A8D88943}']

  end;

  //NOTE: Be sure to attribute "JustWatch" if your solution uses watch providers.
  ITMDBServiceWatchProviders = interface(ITMDBService)
    ['{FDB079FA-C25C-4337-BDD7-C4E4A9186A36}']

  end;




////////////////////////////////////////////////////////////////////////////////





  { Core Access }

  ITMDB = interface
    ['{FB7CAA70-63BE-4BAC-9BE8-4E0E0225A9C3}']
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

function MediaTypeStr(const AMediaType: TTMDBMediaType): WideString;

implementation

function MediaTypeStr(const AMediaType: TTMDBMediaType): WideString;
begin
  case AMediaType of
    mtMovie: Result:= 'movie';
    mtTV: Result:= 'tv';
    mtPerson: Result:= 'person';
  end;
end;

end.
