unit datamodule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, DB, BufDataset, FileUtil,
  Forms,
  Dialogs, Controls;

type

  { TDatModMain }

  TDatModMain = class(TDataModule)
    dsItems: TDataSource;
    dsTTLanguage: TDataSource;
    dsLanguage: TDataSource;
    dsLst_ItemTypes: TDataSource;
    dsLst_FileTypes: TDataSource;
    dsList_Subjects: TDataSource;
    ImageListMain: TImageList;
    SQLite3Con: TSQLite3Connection;
		SQLQryItemsitm_Ctrl: TStringField;
		SQLQryItemsitm_DatAlt: TStringField;
		SQLQryItemsitm_DatGen: TStringField;
		SQLQryItemsitm_DatLastPrinted: TStringField;
		SQLQryItemsitm_DocFile: TStringField;
		SQLQryItemsitm_Fk_Subj: TLongintField;
		SQLQryItemsitm_KeyWords: TMemoField;
		SQLQryItemsitm_LastSerial: TLongintField;
		SQLQryItemsitm_Nm: TStringField;
		SQLQryItemsitm_Notes: TMemoField;
		SQLQryItemsitm_Title: TStringField;
		SQLQryItemsitm_VolgNr: TLongintField;
		SQLQryItemsitm_YNPrint: TLongintField;
		SQLQryItemsitm_YNShow: TLongintField;
                SQLQryItemspkey: TStringField;
                SQLQryItemstblapkey: TStringField;
		SQLQryItems_id: TAutoIncField;
                SQLQryLanguages: TSQLQuery;
                SQLQryLanguageslang_Ctrl: TStringField;
                SQLQryLanguageslang_Nm: TStringField;
                SQLQryLanguageslang_Notes: TMemoField;
                SQLQryLanguageslang_VolgNr: TLongintField;
                SQLQryLanguagespkey: TStringField;
                SQLQryLanguages_id: TLongintField;
    SQLQryList_Subjects: TSQLQuery;
    SQLQryList_Subjectssubj_Notes: TStringField;
    SQLQryList_Subjectssubj_Title: TStringField;
    SQLQryList_Subjects_id: TLargeintField;
    SQLQryLookUpItemsCalc: TLongintField;
		SQLQryLookUpItemslupI_Code: TStringField;
    SQLQryLookUpItemslupI_Fk_LookUpCd: TLongintField;
    SQLQryLookUpItemslupI_IntVal: TLongintField;
    SQLQryLookUpItemslupI_MemoVal: TMemoField;
    SQLQryLookUpItemslupI_TextVal: TStringField;
    SQLQryLookUpItemslupI_VlgNr: TLongintField;
    SQLQryLookUpItems_id: TLongintField;
    SQLQryLookUps: TSQLQuery;
    SQLQryLookUpslkup_Code: TStringField;
    SQLQryLookUpslkup_LookUpCd: TLongintField;
    SQLQryLookUpslkup_Nm: TStringField;
    SQLQryLookUpslkup_Notes: TMemoField;
    SQLQryLookUps_id: TAutoIncField;
    SQLQryLookUpItems: TSQLQuery;
    SQLQryLst_ItemTypes: TSQLQuery;
    SQLQrySettingsstng_MemoVal: TMemoField;
    SQLQrySettingsstng_Nm: TStringField;
    SQLQrySettingsstng_Notes: TMemoField;
    SQLQrySettingsstng_NumVal: TMemoField;
    SQLQrySettingsstng_TextVal: TStringField;
    SQLQrySettings_id: TAutoIncField;
    SQLQrySubjectssubj_Notes: TMemoField;
    SQLQrySubjectssubj_Title: TStringField;
    SQLQrySubjects_id: TAutoIncField;
    SQLQrySleutelsLtsteWrde: TLongintField;
    SQLQrySleutelsNmTabel: TStringField;
    SQLQrySleutels_id: TLongintField;
    SQLQrySleutels: TSQLQuery;
    SQLQryGetId_id: TLongintField;
    SQLQryExecute: TSQLQuery;
    SQLQrySubjects: TSQLQuery;
    SQLQryLst_FileTypes: TSQLQuery;
		SQLQryItems: TSQLQuery;
                SQLQryTT_tbla_tblb: TSQLQuery;
                SQLQryTT_tbla_tblblang_Nm: TStringField;
                SQLQryTT_tbla_tblbpkey: TStringField;
                SQLQryTT_tbla_tblbTT_tbla_Fk_tbla: TStringField;
                SQLQryTT_tbla_tblbTT_tbla_Fk_tblb: TStringField;
                SQLQryTT_tbla_tblbTT_tbla_KeyWords: TMemoField;
                SQLQryTT_tbla_tblbTT_tbla_Nm: TStringField;
                SQLQryTT_tbla_tblbTT_tbla_Notes: TMemoField;
                SQLQryTT_tbla_tblbTT_tbla_VolgNr: TLongintField;
                SQLQryTT_tbla_tblb_id: TLongintField;
                SQLQrySettings: TSQLQuery;
    SQLTransact: TSQLTransaction;
    StringField3: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SQLite3ConBeforeConnect(Sender: TObject);

    ///-i- Algemeen
    procedure SQLQryAfterPost(DataSet: TDataSet);
    procedure SQLQryAfterInsert(DataSet: TDataSet);
    function Ophoog(lTableName: string): longint;
    procedure RefrSqlQry(aSqlQry: TSQLQuery);
    procedure ResetDetailDs(aSqlQuery: TSQLQuery; aParm: string; aParmVal: integer);
    ///-o- Algemeen

    procedure RefrLijsten(aSqlQuery: TSQLQuery);
    procedure SQLQryLookUpItemsAfterInsert(DataSet: TDataSet);
    procedure SQLQryLookUpItemsAfterPost(DataSet: TDataSet);
    procedure SQLQryLookUpItemsCalcFields(DataSet: TDataSet);
    procedure SQLQryLookUpsAfterInsert(DataSet: TDataSet);
    procedure SQLQryLookUpsAfterPost(DataSet: TDataSet);
    procedure SQLQryLookUpsBeforeScroll(DataSet: TDataSet);
    procedure SQLQrySleutelsAfterPost(DataSet: TDataSet);

    procedure SQLQrySubjectsAfterInsert(DataSet: TDataSet);
    procedure SQLQrySubjectsAfterPost(DataSet: TDataSet);
    procedure SQLQryItemsAfterInsert(DataSet: TDataSet);
    procedure SQLQryItemsAfterPost(DataSet: TDataSet);

    procedure SQLQryTT_tbla_tblbAfterInsert(DataSet: TDataSet);

    procedure SQLQryLanguagesAfterInsert(DataSet: TDataSet);
  private
    ///-i- Algemeen
    function FieldExist(DataSet: TDataSet; FieldName: String): Boolean;
    procedure UpdateLookUpLsts;
    ///-o- Algemeen
  public
    ///-i- Algemeen
    procedure ResetDs(aSqlQuery: TSQLQuery; aParm: string; aParmVal: String); overload;
    procedure ResetDetailDsTwoParm(aSqlQuery: TSQLQuery; aFrstParm: String;
					aScndParm: String; aFrstParmVal: Integer; aScndParmVal: String);
    function GetTextFromSql(aSqlQuery: TSQLQuery; aFieldNm: string;
					aKey: longint): string;
    function ExecuteCmnds(aCommand: string): boolean;
    /// Changes Sql property
    procedure ChangeSqlQrySql(aSqlQry: TSQLQuery; aSql: string;
      aParmNm: string; aKey: longint = 0);
    procedure UpdateAll(aSqlQuery: TSQLQuery);
    procedure SealTable(aSqlDb: TSQLQuery);
    function SetToEdit(aSqlDb: TSQLQuery): Boolean;
    function SetToInsert(aSqlDb: TSQLQuery): Boolean;
    /// Set record pointer
    function SelectKey(aSqlDb: TSQLQuery; aKey: LongInt): Boolean;
    /// Managing file-reposity filepath
    function SetFilePath(aSqlQry: TSQLQuery; aFileNmFld: String; aFilePath: String;
      aFilePathFld: String=''; aFileTypeFld: String=''; aFileStatusFld: String=
  ''): Boolean;
    ///-o- Algemeen

    procedure InitTables;
  end;

var
  DatModMain: TDatModMain;

implementation

{$R *.lfm}

{ TDatModMain }

uses
  sqlcommands,
  VD_Conversie,
  cls_migrate,
  globals;

var
  mHighSerial_Lkup: Integer;

procedure TDatModMain.SQLite3ConBeforeConnect(Sender: TObject);
begin
  SQLite3Con.DataBaseName := qPathToDataBaseFile;
end;

procedure TDatModMain.DataModuleCreate(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  SQLiteLibraryName := pathCombine(ExtractFilePath(Application.ExeName ), cns_PathToSqliteDll);
  {$ENDIF}
  SQLite3Con.Connected := True;
  SQLTransact.Active := True;
end;

procedure TDatModMain.InitTables;
begin
  SQLQrySubjects.Active := True;
  SQLQryList_Subjects.Active := True;
  SQLQryItems.Active := True;
  SQLQryLanguages.Active := True;
  SQLQryTT_tbla_tblb.Active := True;

  SQLQryLst_FileTypes.Active := True;
  SQLQryLst_ItemTypes.Active := True;

  SQLQryLookUps.Active := True;
  SQLQryLookUpItems.Active := True;
  SQLQrySleutels.Active := True;
  SQLQrySleutels.ExecSQL;

    //SQLQryBulkDocs.Active := True;
end;

procedure TDatModMain.SQLQryTT_tbla_tblbAfterInsert(DataSet: TDataSet);
begin
  SQLQryAfterInsert(DataSet);

  /// Tbla foreing key zetten
  SQLQryTT_tbla_tblbTT_tbla_Fk_tbla.AsString := SQLQryItemspkey.AsString;
  /// Tblb foreing key zetten
  SQLQryTT_tbla_tblbTT_tbla_Fk_tblb.AsString := SQLQryLanguagespkey.AsString;
end;

procedure TDatModMain.RefrLijsten(aSqlQuery: TSQLQuery);
begin
  //aSQLQuery.DisableControls;
  aSQLQuery.Refresh;
  //aSQLQuery.EnableControls;
end;

//%///%/// SQLQry EventHandlers
procedure TDatModMain.SQLQrySubjectsAfterInsert(DataSet: TDataSet);
begin
  SQLQrySubjects_id.AsLongInt := Ophoog(cns_tbl_Subjects_nm);
end;

procedure TDatModMain.SQLQrySubjectsAfterPost(DataSet: TDataSet);
begin
  UpdateAll(SQLQrySubjects);
  RefrLijsten(SQLQryList_Subjects);
end;

procedure TDatModMain.SQLQrySleutelsAfterPost(DataSet: TDataSet);
begin
  UpdateAll(SQLQrySleutels);
end;

procedure TDatModMain.DataModuleDestroy(Sender: TObject);
begin
  SQLTransact.EndTransaction;
  SQLTransact.Active := False;
  SQLite3Con.Connected := False;
end;

procedure TDatModMain.SQLQryLookUpItemsAfterInsert(DataSet: TDataSet);
begin
  SQLQryLookUpItems_id.AsLongInt := Ophoog(cns_tbl_LookUpItems_nm);

  SQLQryLookUpItemslupI_Fk_LookUpCd.AsLongint := SQLQryLookUpslkup_LookUpCd.AsLongint;
  SQLQryLookUpItemslupI_Code.AsString := SQLQryLookUpslkup_Code.AsString;
  mHighSerial_Lkup += 10;
  SQLQryLookUpItemslupI_VlgNr.AsLongint := mHighSerial_Lkup;
end;

procedure TDatModMain.SQLQryLookUpItemsAfterPost(DataSet: TDataSet);
begin
  UpdateAll(SQLQryLookUpItems);
  UpdateLookUpLsts;
end;

procedure TDatModMain.SQLQryLookUpItemsCalcFields(DataSet: TDataSet);
begin
  if SQLQryLookUpItemslupI_VlgNr.AsInteger > mHighSerial_Lkup then
    mHighSerial_Lkup := SQLQryLookUpItemslupI_VlgNr.AsInteger;
end;

procedure TDatModMain.SQLQryLookUpsAfterInsert(DataSet: TDataSet);
begin
  SQLQryLookUps_id.AsLongInt := Ophoog(cns_tbl_LookUps_nm);
end;

procedure TDatModMain.SQLQryLookUpsAfterPost(DataSet: TDataSet);
begin
  UpdateAll(SQLQryLookUps);
end;

procedure TDatModMain.SQLQryLookUpsBeforeScroll(DataSet: TDataSet);
begin
  mHighSerial_Lkup := 0;
end;

procedure TDatModMain.SQLQryItemsAfterInsert(DataSet: TDataSet);
begin
  SQLQryAfterInsert(DataSet);
  SQLQryItemsitm_Fk_Subj.AsLongint := SQLQryList_Subjects_id.AsLongInt;
end;

procedure TDatModMain.SQLQryItemsAfterPost(DataSet: TDataSet);
begin
  UpdateAll(SQLQryItems);
end;

procedure TDatModMain.SQLQryLanguagesAfterInsert(DataSet: TDataSet);
begin
  SQLQryAfterInsert(DataSet);
end;

///-i- Algemeen
procedure TDatModMain.SQLQryAfterPost(DataSet: TDataSet);
begin
  UpdateAll(TSqlQuery(DataSet));
end;

procedure TDatModMain.SQLQryAfterInsert(DataSet: TDataSet);
begin
  if FieldExist(DataSet, '_id') then
    TSQLQuery(DataSet).FieldByName('_id').AsLongInt := Ophoog(TSQLQuery(DataSet).Name);
  if FieldExist(DataSet, 'pkey') then
    TSQLQuery(DataSet).FieldByName('pkey').AsString := GetKeyDateTimeStr;
end;

function TDatModMain.Ophoog(lTableName: string): longint;
var
  lInteger: longint;
begin
  with SQLQrySleutels do
  begin
    //*sm02 Record bijzoeken/aanmaken in OphoogDataSet.
    if not (SQLQrySleutels.Locate('NmTabel', lTableName, [])) then
    begin
      // Als tabel nog niet in gebruik was
      append;
      FieldByName('NmTabel').AsString := lTableName;
      FieldByName('LtsteWrde').AsLongint := 10;
      lInteger := 10;
      //ShowMessage( 'Er is een nieuwe record aangemaakt' + chr( 13 ) +
      //  'tbv sleutel registratie voor tabel:' + chr( 13 ) +
      //  lTableName );
    end
    else
    begin
      Edit;
      FieldByName('LtsteWrde').AsLongint :=
        FieldByName('LtsteWrde').AsLongint + 10;
      lInteger := FieldByName('LtsteWrde').AsLongint;
    end;
    Post;
  end;  // With

  Result := lInteger;
end;

procedure TDatModMain.RefrSqlQry(aSqlQry: TSQLQuery);
begin
  aSqlQry.DisableControls;
  aSqlQry.Refresh;
  aSqlQry.EnableControls;
end;

procedure TDatModMain.ResetDetailDs(aSqlQuery: TSQLQuery; aParm: string;
  aParmVal: integer);
begin
  if (aSQLQuery.State in [dsEdit, dsInsert] ) then
   aSQLQuery.Post;

 aSQLQuery.DisableControls;
 aSQLQuery.ParamByName(aParm).AsInteger:= aParmVal;
 aSQLQuery.Refresh;
 aSQLQuery.EnableControls;
end;

procedure TDatModMain.ResetDs(aSqlQuery: TSQLQuery; aParm: string;
  aParmVal: String);
begin
 if (aSQLQuery.State in [dsEdit, dsInsert] ) then
   aSQLQuery.Post;

 aSQLQuery.DisableControls;
 aSQLQuery.ParamByName(aParm).AsString:= aParmVal;
 aSQLQuery.Refresh;
 aSQLQuery.EnableControls;
end;

procedure TDatModMain.ResetDetailDsTwoParm(aSqlQuery: TSQLQuery;
  aFrstParm: String;
  aScndParm: String;
  aFrstParmVal: Integer;
  aScndParmVal: String);
begin
  aSQLQuery.DisableControls;
  aSQLQuery.ParamByName(aFrstParm).AsInteger:= aFrstParmVal;
  aSQLQuery.ParamByName(aScndParm).AsString:= aScndParmVal;
  aSQLQuery.Refresh;
  aSQLQuery.EnableControls;
end;

function TDatModMain.FieldExist(DataSet: TDataSet; FieldName: String): Boolean;
var
  lFindFld: TField;
begin
  Result := false;
  lFindFld := nil;
  lFindFld := DataSet.FindField(FieldName);
  if Assigned(lFindFld) then
    Result := true;
end;

procedure TDatModMain.UpdateLookUpLsts;
begin
  RefrLijsten(SQLQryLst_ItemTypes);
  RefrLijsten(SQLQryLst_FileTypes);
end;

function TDatModMain.GetTextFromSql(aSqlQuery: TSQLQuery; aFieldNm: string;
  aKey: longint): string;
var
  lInd: boolean;
begin
  lInd := False;
  try
    try
      aSqlQuery.Locate('_id', aKey, []);
    except
      lInd := True;
    end;
  finally
  end;

  if lInd then
    Result := EmptyStr
  else
    Result := aSqlQuery.FieldByName(aFieldNm).AsString;
end;

function TDatModMain.ExecuteCmnds(aCommand: string): boolean;
begin
  Result := false;
  Try
    SQLQryExecute.Close;
    SQLQryExecute.SQL.Clear;
    SQLQryExecute.SQL.Add(aCommand);
    SQLQryExecute.ExecSQL;
    SQLTransact.CommitRetaining;
    //SqlQryGetId.open;
    SQLQryExecute.close;
    SQLQryExecute.SQL.Clear;
    Result := True;
  except
    ShowMessage('Something went wrong executing a sql command');
  end;
end;

procedure TDatModMain.ChangeSqlQrySql(aSqlQry: TSQLQuery; aSql: string;
  aParmNm: string; aKey: longint = 0);
begin
  aSqlQry.DisableControls;
  SealTable(aSqlQry);

  aSqlQry.Close;
  aSqlQry.Sql.Clear;
  aSqlQry.Sql.Add(aSql);
  aSqlQry.Open;

  if aKey <> 0 then
  begin
    aSqlQry.ParamByName(aParmNm).AsInteger := aKey;
    aSqlQry.Refresh;
  end;

  aSqlQry.EnableControls;
end;

procedure TDatModMain.UpdateAll(aSqlQuery: TSQLQuery);
begin
   //Todo: Eerst een check uitvoeren of er wel updates zijn, scheelt een hoop.
  //if aSqlQuery.UpdateStatus in [usModified] then
  //begin
  try
    try
      aSqlQuery.DisableControls;
      aSqlQuery.ApplyUpdates(-1);
      SQLTransact.CommitRetaining;

    Except
      ShowMessage(cns_Msg_UpdateFailed);
    end;
  finally
    aSqlQuery.EnableControls;
  end;
  //end;
end;

procedure TDatModMain.SealTable(aSqlDb: TSQLQuery);
begin
  if (aSqlDb.State in [dsEdit, dsInsert] ) then
  begin
    aSqlDb.Post;
  end;
end;

/// Return is true if actively set to edit
function TDatModMain.SetToEdit(aSqlDb: TSQLQuery): Boolean;
begin
  Result := false;
  if not(aSqlDb.State in [dsEdit, dsInsert] ) then
  begin
    /// Check is sqlQry has records
    if aSqlDb.EOF then
      aSqlDb.Insert
    else
      aSqlDb.Edit;

    Result := true;
  end;
end;

/// Return is true if actively set to insert
function TDatModMain.SetToInsert(aSqlDb: TSQLQuery): Boolean;
begin
  Result := false;
  if not(aSqlDb.State in [dsInsert] ) then
  begin
    if (aSqlDb.State in [dsEdit] ) then
      aSqlDb.Post;

    aSqlDb.Insert;
    Result := true;
  end;
end;

function TDatModMain.SelectKey(aSqlDb: TSQLQuery; aKey: LongInt): Boolean;
begin
  Result := aSqlDb.Locate('_id', aKey, []);
end;

function TDatModMain.SetFilePath(aSqlQry: TSQLQuery; aFileNmFld: String;
  aFilePath: String; aFilePathFld: String = ''; aFileTypeFld: String = ''; aFileStatusFld: String = ''): Boolean;
//const
//  cn_RastImageExtents = 'PNG JPG JPEG GIF WEBP TIFF PSD RAW BMP HEIF INDD';
//  cn_VectImageExtents = 'SVG AI EPS;
//  cn_DocExtents = 'DOCX PDF ODT ODF TXT RTF HTM';
//  cn_MindMapExt = 'MM ';
//  cn_SpreadShtExt = 'ODS XLSX'
//  cn_PowerPtExt = 'PPTX PPSX ODP';
var
  lAbsPath: String;
  lFileNm: String;
  lFiletype: String;
  lFileExt: String;
  lPos: Integer;
  lInd_Status: Boolean;
begin
  lInd_Status := False;
  if not (aFilePath = EmptyStr) then
  begin
    lAbsPath := aFilePath;
    lFileNm := ExtractFileName(lAbsPath);
    lFileExt := ExtractFileExt(lAbsPath);
    /// Bevind de file zich wel of niet in de repository?
    lPos := Pos(qPathToRepoDir, lAbsPath);
    if lPos = 0 then
    begin
      /// Copieer eerst de file
      if MessageDlg('Question', 'The selected file is outside of the programs filerepository' + #13 +
         'Do you wish to Copy the file to the programs file-repo directory?' + #13 +
         'This will make your program more portable' + #13 +
         'Pressing Yes wil copy the file to the repo and adjust the saved' + #13 +
         'path parameters in the program',
         mtConfirmation, [mbYes, mbNo],0) = mrYes then
       begin
         if CopyFile( lAbsPath, pathCombine(qPathToRepoDir, lFileNm)) then
         begin
           ShowMessage('Copying of the file was succesfull');
           lInd_Status := True;
         end
         else
         begin
           ShowMessage('Copying of the file was unsuccesfull');
         end;

       end;

    end;


    SetToEdit(aSqlQry);
    /// Save the filename
    aSqlQry.FieldByName(aFileNmFld).AsString := lFileNm;
    /// Save the original path
    if not (aFilePathFld = EmptyStr) then
      aSqlQry.FieldByName(aFilePathFld).AsString := lAbsPath;
    /// Save the file type
    if not (aFileTypeFld = EmptyStr) then
    begin




           // if pos(lFileExt, cn_RastImageExtents) > 0 then
           //   lFileType := 'Image';
           //if pos(lFileExt, cn_VectImageExtents) > 0 then
           //  lFileType := 'Vector image';
           //if pos(lFileExt, cn_DocExtents) > 0 then
           //  lFileType := 'Document';
           //if pos(lFileExt, cn_MindMapExt) > 0 then
           //  lFileType := 'Mindmap';
           //if pos(lFileExt, cn_SpreadShtExt) > 0 then
           //  lFileType := 'Spreadsheat';
           //if pos(lFileExt, cn_PowerPtExt) > 0 then
           //  lFileType := 'Presentation';
           //
      aSqlQry.FieldByName(aFileTypeFld).AsString := GetFileType(lFileType);
    end;

    if lInd_Status and (aFileStatusFld <> EmptyStr) then
      if lInd_Status then
        aSqlQry.FieldByName(aFileStatusFld).AsString := cn_FldStatus_InRepo
      else
        aSqlQry.FieldByName(aFileStatusFld).AsString := cn_FldStatus_OutsideRepo;

    aSqlQry.Post;

  end;
end;

///-o- Algemeen

end.
