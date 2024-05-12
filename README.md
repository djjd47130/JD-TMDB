# JD-TMDB

TMDB API Wrapper for Delphi - Written by Jerry Dodge 

## IMPORTANT NOTE

This library is currently in active develoment, and not guaranteed for use at this time. 

## TMDB API Documentation

https://developer.themoviedb.org/reference/intro/getting-started

## TMDB API Key

You are required to obtain your own [API key from TMDB](https://www.themoviedb.org/settings/api). 

## TMDB User Login

While the TMDB API supports several authentication methods for users to login and access their favorites, ratings, etc, the current state of this library does not yet support user authentication. Currently, everything is supported anonymously, until the user login methods have been solidified.

## Delphi Wrapper

The goal of this library is to have 3 layers of wrappers - Raw JSON API (`JD.TMDB.API.pas`), Interface Translation (`JD.TMDB.Intf.pas`), and Delphi Component (Future Plan).

At the heart of this project is the unit `JD.TMDB.API.pas` which wraps the entire TMDB API. This is encapsulated in the `TTMDBAPI` component, which can be installed into your IDE. This provides raw access to all possible services / requests, and returns raw JSON data via `ISuperObject` or `ISuperArray`, parts of the `X-SuperObject` JSON library for Delphi. 

A second-level wrapper is being written which further adds an abstract layer around the API. All possible services and objects are implemented via interfaces in `JD.TMDB.Intf.pas`, and implemented in `JD.TMDB.Impl.pas`. 

A final third-level wrapper is planned which will be a component you can install into the Delphi IDE. It will be reponsible for everything necessary, including pre-fetching configuration data, API authentication, user authentication, language and locale options, etc.  This will ultimately be the main component to integrate your Delphi project with the TMDB API. 

## Test Application

There is a test application to demonstrage the usage of the TMDB API. Note that this app is in very active development at this time, and is far from ready. 

## Watch Providers Attribution

**IMPORTANT**: In order to use any of the "Watch Providers" features, you must attribute "**JustWatch**" in your solution.

