unit frm_settings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, DBCtrls,
  ComCtrls, DBGrids, StdCtrls, ExtCtrls, VD_FormPosSize, frm_shownotes,
  fram_standaard;

type

  { TfrmSettings }

  TfrmSettings = class(TForm)
    btnSelFileRepo: TButton;
    chckBxShowNotes: TCheckBox;
    dbedtTitle: TDBEdit;
    dsNtnGenres: TDataSource;
    edtRepoDir: TEdit;
    lblFileRepo: TLabel;
    tbshtIniSettings: TTabSheet;
    theDbgrd: TDBGrid;
    dbmmDocNotes: TDBMemo;
    dbTxtPnlSelectedRec: TDBText;
    dsItems: TDataSource;
    theDbNavigator: TDBNavigator;
    Label1: TLabel;
    opnDlgDocFilePath: TOpenDialog;
    Panel1: TPanel;
    thePageControl: TPageControl;
    tbshtNotes: TTabSheet;
    tbshtDetails: TTabSheet;
    tbshtOverz: TTabSheet;
    theSelDirDialog: TSelectDirectoryDialog;
    theToolBar: TToolBar;
    VDFormPosSize1: TVDFormPosSize;
    procedure btnAddGenreClick(Sender: TObject);
    procedure btnOpenDocClick(Sender: TObject);
    procedure btnSelFileRepoClick(Sender: TObject);
    procedure btnSelFilePathClick(Sender: TObject);
    procedure chckBxShowNotesChange(Sender: TObject);
    procedure dbCmbBxSubjectsSelect(Sender: TObject);
    procedure dsItemsDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgrpAllOrBySubjClick(Sender: TObject);
    procedure thePageControlChange(Sender: TObject);
  private
    fNotesForm: TfrmShowNotes;
  public
		class procedure ShowfrmSettings;
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.lfm}

{ TfrmSettings }

uses
  variants,
  LCLintf,
  sqlcommands,
  Globals;

var
  qCurSubj: integer;

procedure TfrmSettings.btnSelFilePathClick(Sender: TObject);
begin

end;

procedure TfrmSettings.chckBxShowNotesChange(Sender: TObject);
begin
  if chckBxShowNotes.Checked then
    TfrmShowNotes.showNotes(fNotesForm, dsItems, 'itm_Notes')
  else
    if Assigned(fNotesForm) then
      fNotesForm.Close;
end;

procedure TfrmSettings.dbCmbBxSubjectsSelect(Sender: TObject);
begin

end;

procedure TfrmSettings.dsItemsDataChange(Sender: TObject; Field: TField);
begin
  with MainDataMod do
  begin
    If Trim(SQLQryItemsitm_Notes.AsString) = EmptyStr then
      tbshtNotes.Caption := 'Notes'
    else
      tbshtNotes.Caption := 'Notes!!';
  end;
end;

procedure TfrmSettings.FormDestroy(Sender: TObject);
begin
  if Assigned(fNotesForm) then
    fNotesForm.Destroy;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  thePageControl.ActivePageIndex := 0;
  edtRepoDir.Text :=  qIniPropStorage.ReadIniString(cns_Ini_PathToRepoDir, EmptyStr);
end;

procedure TfrmSettings.rdgrpAllOrBySubjClick(Sender: TObject);
begin

end;

procedure TfrmSettings.thePageControlChange(Sender: TObject);
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

procedure TfrmSettings.btnOpenDocClick(Sender: TObject);
begin

end;

procedure TfrmSettings.btnSelFileRepoClick(Sender: TObject);
var
  lDirName: string;
begin
  if theSelDirDialog.Execute then
  begin
    lDirName := theSelDirDialog.FileName;

    qIniPropStorage.WriteIniString(cns_Ini_PathToRepoDir, lDirName);
    edtRepoDir.Text := lDirName;
  end;
end;

procedure TfrmSettings.btnAddGenreClick(Sender: TObject);
begin

end;

class procedure TfrmSettings.ShowfrmSettings;
begin
  if not Assigned(frmSettings) then
    frmSettings := TfrmSettings.Create(Application);
  frmSettings.Show;
end;

end.
