unit JD.TMDB.Intf;

(*
  TMDB API Wrapper for Delphi
  Written by Jerry Dodge

  ----------------------------------------------------------------------------
  TMDB Object Interface Definitions
  ----------------------------------------------------------------------------

  IMPORTANT: This is still a work in progress! No guarantees! Use at your own risk!

  API Documentation:
  https://developer.themoviedb.org/docs/getting-started
  https://developer.themoviedb.org/reference/intro/getting-started

*)

interface

uses
  System.Classes, System.SysUtils,
  XSuperObject,
  JD.TMDB.Common;



type

{$REGION 'Forward Definitions'}

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

  ITMDBMediaImages = interface;

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

  ITMDBTVSeriesPage = interface;

  ITMDBTVSeriesItem = interface;

  ITMDBTVEpisodePage = interface;

  ITMDBTVEpisodeItem = interface;

  ITMDBRatedTVSeriesPage = interface;

  ITMDBRatedTVSeriesItem = interface;

  ITMDBRatedTVEpisodePage = interface;

  ITMDBRatedTVEpisodeItem = interface;

  ITMDBTVSeriesDetail = interface;

  ITMDBTVSeasonPage = interface;

  ITMDBTVSeasonItem = interface;

  ITMDBTVEpisodeGroupResponse = interface;

  ITMDBListPage = interface;

  ITMDBListPageItem = interface;

  ITMDBDiscoverMoviePage = interface;

  ITMDBDiscoverMovieItem = interface;

  ITMDBDiscoverTVPage = interface;

  ITMDBDiscoverTVItem = interface;

  ITMDBItemList = interface;

  ITMDBMovieList = interface;

  ITMDBPersonList = interface;

  ITMDBTVSeriesList = interface;

  ITMDBTVEpisodeList = interface;

  ITMDBFindResults = interface;



  { API Service Forward Definitions }

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

  ITMDBServiceImages = interface;

  ITMDBClient = interface;

{$ENDREGION}



{$REGION 'Lists Pages and Items'}

  /// <summary>
  /// A single abstract item found in any given possible item list across TMDB.
  /// </summary>
  /// <remarks>
  /// - TODO: Change "Owner" from "ITMDBPage" to "ITMDBItemList".
  /// - TODO: Update all possible list item interfaces to inherit from this common base.
  /// </remarks}
  ITMDBPageItem = interface
    ['{9909E734-78DB-4CBB-B84D-A8E16315DA4E}']
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;

    property Owner: ITMDBPage read GetOwner;
    property Index: Integer read GetIndex;
  end;

  /// <summary>
  /// Base for each possible list of items
  /// </summary>
  /// <remarks>
  /// - TODO: Change all item lists to inherit from this new base.
  /// </remarks>
  ITMDBItemList = interface
    ['{3159DDC3-F510-4353-B24A-ACFD459948C9}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBPageItem read GetItem; default;
  end;

  /// <summary>
  /// A single abstract page of results, following TMDB's pagination standards.
  /// Supports a variety of page-related functions, such as page count,
  /// total result count, etc.
  /// </summary>
  /// <remarks>
  /// - TODO: Change to inherit from "ITMDBItemList" to reuse list functionality.
  /// </remarks>
  ITMDBPage = interface
    ['{F95555BF-1E0C-4E95-AE81-93A09EFA4EA3}']
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetPageItem(const Index: Integer): ITMDBPageItem; stdcall;

    property Page: Integer read GetPage;
    property Count: Integer read GetCount;
    property TotalPages: Integer read GetTotalPages;
    property TotalResults: Integer read GetTotalResults;
    property PageItems[const Index: Integer]: ITMDBPageItem read GetPageItem; default;
  end;

  /// <summary>
  /// Base type for any of the "media type" items which may be combined in a single list.
  /// This includes "media_type" values of "movie", "tv", and "person".
  /// </summary>
  ITMDBMediaBase = interface(ITMDBPageItem)
    ['{48B983F9-A07F-404D-9A5C-4FB7206D1407}']
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetAdult: Boolean; stdcall;
    function GetID: Integer; stdcall;
    function GetTitle: WideString; stdcall;
    function GetPopularity: Single; stdcall;

    property MediaType: TTMDBMediaType read GetMediaType;
    property Adult: Boolean read GetAdult;
    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
    property Popularity: Single read GetPopularity;
  end;

  /// <summary>
  /// A list of ITMDBMediaBase objects. Can contain a mix of any given
  /// media type, or all one specific media type.
  /// //TODO: Change to inherit from ITMDBItemList
  /// </summary>
  ITMDBMediaList = interface
    ['{3B5A5855-C20A-4F15-8AD0-A83D587C7623}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBMediaBase; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBMediaBase read GetItem; default;
  end;

  /// <summary>
  /// A page of ITMDBMediaBase objects. Much like ITMDBMediaList, but paginated.
  /// </summary>
  ITMDBMediaPage = interface(ITMDBPage)
    ['{31FFE854-7CAB-45A5-9ADC-6FB82F1AA8AF}']
    function GetItem(const Index: Integer): ITMDBMediaBase; stdcall;

    property Items[const Index: Integer]: ITMDBMediaBase read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Alternative Title Related'}

  { Alternative Title Related }

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

{$ENDREGION}



{$REGION 'Account Related'}

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

{$ENDREGION}



{$REGION 'Authentication Related'}

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

{$ENDREGION}



{$REGION 'Certification Related'}

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

{$ENDREGION}



{$REGION 'Translation Related'}

  { Translation Related }

  /// [DONE]
  ITMDBTranslationData = interface
    ['{7AD55E8C-BF41-45D1-AEF4-F17E797A4BBD}']

  end;

  /// [DONE]
  ITMDBMovieTranslationData = interface(ITMDBTranslationData)
    ['{09C095D9-4F9A-4E8C-8FA8-F71BA339DCEB}']
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetTagline: WideString; stdcall;
    function GetRuntime: Integer; stdcall;

    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
    property Tagline: WideString read GetTagline;
    property Runtime: Integer read GetRuntime;
  end;

  /// [DONE]
  ITMDBCollectionTranslationData = interface(ITMDBTranslationData)
    ['{AE77BCCF-6AD8-425D-9FF6-EE387DC5FD34}']
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;

    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
  end;

  /// [DONE]
  ITMDBPersonTranslationData = interface(ITMDBTranslationData)
    ['{BB5C94AD-1FC5-4B2E-9002-8927F803B3A9}']
    function GetBiography: WideString; stdcall;

    property Biography: WideString read GetBiography;
  end;

  /// [DONE]
  ITMDBTVSeriesTranslationData = interface(ITMDBTranslationData)
    ['{E5FC1F22-200A-4952-BE12-A891F08381CA}']
    function GetTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetTagline: WideString; stdcall;

    property Title: WideString read GetTitle;
    property Overview: WideString read GetOverview;
    property Homepage: WideString read GetHomepage;
    property Tagline: WideString read GetTagline;
  end;

  /// [DONE]
  ITMDBTVSeasonTranslationData = interface(ITMDBTranslationData)
    ['{3EDACBDD-D5E1-4E88-B46F-3BB871E53A64}']
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;

    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
  end;

  /// [DONE]
  ITMDBTVEpisodeTranslationData = interface(ITMDBTranslationData)
    ['{8D3E5163-C0D7-4102-9DD1-450267F442B5}']
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;

    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
  end;

  /// [DONE]
  ITMDBTranslationItem = interface
    ['{15A88780-ABF6-4EEA-AFFC-BC63A22A26BE}']
    function GetISO3166_1: WideString; stdcall;
    function GetISO639_1: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetEnglishName: WideString; stdcall;
    function GetMovieData: ITMDBMovieTranslationData; stdcall;
    function GetCollectionData: ITMDBCollectionTranslationData; stdcall;
    function GetPersonData: ITMDBPersonTranslationData; stdcall;
    function GetTVSeriesData: ITMDBTVSeriesTranslationData; stdcall;
    function GetTVSeasonData: ITMDBTVSeasonTranslationData; stdcall;
    function GetTVEpisodeData: ITMDBTVEpisodeTranslationData; stdcall;

    property ISO3166_1: WideString read GetISO3166_1;
    property ISO639_1: WideString read GetISO639_1;
    property Name: WideString read GetName;
    property EnglishName: WideString read GetEnglishName;
    property MovieData: ITMDBMovieTranslationData read GetMovieData;
    property CollectionData: ITMDBCollectionTranslationData read GetCollectionData;
    property PersonData: ITMDBPersonTranslationData read GetPersonData;
    property TVSeriesData: ITMDBTVSeriesTranslationData read GetTVSeriesData;
    property TVSeasonData: ITMDBTVSeasonTranslationData read GetTVSeasonData;
    property TVEpisodeData: ITMDBTVEpisodeTranslationData read GetTVEpisodeData;
  end;

  /// [DONE]
  ITMDBTranslationList = interface
    ['{7E5FB55A-B061-43A3-A6F9-DFB7AF75823D}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTranslationItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTranslationItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Release Date Related'}

  { Release Date Related }

  /// [DONE]
  ITMDBReleaseDateItem = interface
    ['{78E9A30C-DCDE-4DF5-A8A7-9BF08C210F90}']
    function GetCertification: WideString; stdcall;
    function GetDescriptors: TTMDBStrArray; stdcall; //https://www.themoviedb.org/talk/63bcd118a6e2d20083e25c74
    function GetISO639_1: WideString; stdcall;
    function GetNote: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetType: TTMDBReleaseType; stdcall;

    property Certification: WideString read GetCertification;
    property Descriptors: TTMDBStrArray read GetDescriptors;
    property ISO639_1: WideString read GetISO639_1;
    property Note: WideString read GetNote;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property ReleaseType: TTMDBReleaseType read GetType;
  end;

  /// [DONE]
  ITMDBReleaseDateCountry = interface
    ['{E466037A-7C13-4D5C-BE6E-42A49E6C2F8C}']
    function GetCountryCode: WideString; stdcall;
    function GetCountryName: WideString; stdcall;
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBReleaseDateItem; stdcall;

    property CountryCode: WideString read GetCountryCode;
    property CountryName: WideString read GetCountryName;
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDateItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBReleaseDateCountries = interface
    ['{F93CE7EB-EE02-4107-A412-F6161832333F}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBReleaseDateCountry; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBReleaseDateCountry read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Change Related'}

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

  /// [DONE]
  ITMDBChangeItem = interface(ITMDBPageItem)
    ['{04186AE5-0DFE-4E30-99A8-8B8CBC98E17F}']
    function GetKey: WideString; stdcall;
    function GetItem(const Index: Integer): ITMDBChangeRecord; stdcall;

    property Key: WideString read GetKey;
    property Items[const Index: Integer]: ITMDBChangeRecord read GetItem; default;
  end;

  /// [DONE]
  ITMDBChangePage = interface(ITMDBPage)
    ['{EEBB8A61-5597-4B56-B8AF-82E3C1F54F75}']
    function GetItem(const Index: Integer): ITMDBChangeItem; stdcall;

    property Items[const Index: Integer]: ITMDBChangeItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Collection Related'}

  { Collections Related }

  /// [DONE]
  ITMDBCollectionItem = interface(ITMDBPageItem)
    ['{C0911ACB-C909-438A-8DC3-5A67E5F4CB4F}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
  end;

  /// [DONE]
  ITMDBCollectionPage = interface(ITMDBPage)
    ['{7A7ADCD0-8062-4CF3-8D07-903DCCDA42E8}']
    function GetItem(const Index: Integer): ITMDBCollectionItem; stdcall;

    property Items[const Index: Integer]: ITMDBCollectionItem read GetItem; default;
  end;

  ITMDBCollectionPart = interface
    ['{C3706419-47B1-4CD9-879C-16259A116DF5}']
    function GetAdult: Boolean; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetTitle: WideString; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetPopularity: Single; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    //TODO: Add shortcut methods...

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property ID: Integer read GetID;
    property Title: WideString read GetTitle;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property MediaType: TTMDBMediaType read GetMediaType;
    property Genres: ITMDBGenreList read GetGenres;
    property Popularity: Single read GetPopularity;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  /// [DONE]
  ITMDBCollectionDetail = interface
    ['{78E5B1AC-0FF3-4472-886E-4A7696BE1E0E}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetBackdropPath: WideString; stdcall;
    function GetPartCount: Integer; stdcall;
    function GetPart(const Index: Integer): ITMDBCollectionPart; stdcall;

    function GetImages(const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetTranslations: ITMDBTranslationList; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property BackdropPath: WideString read GetBackdropPath;
    property PartCount: Integer read GetPartCount;
    property Parts[const Index: Integer]: ITMDBCollectionPart read GetPart; default;
  end;

{$ENDREGION}



{$REGION 'Company Related'}

  { Companies Related }

  /// [DONE]
  ITMDBCompanyItem = interface(ITMDBPageItem)
    ['{491A255A-0E29-43B3-8AAC-5F727D74DD98}']
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;

    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  /// [DONE]
  ITMDBCompanyPage = interface(ITMDBPage)
    ['{F3D62122-D304-4CA3-BE0C-72B1219E0DD1}']
    function GetItem(const Index: Integer): ITMDBCompanyItem; stdcall;

    property Items[const Index: Integer]: ITMDBCompanyItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBCompanyList = interface
    ['{BF6B6EC5-C0E1-4D7B-B987-8F2BE6AD4211}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCompanyItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBCompanyItem read GetItem; default;
  end;

  ITMDBCompanyDetail = interface
    ['{B5A7E62D-03AA-481A-BA02-DD4EAB7F6AC3}']
    function GetDescription: WideString; stdcall;
    function GetHeadquarters: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;
    function GetParentCompany: WideString; stdcall;

    property Description: WideString read GetDescription;
    property Headquarters: WideString read GetHeadquarters;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
    property ParentCompany: WideString read GetParentCompany;
  end;

{$ENDREGION}



{$REGION 'Configuration Related'}

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

{$ENDREGION}



{$REGION 'Country Related'}

  { Countries Related }

  /// <summary>
  /// A list containing all possible countries supported by TMDB.
  /// [DONE]
  /// </summary>
  ITMDBCountryList = interface
    ['{A1081041-E5B2-46C4-9905-EF7984C45FCA}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBCountryItem; stdcall;

    function GetByCode(const Code: WideString): ITMDBCountryItem; stdcall;

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

{$ENDREGION}



{$REGION 'Job / Department Related'}

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

{$ENDREGION}



{$REGION 'Language Related'}

  { Languages Related }

  /// <summary>
  ///
  /// [DONE]
  /// </summary>
  ITMDBLanguageList = interface
    ['{B08908B7-3C02-4BF9-8B94-AECF0EEC8D49}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBLanguageItem; stdcall;

    function GetByCode(const Code: WideString): ITMDBLanguageItem; stdcall;

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

{$ENDREGION}



{$REGION 'Timezone Related'}

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

{$ENDREGION}



{$REGION 'Genre Related'}

  { Genres Related }

  /// <summary>
  /// A list of genres.
  /// [DONE]
  /// </summary>
  ITMDBGenreList = interface
    ['{8C26B769-0488-47B8-BFBA-DA1D8DAA05E4}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBGenreItem; stdcall;
    function GetMediaType: TTMDBMediaType; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBGenreItem read GetItem; default;
    property MediaType: TTMDBMediaType read GetMediaType;
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

{$ENDREGION}



{$REGION 'Keyword Related'}

  { Keyword Related }

  /// [DONE]
  ITMDBKeywordItem = interface(ITMDBPageItem)
    ['{98460089-3E55-4022-A8AC-863EDBB8567A}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

  /// [DONE]
  ITMDBKeywordList = interface(ITMDBItemList)
    ['{3E3016F7-4459-4C65-87E8-DCE6B023EBDF}']
    function GetItem(const Index: Integer): ITMDBKeywordItem; stdcall;

    property Items[const Index: Integer]: ITMDBKeywordItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBKeywordPage = interface(ITMDBPage)
    ['{DC679E95-D35E-4361-AF65-D1F10C52B881}']
    function GetItem(const Index: Integer): ITMDBKeywordItem; stdcall;

    property Items[const Index: Integer]: ITMDBKeywordItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBKeywordDetail = interface
    ['{FEF48832-CA59-4AEF-83D9-8167C136DC4B}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
  end;

{$ENDREGION}



{$REGION 'Image Related'}

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
    function GetID: Integer; stdcall;

    property Backdrops: ITMDBMediaImageList read GetBackdrops;
    property Logos: ITMDBMediaImageList read GetLogos;
    property Posters: ITMDBMediaImageList read GetPosters;
    property ID: Integer read GetID;
  end;

{$ENDREGION}



{$REGION 'Video Related'}

  { Video Related }

  /// [DONE]
  ITMDBVideoItem = interface
    ['{EC411DD6-C212-4DA8-9421-688E099079B3}']
    function GetISO639_1: WideString; stdcall;
    function GetISO3166_1: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetKey: WideString; stdcall;
    function GetSite: WideString; stdcall;
    function GetSize: Integer; stdcall;
    function GetType: WideString; stdcall;
    function GetOfficial: Boolean; stdcall;
    function GetPublishedAt: TDateTime; stdcall;
    function GetID: WideString; stdcall;

    property ISO639_1: WideString read GetISO639_1;
    property ISO3166_1: WideString read GetISO3166_1;
    property Name: WideString read GetName;
    property Key: WideString read GetKey;
    property Site: WideString read GetSite;
    property Size: Integer read GetSize;
    property VideoType: WideString read GetType;
    property Official: Boolean read GetOfficial;
    property PublishedAt: TDateTime read GetPublishedAt;
    property ID: WideString read GetID;
  end;

  /// [DONE]
  ITMDBVideoList = interface
    ['{1346CC9D-5897-4BBB-B140-5FEB6A892552}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBVideoItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBVideoItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Person Related'}

  { People Related }

  ITMDBPersonItem = interface(ITMDBMediaBase)
    ['{28C68CE8-358F-4C6E-B4D1-E859D8CCBD65}']
    function GetGender: TTMDBGender; stdcall;
    function GetKnownForDepartment: WideString; stdcall;
    function GetProfilePath: WideString; stdcall;
    function GetKnownFor: ITMDBMediaList; stdcall;

    property Gender: TTMDBGender read GetGender;
    property KnownForDepartment: WideString read GetKnownForDepartment;
    property ProfilePath: WideString read GetProfilePath;
    property KnownFor: ITMDBMediaList read GetKnownFor;
  end;

  /// [DONE]
  ITMDBPersonPage = interface(ITMDBPage)
    ['{88C5FCB1-50A7-4D3A-AB69-95B542D77FD5}']
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;

    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;

  /// <summary>
  /// A list of people
  /// TODO: Change to inherit from ITMDBMediaList...
  /// </summary>
  ITMDBPersonList = interface(ITMDBMediaList)
    ['{80B66DAA-C18D-427B-9A0C-B0F070725B83}']
    function GetItem(const Index: Integer): ITMDBPersonItem; stdcall;

    property Items[const Index: Integer]: ITMDBPersonItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'Credit Related'}

  { Credit Related }

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

  /// [DONE]
  ITMDBCredits = interface
    ['{6A1470C6-79DA-4EE8-B43E-F76EEA9015B9}']
    function GetCast: ITMDBCastList; stdcall;
    function GetCrew: ITMDBCrewList; stdcall;

    property Cast: ITMDBCastList read GetCast;
    property Crew: ITMDBCrewList read GetCrew;
  end;

{$ENDREGION}



{$REGION 'Movie Related'}

  { Movies Related }

  /// <summary>
  /// A single movie in an ITMDBMoviePage.
  /// </summary>
  ITMDBMovieItem = interface(ITMDBMediaBase)
    ['{00EB49F1-F0EA-4E7A-859E-38632667BA87}']
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalTitle: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetReleaseDate: TDateTime; stdcall;
    function GetVideo: Boolean; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    function GetDetails: ITMDBMovieDetail; stdcall;
    //function GetAccountStates: ITMDBAccountStates; stdcall;
    //function GetAlternativeTitles(const Country: WideString = ''): ITMDBAlternativeTitles; stdcall;
    //function GetChanges(const StartDate, EndDate: TDateTime;
    //  const Page: Integer = 1): ITMDBChangePage; stdcall;
    //function GetCredits: ITMDBCredits; stdcall;
    //function GetExternalIDs: ITMDBExternalIDs; stdcall;
    //function GetImages(): ITMDBMediaImages; stdcall;
    //function GetKeywords: ITMDBKeywordList; stdcall;
    //function GetLists(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBListPage; stdcall;
    //function GetRecommendations(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetReleaseDates: ITMDBReleaseDateCountries; stdcall;
    //function GetReviews(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBReviewList; stdcall;
    //function GetSimilar(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetTranslations: ITMDBTranslationList; stdcall;
    //function GetVideos(const Language: WideString): ITMDBVideoList; stdcall;

    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenreList read GetGenres;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalTitle: WideString read GetOriginalTitle;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property ReleaseDate: TDateTime read GetReleaseDate;
    property Video: Boolean read GetVideo;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

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
  /// A list of movies
  /// [DONE]
  /// </summary>
  ITMDBMovieList = interface(ITMDBMediaList)
    ['{AC2F3E06-A3C5-4B7B-B83C-23258F6E2FEF}']
    function GetItem(const Index: Integer): ITMDBMovieItem; stdcall;

    property Items[const Index: Integer]: ITMDBMovieItem read GetItem; default;
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
    function AppendedChanges: ITMDBChangePage; stdcall;
    function AppendedCredits: ITMDBCredits; stdcall;
    //function AppendedExternalIDs: ITMDBExternalIDs; stdcall;
    function AppendedImages: ITMDBMediaImages; stdcall;
    function AppendedKeywords: ITMDBKeywordList; stdcall;
    //function AppendedLists: ITMDBListPage; stdcall;
    //function AppendedRecommendations: ITMDB; stdcall;
    function AppendedReleaseDates: ITMDBReleaseDateCountries; stdcall;
    //function AppendedReviews: ITMDBReviewList; stdcall;
    function AppendedSimilar: ITMDBMoviePage; stdcall;
    function AppendedTranslations: ITMDBTranslationList; stdcall;
    function AppendedVideos: ITMDBVideoList; stdcall;

    function AddToFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function RemoveFromFavorites: ITMDBAccountAddFavoriteResult; stdcall;
    function AddToWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    function RemoveFromWatchlist: ITMDBAccountAddWatchlistResult; stdcall;
    //function AddRating(const Rating: Single): ITMDB...
    //function RemoveRating: ITMDB...

    //TODO: Should I share these with "Appended" data?
    //  For example, if (Has Appended Data) then (Use Appended Data) else (Fetch Data)
    //function GetAccountStates: ITMDBAccountStates; stdcall;
    //function GetAlternativeTitles(const Country: WideString = ''): ITMDBAlternativeTitles; stdcall;
    //function GetChanges(const StartDate, EndDate: TDateTime;
    //  const Page: Integer = 1): ITMDBChangePage; stdcall;
    //function GetCredits: ITMDBCredits; stdcall;
    //function GetExternalIDs: ITMDBExternalIDs; stdcall;
    //function GetImages(): ITMDBMediaImages; stdcall;
    //function GetKeywords: ITMDBKeywordList; stdcall;
    //function GetLists(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBListPage; stdcall;
    //function GetRecommendations(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetReleaseDates: ITMDBReleaseDateCountries; stdcall;
    //function GetReviews(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBReviewList; stdcall;
    //function GetSimilar(const Language: WideString = '';
    //  const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetTranslations: ITMDBTranslationList; stdcall;
    //function GetVideos(const Language: WideString): ITMDBVideoList; stdcall;

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

{$ENDREGION}



{$REGION 'Movie List Related'}

  { Movie Lists Related }

  /// [DONE]
  ITMDBDateRange = interface
    ['{CB7698C0-AB5A-4C5D-9043-02E049BAB915}']
    function GetMinimum: TDateTime; stdcall;
    function GetMaximum: TDateTime; stdcall;

    property Minimum: TDateTime read GetMinimum;
    property Maximum: TDateTime read GetMaximum;
  end;

  ITMDBDatedMoviePage = interface(ITMDBMoviePage)
    ['{E1E4F07E-30EE-4D36-946B-621D98F1EBCB}']
    function GetDates: ITMDBDateRange; stdcall;

    property Dates: ITMDBDateRange read GetDates;
  end;

{$ENDREGION}



{$REGION 'Network Related'}

  { Network Related }

  /// [DONE]
  ITMDBTVNetworkList = interface
    ['{2569A653-F292-4E48-8FE1-DBBCCE289102}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBTVNetworkItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBTVNetworkItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBTVNetworkItem = interface
    ['{BCC9E4A7-07DD-416E-9F04-54CDC2A50DA3}']
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;

    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

  /// [DONE]
  ITMDBTVNetworkDetail = interface
    ['{B3293FC5-F238-4B3D-B3F2-CF4C894BD0EE}']
    function GetHeadquarters: WideString; stdcall;
    function GetHomepage: WideString; stdcall;
    function GetID: Integer; stdcall;
    function GetLogoPath: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOriginCountry: WideString; stdcall;

    property Headquarters: WideString read GetHeadquarters;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property LogoPath: WideString read GetLogoPath;
    property Name: WideString read GetName;
    property OriginCountry: WideString read GetOriginCountry;
  end;

{$ENDREGION}



{$REGION 'Content Rating Related'}

  ITMDBContentRatingItem = interface
    ['{D6DDA578-E421-4CB9-8436-A24EADEC8D06}']
    function GetDescriptors: TTMDBStrArray; stdcall;
    function GetISO3166_1: WideString; stdcall;
    function GetRating: WideString; stdcall;

    property Descriptors: TTMDBStrArray read GetDescriptors;
    property ISO3166_1: WideString read GetISO3166_1;
    property Rating: WideString read GetRating;
  end;

  ITMDBContentRatingList = interface
    ['{DBCEC84C-C2A6-4243-90B8-114BEA06A6A3}']
    function GetCount: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBContentRatingItem; stdcall;

    property Count: Integer read GetCount;
    property Items[const Index: Integer]: ITMDBContentRatingItem read GetItem; default;
  end;

{$ENDREGION}



{$REGION 'TV Series Related'}

  { TV Series Related }

  /// <summary>
  /// A paginated list containing TV Series results.
  /// [DONE]
  /// </summary>
  ITMDBTVSeriesPage = interface(ITMDBPage)
    ['{05742B99-FDCC-47E5-B34F-987ECA5DEBA2}']
    function GetItem(const Index: Integer): ITMDBTVSeriesItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVSeriesItem read GetItem; default;
  end;

  /// <summary>
  /// A single TV Show in an ITMDBTVPage.
  /// [DONE]
  /// </summary>
  ITMDBTVSeriesItem = interface(ITMDBMediaBase)
    ['{7907FF27-E02F-4270-9AAB-322E6C31516D}']
    function GetBackdropPath: WideString; stdcall;
    function GetGenres: ITMDBGenreList; stdcall;
    function GetOriginCountry: TTMDBStrArray;
    function GetOriginalLanguage: WideString; stdcall;
    function GetOriginalName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetPosterPath: WideString; stdcall;
    function GetFirstAirDate: TDateTime; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;

    property BackdropPath: WideString read GetBackdropPath;
    property Genres: ITMDBGenreList read GetGenres;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property PosterPath: WideString read GetPosterPath;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

  /// <summary>
  /// A list of TV series
  /// [DONE]
  /// </summary>
  ITMDBTVSeriesList = interface(ITMDBMediaList)
    ['{13D059E8-BC04-423B-AA5B-8590DFA6E97F}']
    function GetItem(const Index: Integer): ITMDBTVSeriesItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVSeriesItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBRatedTVSeriesPage = interface(ITMDBTVSeriesPage)
    ['{AD5E62E1-41CE-4564-8407-DCEE9F2F0756}']
    function GetItem(const Index: Integer): ITMDBRatedTVSeriesItem; stdcall;

    property Items[const Index: Integer]: ITMDBRatedTVSeriesItem read GetItem; default;
  end;

  /// [DONE]
  ITMDBRatedTVSeriesItem = interface(ITMDBTVSeriesItem)
    ['{D48E190F-3095-452A-AE5C-75E70DB7C709}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
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
    function GetNextEpisodeToAir: ITMDBTVEpisodeItem;
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

    property Adult: Boolean read GetAdult;
    property BackdropPath: WideString read GetBackdropPath;
    property CreatedBy: ITMDBPersonList read GetCreatedBy;
    property EpisodeRunTime: TTMDBIntArray read GetEpisodeRunTime;
    property FirstAirDate: TDateTime read GetFirstAirDate;
    property Genres: ITMDBGenreList read GetGenres;
    property Homepage: WideString read GetHomepage;
    property ID: Integer read GetID;
    property InProduction: Boolean read GetInProduction;
    property Languages: TTMDBStrArray read GetLanguages;
    property LastAirDate: TDateTime read GetLastAirDate;
    property LastEpisodeToAir: ITMDBTVEpisodeItem read GetLastEpisodeToAir;
    property Name: WideString read GetName;
    property NextEpisodeToAir: ITMDBTVEpisodeItem read GetNextEpisodeToAir;
    property Networks: ITMDBTVNetworkList read GetNetworks;
    property NumberOfEpisodes: Integer read GetNumberOfEpisodes;
    property NumberOfSeasons: Integer read GetNumberOfSeasons;
    property OriginCountry: TTMDBStrArray read GetOriginCountry;
    property OriginalLanguage: WideString read GetOriginalLanguage;
    property OriginalName: WideString read GetOriginalName;
    property Overview: WideString read GetOverview;
    property Popularity: Single read GetPopularity;
    property PosterPath: WideString read GetPosterPath;
    property ProductionCompanies: ITMDBCompanyList read GetProductionCompanies;
    property ProductionCountries: ITMDBCountryList read GetProductionCountries;
    //TODO: Seasons
    property SpokenLanguages: ITMDBLanguageList read GetSpokenLanguages;
    property Status: WideString read GetStatus;
    property Tagline: WideString read GetTagline;
    property SeriesType: WideString read GetType;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
  end;

{$ENDREGION}



{$REGION 'TV Season Related'}

  /// [DONE]
  ITMDBTVSeasonPage = interface(ITMDBPage)
    ['{697CDF42-1FE5-49C3-92C5-87BE730AD427}']
    function GetItem(const Index: Integer): ITMDBTVSeasonItem;

    property Items[const Index: Integer]: ITMDBTVSeasonItem read GetItem; default;
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

  ITMDBTVSeasonItem = interface(ITMDBPageItem)
    ['{A3291740-EB50-467E-8B82-ED5F3463A882}']
    function GetID: Integer;
    function GetSeasonNumber: Integer;

  end;

{$ENDREGION}



{$REGION 'TV Episode Related'}

  ITMDBTVEpisodeItem = interface(ITMDBPageItem)
    ['{2B2377B6-CEB0-47E0-9B64-D259600DECB4}']
    function GetID: Integer; stdcall;
    function GetName: WideString; stdcall;
    function GetOverview: WideString; stdcall;
    function GetVoteAverage: Single; stdcall;
    function GetVoteCount: Integer; stdcall;
    function GetAirDate: TDateTime; stdcall;
    function GetEpisodeNumber: Integer; stdcall;
    function GetProductionCode: WideString; stdcall;
    function GetRuntime: Integer; stdcall;
    function GetSeasonNumber: Integer; stdcall;
    function GetShowID: Integer; stdcall;
    function GetStillPath: WideString; stdcall;
    function GetOrder: Integer; stdcall;

    property ID: Integer read GetID;
    property Name: WideString read GetName;
    property Overview: WideString read GetOverview;
    property VoteAverage: Single read GetVoteAverage;
    property VoteCount: Integer read GetVoteCount;
    property AirDate: TDateTime read GetAirDate;
    property EpisodeNumber: Integer read GetEpisodeNumber;
    property ProductionCode: WideString read GetProductionCode;
    property Runtime: Integer read GetRuntime;
    property SeasonNumber: Integer read GetSeasonNumber;
    property ShowID: Integer read GetShowID;
    property StillPath: WideString read GetStillPath;
    property Order: Integer read GetOrder;
  end;

  ITMDBTVEpisodePage = interface(ITMDBPage)
    ['{BB238B34-1BA9-411C-92AF-B43C6DD6702A}']
    function GetItem(const Index: Integer): ITMDBTVEpisodeItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVEpisodeItem read GetItem; default;
  end;

  /// <summary>
  /// A list of TV episodes
  /// </summary>
  ITMDBTVEpisodeList = interface(ITMDBItemList)
    ['{C574FEB8-2F01-408A-95B5-6B80E218EECD}']
    function GetItem(const Index: Integer): ITMDBTVEpisodeItem; stdcall;

    property Items[const Index: Integer]: ITMDBTVEpisodeItem read GetItem; default;
  end;

  ITMDBRatedTVEpisodePage = interface(ITMDBTVEpisodePage)
    ['{DDC4B9FA-AC4B-4EAC-B9B8-78464034BC68}']
    function GetItem(const Index: Integer): ITMDBRatedTVEpisodeItem; stdcall;

    property Items[const Index: Integer]: ITMDBRatedTVEpisodeItem read GetItem; default;
  end;

  ITMDBRatedTVEpisodeItem = interface(ITMDBTVEpisodeItem)
    ['{0FDB3732-0EB1-43FF-A006-4E6EFC411C54}']
    function GetRating: Single; stdcall;

    property Rating: Single read GetRating;
  end;

{$ENDREGION}



{$REGION 'TV Episode Group Related'}

  { Episode Group Related }

  ITMDBTVEpisodeGroup = interface;

  ITMDBTVEpisodeGroupResponse = interface
    ['{14C7DEAF-20B9-4541-BBF8-D9A9A8E8205E}']
    function GetDescription: WideString; stdcall;
    function GetEpisodeCount: Integer; stdcall;
    function GetGroupCount: Integer; stdcall;
    function GetGroup(const Index: Integer): ITMDBTVEpisodeGroup; stdcall;
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetNetwork: ITMDBTVNetworkItem; stdcall;
    function GetType: TTMDBTVEpisodeGroupType; stdcall;

    property Description: WideString read GetDescription;
    property EpisodeCount: Integer read GetEpisodeCount;
    property GroupCount: Integer read GetGroupCount;
    property Groups[const Index: Integer]: ITMDBTVEpisodeGroup read GetGroup; default;
    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Network: ITMDBTVNetworkItem read GetNetwork;
    property GroupType: TTMDBTVEpisodeGroupType read GetType;
  end;

  ITMDBTVEpisodeGroup = interface
    ['{EBECFB23-6043-4830-8497-EAE3A6AD5E6B}']
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetOrder: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetEpisode(const Index: Integer): ITMDBTVEpisodeItem; stdcall;
    function GetLocked: Boolean; stdcall;

    property ID: WideString read GetID;
    property Name: WideString read GetName;
    property Order: Integer read GetOrder;
    property Count: Integer read GetCount;
    property Episodes[const Index: Integer]: ITMDBTVEpisodeItem read GetEpisode; default;
    property Locked: Boolean read GetLocked;
  end;

{$ENDREGION}



{$REGION 'List Related'}

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
    function GetISO639_1: WideString;
    function GetListType: TTMDBListType;
    function GetName: WideString;
    function GetPosterPath: WideString;

    property Description: WideString read GetDescription;
    property FavoriteCount: Integer read GetFavoriteCount;
    property ID: Integer read GetID;
    property ISO639_1: WideString read GetISO639_1;
    property ListType: TTMDBListType read GetListType;
    property Name: WideString read GetName;
    property PosterPath: WideString read GetPosterPath;
  end;

{$ENDREGION}



{$REGION 'Discover Related'}

  { Discover Related }

  ITMDBDiscoverMoviesParams = interface
    ['{700EDC98-83A5-41FB-AB34-4326179EE37B}']
    function GetCertification: WideString;
    function GetCertificationGTE: WideString;
    function GetCertificationLTE: WideString;
    function GetCertificationCountry: WideString;
    function GetIncludeAdult: Boolean;
    function GetIncludeVideo: Boolean;
    function GetLanguage: WideString;
    function GetPrimaryReleaseYear: Integer;
    function GetPrimaryReleaseDateGTE: TDateTime;
    function GetPrimaryReleaseYearLTE: TDateTime;
    function GetRegion: WideString;
    function GetReleaseDateGTE: TDateTime;
    function GetReleaseDateLTE: TDateTime;
    function GetSortBy: WideString;
    function GetVoteAverageGTE: Single;
    function GetVoteAverageLTE: Single;
    function GetVoteCountGTE: Single;
    function GetVoteCountLTE: Single;
    function GetWatchRegion: WideString;
    function GetWithCast: WideString;
    function GetWithCompanies: WideString;
    function GetWithCrew: WideString;
    function GetWithGenres: WideString;
    function GetWithKeywords: WideString;
    function GetWithOriginCountry: WideString;
    function GetWithOriginalLanguage: WideString;
    function GetWithPeople: WideString;
    function GetWithReleaseType: WideString;
    function GetWithRuntimeGTE: Integer;
    function GetWithRuntimeLTE: Integer;
    function GetWithWatchMonetizationTypes: WideString;
    function GetWithWatchProviders: WideString;
    function GetWithoutCompanies: WideString;
    function GetWithoutGenres: WideString;
    function GetWithoutKeywords: WideString;
    function GetWithoutWatchProviders: WideString;
    function GetYear: Integer;

    procedure SetCertification(const AValue: WideString);
    procedure SetCertificationGTE(const AValue: WideString);
    procedure SetCertificationLTE(const AValue: WideString);
    procedure SetCertificationCountry(const AValue: WideString);
    procedure SetIncludeAdult(const AValue: Boolean);
    procedure SetIncludeVideo(const AValue: Boolean);
    procedure SetLanguage(const AValue: WideString);
    procedure SetPrimaryReleaseYear(const AValue: Integer);
    procedure SetPrimaryReleaseDateGTE(const AValue: TDateTime);
    procedure SetPrimaryReleaseYearLTE(const AValue: TDateTime);
    procedure SetRegion(const AValue: WideString);
    procedure SetReleaseDateGTE(const AValue: TDateTime);
    procedure SetReleaseDateLTE(const AValue: TDateTime);
    procedure SetSortBy(const AValue: WideString);
    procedure SetVoteAverageGTE(const AValue: Single);
    procedure SetVoteAverageLTE(const AValue: Single);
    procedure SetVoteCountGTE(const AValue: Single);
    procedure SetVoteCountLTE(const AValue: Single);
    procedure SetWatchRegion(const AValue: WideString);
    procedure SetWithCast(const AValue: WideString);
    procedure SetWithCompanies(const AValue: WideString);
    procedure SetWithCrew(const AValue: WideString);
    procedure SetWithGenres(const AValue: WideString);
    procedure SetWithKeywords(const AValue: WideString);
    procedure SetWithOriginCountry(const AValue: WideString);
    procedure SetWithOriginalLanguage(const AValue: WideString);
    procedure SetWithPeople(const AValue: WideString);
    procedure SetWithReleaseType(const AValue: WideString);
    procedure SetWithRuntimeGTE(const AValue: Integer);
    procedure SetWithRuntimeLTE(const AValue: Integer);
    procedure SetWithWatchMonetizationTypes(const AValue: WideString);
    procedure SetWithWatchProviders(const AValue: WideString);
    procedure SetWithoutCompanies(const AValue: WideString);
    procedure SetWithoutGenres(const AValue: WideString);
    procedure SetWithoutKeywords(const AValue: WideString);
    procedure SetWithoutWatchProviders(const AValue: WideString);
    procedure SetYear(const AValue: Integer);

    property Certification: WideString read GetCertification write SetCertification;
    property CertificationGTE: WideString read GetCertificationGTE write SetCertificationGTE;
    property CertificationLTE: WideString read GetCertificationLTE write SetCertificationLTE;
    property CertificationCountry: WideString read GetCertificationCountry write SetCertificationCountry;
    property IncludeAdult: Boolean read GetIncludeAdult write SetIncludeAdult;
    property IncludeVideo: Boolean read GetIncludeVideo write SetIncludeVideo;
    property Language: WideString read GetLanguage write SetLanguage;
    property PrimaryReleaseYear: Integer read GetPrimaryReleaseYear write SetPrimaryReleaseYear;
    property PrimaryReleaseDateGTE: TDateTime read GetPrimaryReleaseDateGTE write SetPrimaryReleaseDateGTE;
    property PrimaryReleaseYearLTE: TDateTime read GetPrimaryReleaseYearLTE write SetPrimaryReleaseYearLTE;
    property Region: WideString read GetRegion write SetRegion;
    property ReleaseDateGTE: TDateTime read GetReleaseDateGTE write SetReleaseDateGTE;
    property ReleaseDateLTE: TDateTime read GetReleaseDateLTE write SetReleaseDateLTE;
    property SortBy: WideString read GetSortBy write SetSortBy;
    property VoteAverageGTE: Single read GetVoteAverageGTE write SetVoteAverageGTE;
    property VoteAverageLTE: Single read GetVoteAverageLTE write SetVoteAverageLTE;
    property VoteCountGTE: Single read GetVoteCountGTE write SetVoteCountGTE;
    property VoteCountLTE: Single read GetVoteCountLTE write SetVoteCountLTE;
    property WatchRegion: WideString read GetWatchRegion write SetWatchRegion;
    property WithCast: WideString read GetWithCast write SetWithCast;
    property WithCompanies: WideString read GetWithCompanies write SetWithCompanies;
    property WithCrew: WideString read GetWithCrew write SetWithCrew;
    property WithGenres: WideString read GetWithGenres write SetWithGenres;
    property WithKeywords: WideString read GetWithKeywords write SetWithKeywords;
    property WithOriginCountry: WideString read GetWithOriginCountry write SetWithOriginCountry;
    property WithOriginalLanguage: WideString read GetWithOriginalLanguage write SetWithOriginalLanguage;
    property WithPeople: WideString read GetWithPeople write SetWithPeople;
    property WithReleaseType: WideString read GetWithReleaseType write SetWithReleaseType;
    property WithRuntimeGTE: Integer read GetWithRuntimeGTE write SetWithRuntimeGTE;
    property WithRuntimeLTE: Integer read GetWithRuntimeLTE write SetWithRuntimeLTE;
    property WithWatchMonetizationTypes: WideString read GetWithWatchMonetizationTypes write SetWithWatchMonetizationTypes;
    property WithWatchProviders: WideString read GetWithWatchProviders write SetWithWatchProviders;
    property WithoutCompanies: WideString read GetWithoutCompanies write SetWithoutCompanies;
    property WithoutGenres: WideString read GetWithoutGenres write SetWithoutGenres;
    property WithoutKeywords: WideString read GetWithoutKeywords write SetWithoutKeywords;
    property WithoutWatchProviders: WideString read GetWithoutWatchProviders write SetWithoutWatchProviders;
    property Year: Integer read GetYear write SetYear;
  end;

  ITMDBDiscoverTVParams = interface
    ['{C2E7A309-1E14-4D62-BC23-505525F3D9D4}']
    function GetAirDateGTE: TDateTime;
    function GetAirDateLTE: TDateTime;
    function GetFirstAirDateYear: Integer;
    function GetFirstAirDateGTE: TDateTime;
    function GetFirstAirDateLTE: TDAteTime;
    function GetIncludeAdult: Boolean;
    function GetIncludeNullFirstAirDates: Boolean;
    function GetLanguage: WideString;
    function GetScreenedTheatrically: Boolean;
    function GetSortBy: WideString;
    function GetTimezone: WideString;
    function GetVoteAverageGTE: Single;
    function GetVoteAverageLTE: Single;
    function GetVoteCountGTE: Single;
    function GetVoteCountLTE: Single;
    function GetWatchRegion: WideString;
    function GetWithCompanies: WideString;
    function GetWithGenres: WideString;
    function GetWithKeywords: WideString;
    function GetWithNetworks: Integer;
    function GetWithOriginCountry: WideString;
    function GetWithOriginalLanguage: WideString;
    function GetWithRuntimeGTE: Integer;
    function GetWithRuntimeLTE: Integer;
    function GetWithStatus: WideString;
    function GetWithWatchMonetizationTypes: WideString;
    function GetWithWatchProviders: WideString;
    function GetWithoutCompoanies: WideString;
    function GetWithoutGenres: WideString;
    function GetWithoutKeywords: WideString;
    function GetWithoutWatchProviders: WideString;
    function GetWithType: WideString;

    procedure SetAirDateGTE(const AValue: TDateTime);
    procedure SetAirDateLTE(const AValue: TDateTime);
    procedure SetFirstAirDateYear(const AValue: Integer);
    procedure SetFirstAirDateGTE(const AValue: TDateTime);
    procedure SetFirstAirDateLTE(const AValue: TDAteTime);
    procedure SetIncludeAdult(const AValue: Boolean);
    procedure SetIncludeNullFirstAirDates(const AValue: Boolean);
    procedure SetLanguage(const AValue: WideString);
    procedure SetScreenedTheatrically(const AValue: Boolean);
    procedure SetSortBy(const AValue: WideString);
    procedure SetTimezone(const AValue: WideString);
    procedure SetVoteAverageGTE(const AValue: Single);
    procedure SetVoteAverageLTE(const AValue: Single);
    procedure SetVoteCountGTE(const AValue: Single);
    procedure SetVoteCountLTE(const AValue: Single);
    procedure SetWatchRegion(const AValue: WideString);
    procedure SetWithCompanies(const AValue: WideString);
    procedure SetWithGenres(const AValue: WideString);
    procedure SetWithKeywords(const AValue: WideString);
    procedure SetWithNetworks(const AValue: Integer);
    procedure SetWithOriginCountry(const AValue: WideString);
    procedure SetWithOriginalLanguage(const AValue: WideString);
    procedure SetWithRuntimeGTE(const AValue: Integer);
    procedure SetWithRuntimeLTE(const AValue: Integer);
    procedure SetWithStatus(const AValue: WideString);
    procedure SetWithWatchMonetizationTypes(const AValue: WideString);
    procedure SetWithWatchProviders(const AValue: WideString);
    procedure SetWithoutCompoanies(const AValue: WideString);
    procedure SetWithoutGenres(const AValue: WideString);
    procedure SetWithoutKeywords(const AValue: WideString);
    procedure SetWithoutWatchProviders(const AValue: WideString);
    procedure SetWithType(const AValue: WideString);

    property AirDateGTE: TDateTime read GetAirDateGTE write SetAirDateGTE;
    property AirDateLTE: TDateTime read GetAirDateLTE write SetAirDateLTE;
    property FirstAirDateYear: Integer read GetFirstAirDateYear write SetFirstAirDateYear;
    property FirstAirDateGTE: TDateTime read GetFirstAirDateGTE write SetFirstAirDateGTE;
    property FirstAirDateLTE: TDAteTime read GetFirstAirDateLTE write SetFirstAirDateLTE;
    property IncludeAdult: Boolean read GetIncludeAdult write SetIncludeAdult;
    property IncludeNullFirstAirDates: Boolean read GetIncludeNullFirstAirDates write SetIncludeNullFirstAirDates;
    property Language: WideString read GetLanguage write SetLanguage;
    property ScreenedTheatrically: Boolean read GetScreenedTheatrically write SetScreenedTheatrically;
    property SortBy: WideString read GetSortBy write SetSortBy;
    property Timezone: WideString read GetTimezone write SetTimezone;
    property VoteAverageGTE: Single read GetVoteAverageGTE write SetVoteAverageGTE;
    property VoteAverageLTE: Single read GetVoteAverageLTE write SetVoteAverageLTE;
    property VoteCountGTE: Single read GetVoteCountGTE write SetVoteCountGTE;
    property VoteCountLTE: Single read GetVoteCountLTE write SetVoteCountLTE;
    property WatchRegion: WideString read GetWatchRegion write SetWatchRegion;
    property WithCompanies: WideString read GetWithCompanies write SetWithCompanies;
    property WithGenres: WideString read GetWithGenres write SetWithGenres;
    property WithKeywords: WideString read GetWithKeywords write SetWithKeywords;
    property WithNetworks: Integer read GetWithNetworks write SetWithNetworks;
    property WithOriginCountry: WideString read GetWithOriginCountry write SetWithOriginCountry;
    property WithOriginalLanguage: WideString read GetWithOriginalLanguage write SetWithOriginalLanguage;
    property WithRuntimeGTE: Integer read GetWithRuntimeGTE write SetWithRuntimeGTE;
    property WithRuntimeLTE: Integer read GetWithRuntimeLTE write SetWithRuntimeLTE;
    property WithStatus: WideString read GetWithStatus write SetWithStatus;
    property WithWatchMonetizationTypes: WideString read GetWithWatchMonetizationTypes write SetWithWatchMonetizationTypes;
    property WithWatchProviders: WideString read GetWithWatchProviders write SetWithWatchProviders;
    property WithoutCompoanies: WideString read GetWithoutCompoanies write SetWithoutCompoanies;
    property WithoutGenres: WideString read GetWithoutGenres write SetWithoutGenres;
    property WithoutKeywords: WideString read GetWithoutKeywords write SetWithoutKeywords;
    property WithoutWatchProviders: WideString read GetWithoutWatchProviders write SetWithoutWatchProviders;
    property WithType: WideString read GetWithType write SetWithType;
  end;

  ITMDBDiscoverMoviePage = interface(ITMDBMoviePage)
    ['{DF3A6755-6B14-4A74-832F-865B4764D012}']

  end;

  ITMDBDiscoverMovieItem = interface(ITMDBMovieItem)
    ['{183EA5A3-E50B-4002-8B6F-A388C19DDF66}']

  end;

  ITMDBDiscoverTVPage = interface(ITMDBTVSeriesPage)
    ['{A2A8C881-C40C-4115-A4FA-F28BCF281F40}']

  end;

  ITMDBDiscoverTVItem = interface(ITMDBTVSeriesItem)
    ['{41B039D6-31F6-42B9-B69F-7D9F8B6E6DAD}']

  end;

{$ENDREGION}



{$REGION 'Find Related'}

  { Find Related }

  /// <summary>
  /// The resposne of calling Find By ID containing several lists of results.
  /// [DONE]
  /// </summary>
  ITMDBFindResults = interface
    ['{4A7BEA80-3F67-4CF2-8A79-31CA9E19EB0D}']
    function GetMovieResults: ITMDBMovieList;
    function GetPersonResults: ITMDBPersonList;
    function GetTVResults: ITMDBTVSeriesList;
    function GetTVEpisodeResults: ITMDBTVEpisodeList;
    function GetTVSeasonResults: ITMDBTVSeasonList;

    property MovieResults: ITMDBMovieList read GetMovieResults;
    property PersonResults: ITMDBPersonList read GetPersonResults;
    property TVResults: ITMDBTVSeriesList read GetTVResults;
    property TVEpisodeResults: ITMDBTVEpisodeList read GetTVEpisodeResults;
    property TVSeasonResults: ITMDBTVSeasonList read GetTVSeasonResults;
  end;

{$ENDREGION}



{$REGION 'Watch Provider Related'}

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

{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'API Service Related'}

  { API Services }

  /// <summary>
  /// Base interface for each possible TMDB service category.
  /// [DONE]
  /// </summary>
  ITMDBService = interface
    ['{0E665C12-812B-4B2D-8A48-17A16740290C}']
    function GetOwner: ITMDBClient;

    property Owner: ITMDBClient read GetOwner;
  end;

  /// [DONE]
  ITMDBServiceAccount = interface(ITMDBService)
    ['{E690DF1A-6680-4040-BBC6-ABE0D4CC6916}']
    function GetDetails(AAccountID: Integer;
      ASessionID: WideString = ''): ITMDBAccountDetail; stdcall;
    function GetDetailsBySession(const ASessionID: WideString): ITMDBAccountDetail; stdcall;
    function SetFavorite(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Favorite: Boolean; const SessionID: WideString = ''): ITMDBAccountAddFavoriteResult; stdcall;
    function SetWatchlist(const AccountID: Integer;
      const MediaType: TTMDBMediaType; const MediaID: Integer;
      const Watchlist: Boolean; const SessionID: WideString = ''): ITMDBAccountAddWatchlistResult; stdcall;
    function GetFavoriteMovies(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetFavoriteTV(const AccountID: Integer; const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBTVSeriesPage; stdcall;
    function GetLists(const AccountID: Integer; const Page: Integer = 1;
      const SessionID: WideString = ''): ITMDBListPage; stdcall;
    function GetRatedMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedMoviePage; stdcall;
    function GetRatedTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVSeriesPage; stdcall;
    function GetRatedTVEpisodes(AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBRatedTVEpisodePage; stdcall;
    function GetWatchlistMovies(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBMoviePage; stdcall;
    function GetWatchlistTV(const AccountID: Integer; const Page: Integer = 1;
      const Language: WideString = ''; const SessionID: WideString = '';
      const SortBy: WideString = ''): ITMDBTVSeriesPage; stdcall;
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

  /// [DONE]
  ITMDBServiceCollections = interface(ITMDBService)
    ['{C0040473-5A07-493B-9771-2EAF58CD5DB0}']
    function GetDetails(const CollectionID: Integer;
      const Language: WideString = ''): ITMDBCollectionDetail; stdcall;
    function GetImages(const CollectionID: Integer;
      const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetTranslations(const CollectionID: Integer): ITMDBTranslationList; stdcall;
  end;

  ITMDBServiceCompanies = interface(ITMDBService)
    ['{13F92C49-85D1-4C7F-BBA6-8B815B23EDDE}']
    function GetDetails(const CompanyID: Integer): ITMDBCompanyDetail; stdcall;
    function GetAlternativeNames(const CompanyID: Integer): ITMDBAlternativeTitleList; stdcall;
    function GetImages(const CompanyID: Integer): ITMDBMediaImages; stdcall;
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
    function GetDetails(const KeywordID: Integer): ITMDBKeywordDetail; stdcall;
    //Movies (DEPRECATED)
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

  /// <summary>
  /// Essentially the same as "Discover Movies", but with preset criteria.
  /// [DONE]
  /// </summary>
  ITMDBServiceMovieLists = interface(ITMDBService)
    ['{FAFB9948-B099-47AD-8C0F-74FE3A1B2E0E}']
    function GetNowPlaying(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBDatedMoviePage;
    function GetPopular(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBMoviePage;
    function GetTopRated(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBMoviePage;
    function GetUpcoming(const Language: WideString = ''; const Page: Integer = 1;
      const Region: String = ''): ITMDBDatedMoviePage;
  end;

  ITMDBServiceMovies = interface(ITMDBService)
    ['{93A8FDCA-9C30-4BC5-BEFC-BB066A5ADE6F}']
    function GetDetails(const MovieID: Integer; const AppendToResponse: TTMDBMovieRequests = [];
      const Language: WideString = ''; const SessionID: String = ''): ITMDBMovieDetail; stdcall;
    function GetAccountStates(const MovieID: Integer; const SessionID: WideString = '';
      const GuestSessionID: WideString = ''): ITMDBAccountStates; stdcall;
    function GetAlternativeTitles(const MovieID: Integer;
      const Country: WideString = ''): ITMDBAlternativeTitleList; stdcall;
    //function GetChanges(): ITMDBChangeList; stdcall;
    function GetCredits(const MovieID: Integer; const Language: String = ''): ITMDBCredits; stdcall;
    //function GetExternalIDs(const MovieID: Integer): ITMDBExternalIDs; stdcall;
    function GetImages(const MovieID: Integer; const IncludeImageLanguage: WideString = '';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetKeywords(const MovieID: Integer): ITMDBKeywordList; stdcall;
    function GetLatest: ITMDBMovieDetail;
    //function GetLists(const MovieID: Integer): ITMDBListPage; stdcall;
    //function GetRecommendations(const MovieID: Integer): ITMDBMovieList; stdcall;
    function GetReleaseDates(const MovieID: Integer): ITMDBReleaseDateCountries; stdcall;
    //function GetReviews(const MovieID: Integer): ITMDBReviewList; stdcall;
    function GetSimilar(const MovieID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function GetTranslations(const MovieID: Integer): ITMDBTranslationList; stdcall;
    function GetVideos(const MovieID: Integer; const Language: WideString = ''): ITMDBVideoList; stdcall;
    //function GetWatchProviders(const MovieID: Integer): ITMDBx; stdcall;
    //function AddRating(const MovieID: Integer; const Rating: Single
    //  const SessionID: WideString = '';
    //  const GuestSessionID: WideString = ''): ITMDBAddRatingResult; stdcall;
    //function DeleteRating(const MovieID: Integer;
    //  const SessionID: WideString = '';
    //  const GuestSessionID: WideString = ''): ITMDBDeleteRatingResult; stdcall;
  end;

  ITMDBServiceNetworks = interface(ITMDBService)
    ['{766C690C-DD9A-4E3B-A611-F93B1CFE1DF6}']
    function GetDetails(const NetworkID: Integer): ITMDBTVNetworkDetail; stdcall;
    function GetAlternativeNames(const NetworkID: Integer): ITMDBAlternativeTitleList; stdcall;
    function GetImages(const NetworkID: Integer): ITMDBMediaImages; stdcall;
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
    //function GetDetail(const ReviewID: WideString): ITMDBReviewDetail; stdcall;
  end;

  ITMDBServiceSearch = interface(ITMDBService)
    ['{D7E9618F-ED5C-4D9A-93FF-CF109294DA0F}']
    function SearchCollections(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const Page: Integer = 1): ITMDBCollectionPage; stdcall;
    function SearchCompanies(const Query: WideString; const Page: Integer = 1): ITMDBCompanyPage; stdcall;
    function SearchKeywords(const Query: WideString;
      const Page: Integer = 1): ITMDBKeywordPage; stdcall;
    function SearchMovies(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Region: WideString = '';
      const PrimaryReleaseYear: WideString = ''; const Year: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    function SearchMulti(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBMediaPage; stdcall;
    function SearchPeople(const Query: WideString; const IncludeAdult: Boolean = False;
      const Language: WideString = ''; const Page: Integer = 1): ITMDBPersonPage; stdcall;
    function SearchTV(const Query: String; const FirstAirDateYear: Integer = 0;
      const IncludeAdult: Boolean = False; const Language: WideString = '';
      const Year: Integer = 0; const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
  end;

  ITMDBServiceTrending = interface(ITMDBService)
    ['{54784907-ACC7-40D1-81D5-109FB413F18A}']
    //function GetAll(): ITMDBMediaPage; stdcall;
    function GetMovies(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBMoviePage; stdcall;
    //function GetPeople(): ITMDBPersonPage; stdcall;
    function GetTV(const TimeWindow: TTMDBTimeWindow; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
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
    function GetDetails(const SeriesID: Integer; const AppendToResponse: TTMDBTVSeriesRequests = [];
      const Language: WideString = ''): ITMDBTVSeriesDetail; stdcall;
    function GetAccountStates(const SeriesID: Integer): ITMDBAccountStates; stdcall;
    //GetAggregateCredits //TODO: Different than normal credits (includes more)...
    function GetAlternativeTitles(const SeriesID: Integer): ITMDBAlternativeTitleList; stdcall;
    //GetChanges
    //function GetContentRatings(const SeriesID: Integer): ITMDBContentRatingList; stdcall;
    function GetGetCredits(const SeriesID: Integer; const Language: WideString = ''): ITMDBCredits; stdcall;
    //GetEpisodeGroups
    //GetExternalIDs
    function GetImages(const SeriesID: Integer; const IncludeImageLanguage: WideString ='';
      const Language: WideString = ''): ITMDBMediaImages; stdcall;
    function GetKeywords(const SeriesID: Integer): ITMDBKeywordList; stdcall;
    //GetLatest
    //GetLists
    //GetRecommendations
    //GetReviews
    //GetScreenedTheatrically
    function GetSimilar(const SeriesID: Integer; const Language: WideString = '';
      const Page: Integer = 1): ITMDBTVSeriesPage; stdcall;
    //GetTranslations
    function GetVideos(const SeriesID: Integer; const IncludeVideoLanguage: WideString = '';
      const Language: WideString = ''): ITMDBVideoList; stdcall;
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

  /// [DONE]
  ITMDBServiceTVEpisodeGroups = interface(ITMDBService)
    ['{B55FFFC4-7C29-4BA1-89C5-0CF1A8D88943}']
    function GetDetails(const TVEpisodeGroupID: String): ITMDBTVEpisodeGroupResponse; stdcall;
  end;

  /// [DONE]
  ITMDBServiceImages = interface(ITMDBService)
    ['{AF0467B9-AF78-4007-A521-EC9F362E7380}']
    function GetBackdrop(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetLogo(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetPoster(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetProfile(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
    function GetStill(var Base64: WideString; const Path: WideString;
      const Size: WideString = 'original'): Boolean; stdcall;
  end;

  /// [DONE]
  //NOTE: Be sure to attribute "JustWatch" if your solution uses watch providers.
  ITMDBServiceWatchProviders = interface(ITMDBService)
    ['{FDB079FA-C25C-4337-BDD7-C4E4A9186A36}']
    function GetAvailableRegions(const Language: WideString = ''): ITMDBCountryList; stdcall;
    function GetMovieProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
    function GetTVProviders(const Language: WideString = '';
      const WatchRegion: WideString = ''): ITMDBWatchProviderList; stdcall;
  end;

{$ENDREGION}



////////////////////////////////////////////////////////////////////////////////



{$REGION 'TMDB Client'}

  { Cached Data }

  ITMDBCache = interface
    ['{7D0D9646-6136-48D8-8FC1-03A6950B670F}']
    function GetConfig: ITMDBConfiguration; stdcall;
    function GetCountries: ITMDBCountryList; stdcall;
    //function GetJobs: ITMDBJobList; stdcall;
    function GetLanguages: ITMDBLanguageList; stdcall;
    function GetPrimaryTranslations: TTMDBStrArray; stdcall;
    function GetTimezones: ITMDBTimezoneList; stdcall;
    function GetMovieCerts: ITMDBCertificationCountries; stdcall;
    function GetTVCerts: ITMDBCertificationCountries; stdcall;
    function GetMovieGenres: ITMDBGenreList; stdcall;
    function GetTVGenres: ITMDBGenreList; stdcall;

    procedure RefreshAll; stdcall;
    function MovieGenre(const ID: Integer): WideString; stdcall;
    function TVGenre(const ID: Integer): WideString; stdcall;

    property Config: ITMDBConfiguration read GetConfig;
    property Countries: ITMDBCountryList read GetCountries;
    //property Jobs: ITMDBJobList read GetJobs;
    property Languages: ITMDBLanguageList read GetLanguages;
    property PrimaryTranslations: TTMDBStrArray read GetPrimaryTranslations;
    property Timezones: ITMDBTimezoneList read GetTimezones;
    property MovieCerts: ITMDBCertificationCountries read GetMovieCerts;
    property TVCerts: ITMDBCertificationCountries read GetTVCerts;
    property MovieGenres: ITMDBGenreList read GetMovieGenres;
    property TVGenres: ITMDBGenreList read GetTVGenres;
  end;



  { User Login State }

  /// <summary>
  /// Encapsulates a TMDB user authentication and account info.
  /// </summary>
  ITMDBLoginState = interface
    ['{FCFBEAC1-3256-4574-9F6F-C5ACF0721BB3}']
    function GetOwner: ITMDBClient;
    function GetAuthMethod: TTMDBUserAuth; stdcall;
    procedure SetAuthMethod(const Value: TTMDBUserAuth); stdcall;
    function GetIsAuthenticated: Boolean; stdcall;
    function GetIsGuest: Boolean; stdcall;
    function GetSessionID: WideString; stdcall;
    function GetAccountID: Integer; stdcall;
    function GetAccountDetail: ITMDBAccountDetail; stdcall;

    function LoginAsGuest: ITMDBAuthGuestSessionResult; stdcall;
    //TODO: Trigger event to open a link in a browser for user authentication
    function LoginAsUser: ITMDBAuthSessionResult; stdcall;
    function LoginAsCreds(const Username, Password: WideString): ITMDBAuthSessionResult; stdcall;
    function Logout: Boolean; stdcall;

    function RestoreSession(const SessionID: WideString): Boolean; stdcall;

    property AuthMethod: TTMDBUserAuth read GetAuthMethod write SetAuthMethod;
    property IsAuthenticated: Boolean read GetIsAuthenticated;
    property IsGuest: Boolean read GetIsGuest;
    property SessionID: WideString read GetSessionID;
    property AccountID: Integer read GetAccountID;
    property AccountDetail: ITMDBAccountDetail read GetAccountDetail;
  end;



  { Core API Client }

  /// <summary>
  /// The core interface-based implementation of the TMDB API wrapper.
  /// </summary>
  ITMDBClient = interface
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
    function GetCache: ITMDBCache; stdcall;
    function GetLoginState: ITMDBLoginState; stdcall;
    function GetOnUserAuthRequest: TTMDBUserAuthRequestEvent; stdcall;
    procedure SetOnUserAuthRequest(const Value: TTMDBUserAuthRequestEvent); stdcall;

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
    function Images: ITMDBServiceImages; stdcall;

    property APIKey: WideString read GetAPIKey write SetAPIKey;
    property AccessToken: WideString read GetAccessToken write SetAccessToken;
    property AuthMethod: TTMDBAuthMethod read GetAuthMethod write SetAuthMethod;
    property UserAuth: TTMDBUserAuth read GetUserAuth write SetUserAuth;
    property Cache: ITMDBCache read GetCache;
    property LoginState: ITMDBLoginState read GetLoginState;

    property OnUserAuthRequest: TTMDBUserAuthRequestEvent
      read GetOnUserAuthRequest write SetOnUserAuthRequest;
  end;

{$ENDREGION}



implementation

end.
