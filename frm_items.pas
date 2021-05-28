unit frm_items;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, DBCtrls,
  ComCtrls, DBGrids, StdCtrls, ExtCtrls, VD_FormPosSize, frm_shownotes,
  fram_standaard;

type

  { TfrmItems }

  TfrmItems = class(TForm)
    btnOpenDoc: TButton;
    btnSelFilePath: TButton;
    chckBxShowNotes: TCheckBox;
    dbedtFilePath: TDBEdit;
    dbedtTitle: TDBEdit;
    dsNtnGenres: TDataSource;
    framStandaard1: TframStandaard;
    statbrMain: TStatusBar;
    TabSheet1: TTabSheet;
    theDbgrd: TDBGrid;
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
    VDFormPosSize1: TVDFormPosSize;
    procedure btnAddGenreClick(Sender: TObject);
    procedure btnOpenDocClick(Sender: TObject);
    procedure btnSelFilePathClick(Sender: TObject);
    procedure chckBxShowNotesChange(Sender: TObject);
    procedure dbCmbBxSubjectsSelect(Sender: TObject);
    procedure dsItemsDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgrpAllOrBySubjClick(Sender: TObject);
    procedure thePageControlChange(Sender: TObject);
  private
    fNotesForm: TfrmShowNotes;
  public
		class procedure ShowfrmItems;
    procedure formTakePosition;
  end;

var
  frmItems: TfrmItems;

implementation

{$R *.lfm}

{ TfrmItems }

uses
  variants,
  LCLintf,
  sqlcommands,
  cls_appinit,
  Globals;

var
  qCurSubj: integer;

procedure TfrmItems.btnSelFilePathClick(Sender: TObject);
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

procedure TfrmItems.chckBxShowNotesChange(Sender: TObject);
begin
  if chckBxShowNotes.Checked then
    TfrmShowNotes.showNotes(fNotesForm, dsItems, 'itm_Notes')
  else
    if Assigned(fNotesForm) then
      fNotesForm.Close;
end;

procedure TfrmItems.dbCmbBxSubjectsSelect(Sender: TObject);
begin
  //if VarType(dbCmbBxSubjects.KeyValue) = varinteger then
    qCurSubj := dbCmbBxSubjects.KeyValue;
  With MainDataMod do
  begin
    ResetDetailDs(MainDataMod.SQLQryItems, 'SubjectId', qCurSubj);
    // Record pointer zetten
    SelectKey(SQLQryList_Subjects, qCurSubj);
  end;
  theDbgrd.Refresh;
  Application.ProcessMessages;
end;

procedure TfrmItems.dsItemsDataChange(Sender: TObject; Field: TField);
begin
  with MainDataMod do
  begin
    If Trim(SQLQryItemsitm_Notes.AsString) = EmptyStr then
      tbshtNotes.Caption := 'Notes'
    else
      tbshtNotes.Caption := 'Notes!!';
  end;
end;

procedure TfrmItems.FormCreate(Sender: TObject);
begin
  TAppInit.InitializeMainForm(Self);
end;

procedure TfrmItems.FormDestroy(Sender: TObject);
begin
  if Assigned(fNotesForm) then
    fNotesForm.Destroy;
end;

procedure TfrmItems.FormShow(Sender: TObject);
begin
  thePageControl.ActivePageIndex := 0;
end;

procedure TfrmItems.rdgrpAllOrBySubjClick(Sender: TObject);
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

procedure TfrmItems.thePageControlChange(Sender: TObject);
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

procedure TfrmItems.btnOpenDocClick(Sender: TObject);
var
  filename: string;
begin

  with MainDataMod do
  begin
    filename := SQLQryItemsitm_DocFile.AsString;

    OpenDocument(filename);

  end;
end;



procedure TfrmItems.btnAddGenreClick(Sender: TObject);
begin

end;

class procedure TfrmItems.ShowfrmItems;
begin
  if not Assigned(frmItems) then
    frmItems := TfrmItems.Create(Application);
  frmItems.Show;
end;

procedure TfrmItems.formTakePosition;
begin
  VDFormPosSize1.GetConfiguration;

end;

end.

