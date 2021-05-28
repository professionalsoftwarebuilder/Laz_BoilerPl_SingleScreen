unit frm_languages;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, Forms, Controls, Graphics, Dialogs, DBCtrls,
  ComCtrls, DBGrids, StdCtrls, ExtCtrls;

type

  { TfrmLanguages }

  TfrmLanguages = class(TForm)
    btnSelectRecord: TButton;
    dbedtTitle: TDBEdit;
    theDbgrd: TDBGrid;
    dbmmDocNotes: TDBMemo;
    dbTxtPnlSelectedRec: TDBText;
    dsItems: TDataSource;
    theDbNavigator: TDBNavigator;
    Label1: TLabel;
    opnDlgDocFilePath: TOpenDialog;
    Panel1: TPanel;
    thePageControl: TPageControl;
    tbshtVersions: TTabSheet;
    tbshtNotes: TTabSheet;
    tbshtDetails: TTabSheet;
    tbshtOverz: TTabSheet;
    theToolBar: TToolBar;
    procedure btnSelectRecordClick(Sender: TObject);
    procedure dsItemsDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure thePageControlChange(Sender: TObject);
  private
    { private declarations }
  public
		class procedure ShowfrmLanguages;
                class function ShowModalLanguages: Boolean;
  end;

var
  frmLanguages: TfrmLanguages;

implementation

{$R *.lfm}

{ TfrmLanguages }

uses
  variants,
  LCLintf,
  sqlcommands,
  Globals;

var
  qCurSubj: integer;

procedure TfrmLanguages.dsItemsDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TfrmLanguages.btnSelectRecordClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TfrmLanguages.FormShow(Sender: TObject);
begin
  thePageControl.ActivePageIndex := 0;
end;


procedure TfrmLanguages.thePageControlChange(Sender: TObject);
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

class procedure TfrmLanguages.ShowfrmLanguages;
begin
  if not Assigned(frmLanguages) then
    frmLanguages := TfrmLanguages.Create(Application);
  frmLanguages.Show;
end;

class function TfrmLanguages.ShowModalLanguages: Boolean;
var
  lfrmLanguages: TfrmLanguages;
begin
  lfrmLanguages :=  TfrmLanguages.Create(Nil);
  lfrmLanguages.btnSelectRecord.Visible := true;
  lfrmLanguages.Caption := lfrmLanguages.Caption + cns_Txt_SelectionForm;
  if lfrmLanguages.ShowModal = mrOK then
    Result := true
  else
    Result := false;

  FreeAndNil(lfrmLanguages);
end;

end.
