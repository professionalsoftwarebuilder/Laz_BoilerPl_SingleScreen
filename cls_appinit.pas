unit cls_appinit;

{$mode objfpc}{$H+}

interface

uses
  Forms,
  Controls,
  fileutil,
  Classes,
  frm_items,
  SysUtils;

type

  { TAppInit }

  TAppInit = class
	private
  public
    class function InitializeApp: Boolean;
		class function InitializeMainForm(theMainFrm: TfrmItems): Boolean;
  end;

implementation

{ TAppInit }

uses
  globals,
  frm_database,
  VD_Conversie,
  ps_inifile,
  VD_Global,
  cls_migrate,
  datamodule,
  Dialogs;

class function TAppInit.InitializeApp: Boolean;

  /// Nested function
  function CreateTheDir(aPath: String; aName: String): Boolean;
  begin
    Result := False;
    If Not DirectoryExists(aPath) then
      If Not CreateDir(aPath) Then
        ShowMessage('Failed to create ' + aName + ' directory !' + sLineBreak +
          'Please check permissions')
      else
      begin
        ShowMessage('Created new ' + aName + ' directory');
        Result := True
      end;
  end;

begin

  /// Application Initialisation
  ///---
  FmtSettings.DateSeparator := '-';
  FmtSettings.ShortDateFormat := 'dd mm yyyy';
  FmtSettings.TimeSeparator := ':';
  FmtSettings.LongTimeFormat := 'hh:nn';

  // De appDataPath is pad naar algemen app data zoals ini files.
  // appDataPath moet altijd hetzelfde zijn en niet opgenomen zijn in inifile daar
  // zij de lokatie is van de inifile
  // Path to database is wat het zegt en kan wel veranderlijk zijn en in inifile
  // opgenomen zijn.
  // De iniclass plakt automatisch Filename "IniSettings" achter dirPad.
  qPathToExeDir := ExtractFilePath(Application.ExeName);

  {$IFDEF WINDOWS}
  qPathToAppDataDir := pathCombine(pathCombine(GetEnvironmentVariable('localappdata'), cns_WinDataLocation), cns_Apl_SoftwareNm);
  CreateTheDir(qPathToAppDataDir, 'Appdata');

  If DirectoryExists(qPathToAppDataDir) then
  begin
    // Niet onder DirectoryExists, kan alsnog niet aanwezig zijn (oude versie bijv)
    qPathToIniDir:= pathCombine(qPathToAppDataDir , cns_DataDirIni);
    CreateTheDir(qPathToIniDir, 'Inifile');

  end;

  {$ENDIF}
  {$IFDEF LINUX}
  qPathToAppDataDir := pathCombine(ExtractFilePath(Application.ExeName ), cns_LinDataLocation);
  If Not DirectoryExists(qPathToAppDataDir) then
    CreateTheDir(qPathToAppDataDir, 'Appdata');

  If DirectoryExists(qPathToAppDataDir) then
  begin
    // Niet onder DirectoryExists, kan alsnog niet aanwezig zijn (oude versie bijv)
    qPathToIniDir:= pathCombine(qPathToAppDataDir , cns_DataDirIni);
    CreateTheDir(qPathToIniDir, 'Inifile');
  end;
  {$ENDIF}

  // Om ook componenten de locatie van inifiles mee te geven.
  gPathToIniDir := qPathToIniDir;

  qIniPropStorage := TPsIniClass.Create(qPathToIniDir);

  // Kijk in ini of er alternatieve databasepad is
  qPathToDataBaseFile := qIniPropStorage.ReadIniString(cns_Ini_DataBasePath, EmptyStr);
  if qPathToDataBaseFile = EmptyStr then
  begin
    {$IFDEF LINUX}
    if qUseStndDataBase then
    begin
      qPathToDataBaseFile := pathCombine(cns_LinDefDataLocation, cns_DataBaseNm);
      qPathToDataBaseDir := cns_LinDefDataLocation;
      qIniPropStorage.WriteIniString(cns_Ini_DataBasePath, qPathToDataBaseFile);
    end
    else
    begin
    {$ENDIF}
    qPathToDataBaseDir := pathCombine(qPathToAppDataDir, cns_DataDirDatabase);
    {$IFDEF LINUX}
    end;
    {$ENDIF}

    CreateTheDir(qPathToDataBaseDir, 'DataBase');

    If DirectoryExists(qPathToDataBaseDir) then
    begin
      qPathToDataBaseFile := pathCombine( qPathToDataBaseDir, cns_DataBaseNm);
    end;
  end
  else
  begin
    /// Is nog niet geinitieerd als qPathToDataBaseFile als bestond
    qPathToDataBaseDir := ExtractFileDir(qPathToDataBaseFile);
  end;

  /// (Moet hier geplaatst worden als niet bestaat)
  qPathToRepoDir := qIniPropStorage.ReadIniString(cns_Ini_PathToRepoDir, EmptyStr);
  /// Wanneer Repo niet bestaat, onder database dir plaatsen
  if qPathToRepoDir = emptyStr then
  begin
     qPathToRepoDir := pathCombine( qPathToDataBaseDir, cns_DataDirRepo);
     /// Gelijk wegschrijven anders komt hij hier opnieuw (zie check hierboven)
     qIniPropStorage.WriteIniString(cns_Ini_PathToRepoDir, qPathToRepoDir);
     CreateTheDir(qPathToRepoDir, 'Repo Dir');
  end
  else
  begin
    If not DirectoryExists(qPathToRepoDir) then
    begin
      ShowMessage('The directory to the file-Repo, that is set in the program, does not exist' + #13 +
        'The repo directory is currently set to:' + #13 + qPathToRepoDir + #13 +
        'Please reset the repo file directory in the settings form (inifile settings)');
      /// We kunnen hier nog de settings file openen.
      /// We kunnen ook een dialog openen die ini waarde wist zodat bij volgende opstart de defaults voor de repo aangemaakt worden
    end;

  end;


  /// Let op:
  /// Tot hier zijn paden aangemaakt maar geen files gechecked of gecopieerd.
  /// Ook zijn tot hier alle pad strings juist gezet
  if not FileExists(qPathToDataBaseFile) then
  if MessageDlg('Question', 'There does not seem to be a database file,' + sLineBreak +
  ' do you want to copy a empty database?' + sLineBreak +
  ' Be sure not to overwrite an existing database'  + sLineBreak +
  'When Choosing No please use SETTINS=>DATABASE'  + sLineBreak +
  ' to choose a valid database file' , mtConfirmation,
    [mbYes, mbNo],0) = mrYes then
  begin
    if CopyFile( pathCombine(pathCombine(ExtractFilePath(Application.ExeName ),
      cns_DataDirDatabase), cns_DataBaseNm), qPathToDataBaseFile) then
      ShowMessage('Copying of the databasefile was succesfull')
    else
    begin
      ShowMessage('Copying of the databasefile was unsuccesfull');
      qInd_ProblDataBase := true;
    end;
  end
  else
    qInd_ProblDataBase := true;
  ///---
  Result := true;

  /// Haal migratiegetal op
  /// Is 0 als nog leeg
  qCurrAppMigration := qIniPropStorage.ReadIniInteger(cns_Ini_CurrAppMigration);

  /// Afhandeling userdatabase
  if cns_PrgmPar_UserDb then
  begin
    qPathToUserDataBaseFile := qIniPropStorage.ReadIniString(cns_Ini_UserDataBasePath, EmptyStr);
    if qPathToUserDataBaseFile = EmptyStr then
    begin
      ShowMessage('No user databasefile defined' + #13 + 'Please define a user database after te program has started');
    end;
  end;
end;

/// Wordt aangeroepen in de Create van de Main Form
class function TAppInit.InitializeMainForm(theMainFrm: TfrmItems): Boolean;
begin
  Result := True;

  theMainFrm.Caption := cns_Apl_MainFrmCaption + 'Vrs: ' + cns_Apl_Version + ' - ' + cns_OS;

  /// Probeer de MainDataModule te laden
  try
  // Let op: moet gebeuren na qPathToDb ingevuld is.
  if not qInd_ProblDataBase then
  begin
    MainDataMod := TDatModMain.Create(nil) ;
    /// Check of er nog migraties zijn
    TAppMigrate.SelectMigration;
    /// Open de Queries
    MainDataMod.InitTables;
  end
  else
  begin
    ShowMessage('Go to the database form in settings to set the right database path');
    TfrmDataBase.ShowForm;
    theMainFrm.statbrMain.SimpleText := 'Warning: Application is not connected to a database';
  end;
  Except
    ShowMessage('Something went Wrong opening the database');
    theMainFrm.statbrMain.SimpleText := 'Warning: Application is not connected to a database';
    qInd_ProblDataBase := true;
  end;

end;

end.

