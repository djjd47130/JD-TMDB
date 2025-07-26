# JD-TMDB

TMDB (The Movie DataBase) API Wrapper for Delphi - Written by Jerry Dodge 

## IMPORTANT NOTE

This library is currently in active develoment, and not guaranteed for use at this time. 

## Delphi Version

This library is written in Delphi 10.4. While it should work fine on other version of Delphi, there are no guarantees. The older the Delphi version, the less likely this library will be compatible.

## TMDB API Documentation

https://developer.themoviedb.org/reference/intro/getting-started

## TMDB API Key

You are required to obtain your own [API key and/or access token from TMDB](https://www.themoviedb.org/settings/api). 

## TMDB User Login

You are able to login to a TMDB user account in the API through a variety of authentication methods:

- Embedded Browser - Opens the TMDB auth page dynamically and feeds a callback URL
- Credentials - Provide username and password directly
- Guest- Login as a guest with a guest sesion ID

## Delphi Wrapper(s)

The goal of this library is to have 3 layers of wrappers - Raw JSON API (in `JD.TMDB.API.pas`), Interface/Implementation Translation (in `JD.TMDB.Intf.pas` and `JD.TMDB.Impl.pas`), and Delphi Component (in `JD.TMDB.pas`).

At the heart of this project is the unit `JD.TMDB.API.pas` which wraps the entire TMDB API. This is encapsulated in the `TTMDBAPI` component. This provides raw access to all possible services / requests, and returns raw JSON data via `ISuperObject` or `ISuperArray`, parts of the [`X-SuperObject` JSON library for Delphi](https://github.com/onryldz/x-superobject). 

A second-level wrapper is being written which further adds an interface-oriented layer around the API. All possible endpoints and objects are implemented via interfaces in `JD.TMDB.Intf.pas`, and further implemented in `JD.TMDB.Impl.pas`. The base API interface is `ITMDBClient`, implemented via `TTMDBClient`.

A final third-level wrapper is the `TTMDB` component you can install into the Delphi IDE, in the `JD.TMDB.pas` unit. It is reponsible for everything necessary, including pre-fetching configuration data, API authentication, user authentication, language and locale options, etc.  This is ultimately the main component to integrate your Delphi project with the TMDB API. 

## Test Application

There is a test application to demonstrate the usage of the TMDB API wrapper. Note that this app is in very active development at this time, and is far from ready. However, it does feature a few major features, such as:

- User Authentication
- Search (All media types)
- Movie Detail
- Genres (Movie and TV)
- Certifications (Movie and TV)
- Embedded Edge Browser

![image](https://github.com/user-attachments/assets/22f6ced9-2386-4646-a316-50fde7eff333)

### JDLib

The test applications uses controls from [JDLib, a separate repository of mine](https://github.com/djjd47130/JDLib).

### TChromeTabs

The test application uses the [`TChromeTabs` control](https://github.com/norgepaul/TChromeTabs).

## Watch Providers Attribution

**IMPORTANT**: In order to use any of the "Watch Providers" features, you must attribute ["**JustWatch**"](https://www.justwatch.com/) in your solution. The `TTMDB` component includes a property which you must explicitly mark `True` in order to use such features without a forced exception upon usage. 

## Usage

1. Obtain an [API key of your own](https://www.themoviedb.org/settings/api)
2. Create an instance of the `TTMDB` component. This may be installed in your component palette.
3. Assign your key(s) via the component's `APIKey` and/or `AccessToken` properties.
   - NOTE: Another property `AuthMethod` controls which key gets used.
4. You're ready to use a majority of the API functions now via the `Client` property.
   - Access each possible namespace with its corresponding function, such as `Search`, `Movies`, `Account`, etc.
6. You may additionally login using `LoginState` in runtime to access account-related functionality.

```
var
  TMDB: TTMDB;
begin
  TMDB:= TTMDB.Create(nil);

  //EITHER...
  TMDB.APIKey:= YOUR_TMDB_API_KEY;
  TMDB.AuthMethod:= amAPIKey;
  //...OR...
  TMDB.AccessToken:= YOUR_TMDB_ACCESS_TOKEN;
  TMDB.AuthMethod:= amAccessToken;

  //Now you can access most of the library / API...

  var Results: ITMDBMoviePage;
  Result:= TMDB.Client.Search.Movies('Star Wars', 'en-US');

  var Movie: ITMDBMovieDetail;
  Movie:= TMDB.Client.Movies.GetDetail(11, 'en-US');

  var Credits: ITMDBCredits;
  Credits:= TMDB.Client.Movies.GetCredits(11);

end;
```


