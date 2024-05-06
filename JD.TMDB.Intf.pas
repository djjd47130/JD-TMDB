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
  System.Classes, System.SysUtils;

type

  ITMDBPageItem = INTERFACE;

  ITMDBPage = interface
    ['{F95555BF-1E0C-4E95-AE81-93A09EFA4EA3}']
    function GetPage: Integer; stdcall;
    function GetCount: Integer; stdcall;
    function GetTotalPages: Integer; stdcall;
    function GetTotalResults: Integer; stdcall;
    function GetItem(const Index: Integer): ITMDBPageItem;
    property Page: Integer read GetPage;
  end;

  ITMDBPageItem = interface
    ['{9909E734-78DB-4CBB-B84D-A8E16315DA4E}']
    function GetOwner: ITMDBPage; stdcall;
    function GetIndex: Integer; stdcall;

  end;

  ITMDBAccountDetails = interface
    ['{DE0E4519-BED8-4218-BE84-A4C0AC5C6DBD}']
    function GetID: Integer; stdcall;
    function GetUserName: WideString; stdcall;
    function GetName: WideString; stdcall;
    function GetIncludeAdult: Boolean; stdcall;
    function GetCountryCode: WideString; stdcall;
    function GetLanguageCode: WideString; stdcall;
    function GetGravatarHash: WideString; stdcall;
    function GetTMDBAvatarPath: WideString; stdcall;
  end;

  TTMDBMediaType = (mtMovie, mtTV, mtPerson);

  ITMDBAccountFavoriteReq = interface
    ['{2D83FD85-53BE-4ADF-BE46-19516A64AB36}']
    function GetMediaType: TTMDBMediaType; stdcall;
    procedure SetMediaType(const Value: TTMDBMediaType); stdcall;
    function GetMediaID: Integer; stdcall;
    procedure SetMediaID(const Value: Integer); stdcall;
    function GetFavorite: Boolean; stdcall;
    procedure SetFavorite(const Value: Boolean); stdcall;

    property MediaType: TTMDBMediaType read GetMediaType write SetMediaType;
    property MediaID: Integer read GetMediaID write SetMediaID;
    property Favorite: Boolean read GetFavorite write SetFavorite;
  end;

  ITMDBAccountWatchlistReq = interface
    ['{A2EE35A2-AF92-46AA-A366-78A84E03B250}']
    function GetMediaType: TTMDBMediaType; stdcall;
    procedure SetMediaType(const Value: TTMDBMediaType); stdcall;
    function GetMediaID: Integer; stdcall;
    procedure SetMediaID(const Value: Integer); stdcall;
    function GetWatchlist: Boolean; stdcall;
    procedure SetWatchlist(const Value: Boolean); stdcall;

    property MediaType: TTMDBMediaType read GetMediaType write SetMediaType;
    property MediaID: Integer read GetMediaID write SetMediaID;
    property Watchlist: Boolean read GetWatchlist write SetWatchlist;
  end;

  ITMDBMovies = interface(ITMDBPage)
    ['{93A8FDCA-9C30-4BC5-BEFC-BB066A5ADE6F}']

  end;

  ITMDBMovie = interface(ITMDBPageItem)
    ['{FDF02CEF-6961-4D1E-82AA-BE0F34BE308C}']

  end;




type



  ITMDBService = interface
    ['{0E665C12-812B-4B2D-8A48-17A16740290C}']

  end;

  ITMDBAccount = interface(ITMDBService)
    ['{E690DF1A-6680-4040-BBC6-ABE0D4CC6916}']
    function GetDetails: ITMDBAccountDetails; stdcall;
    function SetFavorite(Favorite: ITMDBAccountFavoriteReq): Integer; stdcall;
    function SetWatchlist(Watchlist: ITMDBAccountWatchlistReq): Integer; stdcall;
    function GetFavoriteMovies(const Page: Integer = 1; const Language: WideString = '';
      const SessionID: WideString = ''; const SortBy: WideString = ''): ITMDBMovies; stdcall;

  end;

  ITMDBAuthentication = interface(ITMDBService)
    ['{2144056B-54A4-49C4-AE3E-E0701B10E218}']

  end;


implementation

end.
