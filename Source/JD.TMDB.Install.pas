unit JD.TMDB.Install;

interface

uses
  System.Classes, System.SysUtils,
  JD.TMDB;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TMDB', [TTMDB]);
end;

end.
