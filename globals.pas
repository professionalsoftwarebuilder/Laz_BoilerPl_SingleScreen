unit globals;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  ps_inifile,
  forms,
  DataModule;

const
  ///-i- Applicatie Eigen
  cns_Apl_Version = '1.1.0';
  cns_Apl_MainFrmCaption = 'Standaard applicatie Mainform ';
  cns_Apl_Nm = 'Standard App';
  cns_Apl_SoftwareNm = 'StandardApp';

  /// File constants
  cns_DataBaseNm = 'dbStandaard.db';
  cns_LinDefDataLocation = '/home/corbij/Portable/Documenten/DataBases/Sqlite/StandaardDb/';

  /// Table names
  cns_tbl_Documents_nm = 'Documents';
  cns_tbl_LookUps_nm = 'LookUps';
  cns_tbl_LookUpItems_nm = 'LookUpItems';
  cns_tbl_Subjects_nm = 'Subjects';
  cns_tbl_Items_nm = 'Items';
  cns_tbl_Versions_nm = 'Versions';
  ///-o- Applicatie Eigen

  {$IFDEF WINDOWS       }
  {$IFDEF WIN32       }
    cns_OS = 'Win32';
  {$ENDIF}
  {$IFDEF WIN64       }
    cns_OS = 'Win64';
  {$ENDIF}
  {$ENDIF}

  {$IFDEF WINDOWS       }
  {$IFDEF WIN32       }
    cns_PathToSqliteDll = 'SqliteDll-32\sqlite3.dll';
  {$ENDIF}
  {$IFDEF WIN64       }
    cns_PathToSqliteDll = 'SqliteDll-64\sqlite3.dll';
  {$ENDIF}
  {$ENDIF}
  {$IFDEF LINUX}
  {$IFDEF cpui386}
    cns_OS = 'Lin32';
  {$else}
    cns_OS = 'Lin64';
  {$ENDIF}
  {$ENDIF}

  /// Report names

  /// File constants
  cns_DataDirIni      = 'IniFiles';
  cns_DataDirDatabase = 'DataBases';
  cns_DataDirRepo = 'RepoDir_UserFiles';
  cns_LinDataLocation = 'Data';
  cns_WinDataLocation = 'ProfessionalSoftware';

  /// Messages
  cns_Msg_PendingUpdates = 'Er zijn wijzigingen die nog niet zijn doorgevoerd';
  cns_Msg_WiltUOpslaan = 'Wilt u de wijzigingen opslaan voor het sluiten vd pagina?';
  cns_Msg_AlleenArtForm = 'U kunt de prijs alleen wijzigen in het artikel formulier';
  cns_Msg_RefresIsHerbereken = 'Save + Refresh = Herbereken';
  cns_Msg_DbOpnLaden = 'Herstart het programma om de database opnieuw in te laden';
  cns_Msg_LtstBckUpDb = 'Laatste Backup database: ';
  cns_Msg_EnterFilterStr = 'Please enter a filter string';
  cns_Msg_PartualKeySearch = '(Partual key search)';
  cns_Msg_ProblClosingProgram = 'Something went wrong closing the program';
  cns_Msg_UpdateFailed = 'Failde to update the table';

  /// Captions
  cns_Txt_LijstTotaal = 'Lijst totaal: ';
  cns_Txt_ToonAllen = 'Toon allen';
  cns_Txt_Categorien = 'Categorien';
  cns_Txt_SelectionForm = ' #selection form#';

  /// Ini keys
  cns_Ini_PathToRepoDir = 'PathToRepoDir';
  cns_Ini_DataBasePath = 'DataBasePath';
  cns_Ini_UserDataBasePath = 'UserDataBasePath';
  cns_Ini_DBBackupDir = 'DBBackupDir';
  cns_Ini_LastDBBackup = 'LastDBBackup';
  cns_Ini_PathToAppData = 'PathToAppData';
  cns_Ini_CurrAppMigration = 'CurrAppMigration';

  /// Other constants
  cn_FldStatus_InRepo = 'InRepo';
  cn_FldStatus_OutsideRepo = 'OutsideRepo';


  /// Program parameters
  cns_PrgmPar_UserDb = false;

  /// File extentions
  cns_VersionExt = '-Ver-';
  cns_Old = '-Old-';

  type
    TFormArray = Array of TForm;

var
 TheInputString: String = '';

 MainDataMod: TDatModMain;

 FmtSettings: TFormatSettings;

 qIniPropStorage: TPsIniClass;
 qUseStndDataBase: Boolean = true;

 qCurrAppMigration: Integer;

 // Pad naar inifile, onveranderlijk
 qPathToRepoDir: String;
 qPathToIniDir: String;
 qPathToIniFile: String;
 qPathToAppDataDir: String;
 // Pad naar database veranderlijk (kan door gebr aangepast worden)
 qPathToDataBaseDir: String;
 qPathToDataBaseFile: String;
 qPathToUserDataBaseFile: String;
 qDirDbBackup: String;
 qPathToExeDir: String;

 // Indicators
 qInd_ProblDataBase: Boolean = false;

implementation

end.
