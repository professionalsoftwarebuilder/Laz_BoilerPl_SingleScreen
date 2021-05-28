unit frm_database;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, VD_FormPosSize;

type

  { TfrmDataBase }

  TfrmDataBase = class(TForm)
    btnBackupDb: TButton;
    btnLtstBuTerugZtn: TButton;
    btnOpenDbLoc: TButton;
    btnSelDb: TButton;
    btnSelDbBackupRepo: TButton;
    Button1: TButton;
    btnIntegrityCheck: TButton;
    edtDataBaseBackupDir: TEdit;
    edtDataBaseLokatie: TEdit;
    lblBackupRepo: TLabel;
    lblDataBaseLocatie: TLabel;
    lblLaatsteBackup: TLabel;
    lblLtstBckupPath: TLabel;
    pgCtrlDataBases: TPageControl;
    tbshtOpschonen: TTabSheet;
    tbshtBackUp: TTabSheet;
    theStatusBar: TStatusBar;
    theSelDirDialog: TSelectDirectoryDialog;
    theOpenDlg: TOpenDialog;
    VDFormPosSize1: TVDFormPosSize;
    procedure btnBackupDbClick(Sender: TObject);
    procedure btnIntegrityCheckClick(Sender: TObject);
    procedure btnLtstBuTerugZtnClick(Sender: TObject);
    procedure btnOpenDbLocClick(Sender: TObject);
    procedure btnSelDbBackupRepoClick(Sender: TObject);
    procedure btnSelDbClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    class procedure ShowForm;
  end;

var
  frmDataBase: TfrmDataBase;

implementation

{$R *.lfm}

uses
  VD_Conversie,
  globals;

procedure TfrmDataBase.btnSelDbClick(Sender: TObject);
var
  filename: string;
  lInd_EdtState: boolean;
begin
  lInd_EdtState := False;

  if theOpenDlg.Execute then
  begin
    filename := theOpenDlg.Filename;
    qIniPropStorage.WriteIniString(cns_Ini_DataBasePath, filename);
    edtDataBaseLokatie.Text := filename;
    ShowMessage(cns_Msg_DbOpnLaden);
  end;
end;

procedure TfrmDataBase.Button1Click(Sender: TObject);
var
  lFileNm: string;
begin
  lFileNm := qIniPropStorage.ReadIniString(cns_Ini_LastDBBackup, 'Moet nog');
  if FileExists(lFileNm) then
    theSelDirDialog.FileName := lFileNm;
  theSelDirDialog.Execute;
end;

procedure TfrmDataBase.btnSelDbBackupRepoClick(Sender: TObject);
var
  lDirName: string;
begin
  if theSelDirDialog.Execute then
  begin
    lDirName := theSelDirDialog.FileName;

    qIniPropStorage.WriteIniString(cns_Ini_DBBackupDir, lDirName);
    edtDataBaseBackupDir.Text := lDirName;
  end;
end;

procedure TfrmDataBase.btnBackupDbClick(Sender: TObject);
var
  lFileNm: string;
  lFileExt: string;
  lBckupPath: string;
  lBckupPathUpd: string;
  lVerExt: string;
  lCount: integer;
begin
  lCount := 1;
  lFileNm := ExtractFileName(qPathToDataBaseFile);
  //lFileExt:= ExtractFileExt(lFileNm);
  lBckupPath := qIniPropStorage.ReadIniString(cns_Ini_DBBackupDir);
  lBckupPath := pathCombine(lBckupPath, lFileNm);
  lVerExt := cns_VersionExt + '1';
  lBckupPathUpd := InsertSufixInFilePath(lBckupPath, lVerExt);

  while FileExists(lBckupPathUpd) do
  begin
    lCount += 1;
    lVerExt := cns_VersionExt + IntToStr(lCount);
    lBckupPathUpd := InsertSufixInFilePath(lBckupPath, lVerExt);
  end;

  if CopyFile(qPathToDataBaseFile, lBckupPathUpd) then
  begin
    theStatusBar.SimpleText := 'DataBase met succes gebackuped';
    qIniPropStorage.WriteIniString(cns_Ini_LastDBBackup, lBckupPathUpd);
    lblLtstBckupPath.Caption := lBckupPathUpd;
  end
  else
    theStatusBar.SimpleText := 'Het backupen van de DataBase is mislukt';
end;

procedure TfrmDataBase.btnIntegrityCheckClick(Sender: TObject);
const
  cSqlMaxId = 'Select Max(_id) as GetIntValue from %s ';
  cSqlUpdCdVal = 'Update SleutelWaarden Set LtsteWrde = %s Where (NmTabel = %s)';
var
  lStrLst: TStringList;
  i: integer;
  lSql: string;
  lMaxKey: integer;
begin
  {
  lStrLst := TStringList.Create;
  lStrLst.Add(cns_tbl_DVDs_nm);
  lStrLst.Add(cns_tbl_Addresses_nm);
  lStrLst.Add(cns_tbl_ContactNumbers_Nm);
  lStrLst.Add(cns_tbl_Correspondence_Nm);
  lStrLst.Add(cns_tbl_Genres_nm);
  lStrLst.Add(cns_tbl_Groups_nm);
  lStrLst.Add(cns_tbl_LookUpItems_nm);
  lStrLst.Add(cns_tbl_LookUps_nm);
  lStrLst.Add(cns_tbl_Ratings_nm);
  lStrLst.Add(cns_tbl_Subjects_nm);

  with MainDataMod do
  begin
    for i := 0 to lStrLst.Count - 1 do
    begin
      lSql := format(cSqlMaxId, [lStrLst[i]]);
      lMaxKey := GetDbIntegerValue(lSql);
      lMaxKey := goToFirstTenfold(lMaxKey);
      lSql := format(cSqlUpdCdVal, [IntToStr(lMaxKey), lStrLst[i]]);
      ExecuteCmnds(lSql);

    end;

  end;

  lStrLst.FreeInstance;
  }
end;

// Let op: niet getest.
procedure TfrmDataBase.btnLtstBuTerugZtnClick(Sender: TObject);
var
  lNwNm: string;
  lVerExt: string;
  lCount: integer;
  lBckUp: string;
begin
  // Database renamen
  lCount := 1;
  lNwNm := InsertSufixInFilePath(qPathToDataBaseFile, cns_Old);

  while FileExists(lNwNm) do
  begin
    lCount += 1;
    lVerExt := cns_Old + IntToStr(lCount);
    lNwNm := InsertSufixInFilePath(qPathToDataBaseFile, lVerExt);
  end;

  // Dan Backup terugzetten
  lBckUp := qIniPropStorage.ReadIniString(cns_Ini_LastDBBackup, 'Moet nog');
  if FileExists(lBckUp) then
  begin
    if RenameFile(qPathToDataBaseFile, lNwNm) then
    begin
      if CopyFile(lBckUp, qPathToDataBaseFile) then
      begin
        theStatusBar.SimpleText := 'Backup DataBase met succes teruggezet';
      end
      else
        theStatusBar.SimpleText := 'Backup DataBase Mislukt';
    end
    else
      theStatusBar.SimpleText := 'DataBase niet teruggezet, kon niet hernoemen';
  end
  else
    theStatusBar.SimpleText := 'Laatste backup bestaat niet meer';
end;

procedure TfrmDataBase.btnOpenDbLocClick(Sender: TObject);
var
  lFileNm: string;
begin
  lFileNm := qPathToDataBaseFile;
  if FileExists(lFileNm) then
    theSelDirDialog.FileName := lFileNm;
  theSelDirDialog.Execute;
end;

procedure TfrmDataBase.FormShow(Sender: TObject);
begin
  pgCtrlDataBases.ActivePageIndex := 0;
  edtDataBaseLokatie.Text := qPathToDataBaseFile;
  edtDataBaseBackupDir.Text := qIniPropStorage.ReadIniString(cns_Ini_DBBackupDir);
  lblLtstBckupPath.Caption := qIniPropStorage.ReadIniString(
    cns_Ini_LastDBBackup, 'Moet nog');
end;



class procedure TfrmDataBase.ShowForm;
begin
  if not Assigned(frmDataBase) then
    frmDataBase := TfrmDataBase.Create(Application);
  frmDataBase.Show;
end;

end.
