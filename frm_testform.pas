unit frm_testform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, DBCtrls,
  ComCtrls, DBGrids, StdCtrls, ExtCtrls;

type

  { TfrmTestForm }

  TfrmTestForm = class(TForm)
    btnOpenDoc: TButton;
    btnSelFilePath: TButton;
    dbedtFilePath: TDBEdit;
    dbedtTitle: TDBEdit;
    dbgrdDocuments: TDBGrid;
    dbLkupCmbxSujects: TDBLookupComboBox;
    dbCmbBxSubjects: TDBLookupComboBox;
    dbmmDocNotes: TDBMemo;
    dbmmDocKeyWords: TDBMemo;
    dbTxtPnlSelectedRec: TDBText;
    dsItems: TDataSource;
    rdgrpAllOrBySubj: TRadioGroup;
    theDbNavigator: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    lblSubject: TLabel;
    opnDlgDocFilePath: TOpenDialog;
    Panel1: TPanel;
    thePageControl: TPageControl;
    tbshtVersions: TTabSheet;
    tbshtKeyWords: TTabSheet;
    tbshtNotes: TTabSheet;
    tbshtDetails: TTabSheet;
    tbshtOverz: TTabSheet;
    theToolBar: TToolBar;
    procedure btnOpenDocClick(Sender: TObject);
    procedure btnSelFilePathClick(Sender: TObject);
    procedure dbCmbBxSubjectsSelect(Sender: TObject);
    procedure dsItemsDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure rdgrpAllOrBySubjClick(Sender: TObject);
    procedure thePageControlChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmTestForm: TfrmTestForm;

implementation

{$R *.lfm}

{ TfrmTestForm }

uses
  variants,
  LCLintf,
  sqlcommands,
  Globals;

var
  qCurSubj: integer;

procedure TfrmTestForm.btnSelFilePathClick(Sender: TObject);
var
  filename: string;
  lInd_EdtState: boolean;
begin
  lInd_EdtState := False;

  if opnDlgDocFilePath.Execute then
  begin
    filename := opnDlgDocFilePath.Filename;
    with MainDataMod do
    begin
      lInd_EdtState := SetToEdit(SQLQryItems);

      SQLQryItemsitm_DocFile.AsString := filename;

      if not lInd_EdtState then
        SQLQryItems.Post;
    end;
  end;
end;

procedure TfrmTestForm.dbCmbBxSubjectsSelect(Sender: TObject);
begin
  if VarType(dbCmbBxSubjects.KeyValue) = varinteger then
    qCurSubj := dbCmbBxSubjects.KeyValue;

  MainDataMod.ResetDetailDs(MainDataMod.SQLQryItems, 'SubjectId', qCurSubj);
  dbgrdDocuments.Refresh;
  Application.ProcessMessages;
end;

procedure TfrmTestForm.dsItemsDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TfrmTestForm.FormShow(Sender: TObject);
begin
  thePageControl.ActivePageIndex := 0;
end;

procedure TfrmTestForm.rdgrpAllOrBySubjClick(Sender: TObject);
begin
  with MainDataMod do
  begin
    if rdgrpAllOrBySubj.ItemIndex = 0 then
    begin
      dbCmbBxSubjects.Enabled := False;
      // Save current group
      qCurSubj := SQLQrySubjects_id.AsLongint;
      ChangeSqlQrySql(SQLQryItems, cns_Sql_ItemsAll, '');
    end;
    if rdgrpAllOrBySubj.ItemIndex = 1 then
    begin
      dbCmbBxSubjects.Enabled := True;
      ChangeSqlQrySql(SQLQryItems, cns_Sql_ItemsBySubj, 'SubjectId', qCurSubj);
    end;
  end;
end;

procedure TfrmTestForm.thePageControlChange(Sender: TObject);
begin
  //theDbNavigator.Enabled := thePageControl.ActivePage <> tbshtVersions;

  //if  thePageControl.ActivePage = tbshtVersions then
  //begin
  //  With MainDataMod do
  //  begin
  //    if (SQLQryVersions.State in [dsEdit, dsInsert] ) then
  //    begin
  //      UpdateAll(SQLQryVersions);
  //    end;

  //    ResetDetailDs(SQLQryVersions, 'Document', SQLQryDocuments_id.AsLongint);
  //  end;
  //end;
end;

procedure TfrmTestForm.btnOpenDocClick(Sender: TObject);
var
  filename: string;
begin

  with MainDataMod do
  begin
    filename := SQLQryItemsitm_DocFile.AsString;

    OpenDocument(filename);

  end;
end;

end.
