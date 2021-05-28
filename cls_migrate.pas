unit cls_migrate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  cns_Migr_010 = 0;

  cns_Sql_AddTableMetaStrings =
   'create table if not exists TimeMetaStrings (' +
	'_id	INTEGER, ' +
	'pkey	TEXT, ' +
	'tms_Ctrl TEXT, ' +
        'tms_Title TEXT, ' +
	'tms_MetaDat	TEXT, ' +
	'tms_Date	TEXT, ' +
	'tms_VolgNr	INTEGER, ' +
	'PRIMARY KEY(_id )' +
        ')';


type

  { TAppMigrate }

  TAppMigrate = class
  public
    class procedure SelectMigration;
    class function DoMigr_010: Boolean;
  end;

implementation

uses

  globals;

{ TAppMigrate }

class procedure TAppMigrate.SelectMigration;
var
  lVerInt: integer;
begin
  /// Haal huidige versie op
  lVerInt := StrToInt(StringReplace(cns_Apl_Version, '.', EmptyStr, [rfReplaceAll]));

  /// Update event inifile (is dat wel nodig?)
  if qCurrAppMigration = 0 then
  begin
    qCurrAppMigration := lVerInt;
    qIniPropStorage.WriteIniInteger(cns_Ini_CurrAppMigration, qCurrAppMigration);
  end;

  /// Migratiegetal normaal 1 hoger dan Versiegetal
  /// Migratiegetal is alleen maar vlag als een soort boolean, zodat
  /// wanneer ik het versie ophoog deze exit gepasseerd wordt
  if qCurrAppMigration > lVerInt then
    Exit;

  if qCurrAppMigration <= cns_Migr_010 then
    DoMigr_010;
end;

class function TAppMigrate.DoMigr_010:Boolean;
begin
  Result := MainDataMod.ExecuteCmnds(cns_Sql_AddTableMetaStrings);
  /// Migratie getal 1 ophogen
  qIniPropStorage.WriteIniInteger(cns_Ini_CurrAppMigration, qCurrAppMigration + 1);
end;

end.

