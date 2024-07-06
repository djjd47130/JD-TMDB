# JD-TMDB

TMDB API Wrapper for Delphi - Written by Jerry Dodge 

## IMPORTANT NOTE

This library is currently in active develoment, and not guaranteed for use at this time. 

## Delphi Version

This library is written in Delphi 10.4. While it should work fine on other version of Delphi, there are no guarantees. The older the Delphi version, the less likely this library will be compatible.

## TMDB API Documentation

https://developer.themoviedb.org/reference/intro/getting-started

## TMDB API Key

You are required to obtain your own [API key from TMDB](https://www.themoviedb.org/settings/api). 

## TMDB User Login

While the TMDB API supports several authentication methods for users to login and access their favorites, ratings, etc, the current state of this library does not yet support user authentication. Currently, everything is supported anonymously, until the user login methods have been solidified.

## Delphi Wrapper

The goal of this library is to have 3 layers of wrappers - Raw JSON API (in `JD.TMDB.API.pas`), Interface Translation (in `JD.TMDB.Intf.pas` and `JD.TMDB.Impl.pas`), and Delphi Component (in `JD.TMDB.pas`).

At the heart of this project is the unit `JD.TMDB.API.pas` which wraps the entire TMDB API. This is encapsulated in the `TTMDBAPI` component. This provides raw access to all possible services / requests, and returns raw JSON data via `ISuperObject` or `ISuperArray`, parts of the [`X-SuperObject` JSON library for Delphi](https://github.com/onryldz/x-superobject). 

A second-level wrapper is being written which further adds an abstract layer around the API. All possible services and objects are implemented via interfaces in `JD.TMDB.Intf.pas`, and implemented in `JD.TMDB.Impl.pas`. The base interface is `ITMDBClient`.

A final third-level wrapper is a component you can install into the Delphi IDE. It is reponsible for everything necessary, including pre-fetching configuration data, API authentication, user authentication, language and locale options, etc.  This will ultimately be the main component to integrate your Delphi project with the TMDB API. 

## Test Application

There is a test application to demonstrate the usage of the TMDB API wrapper. Note that this app is in very active development at this time, and is far from ready. 

### JDLib

The test applications uses controls from [JDLib, a separate repository of mine](https://github.com/djjd47130/JDLib).

## Watch Providers Attribution

**IMPORTANT**: In order to use any of the "Watch Providers" features, you must attribute ["**JustWatch**"](https://www.justwatch.com/) in your solution.

## Usage

1. Obtain an [API key of your own](https://www.themoviedb.org/settings/api)
2. Create an instance of the `TTMDB` component. This may be installed in your component palette.
3. Assign your key(s) via the component's `APIKey` and/or `AccessToken` properties.
   - NOTE: Another property `AuthMethod` controls which key gets used.
4. You're ready to use a majority of the API functions now.
   - Access each possible namespace with its corresponding function, such as `Search`, `Movies`, `Account`, etc.
6. You may additionally login using `LoginState` in runtime to access account-related functionality.

