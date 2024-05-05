unit JD.TMDB.Install;

interface

uses
  System.Classes, System.SysUtils,
  JD.TMDB.API;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TMDB', [TTMDBAPI]);
end;

end.
