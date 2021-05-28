unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  ExtCtrls, ComCtrls, Menus,
  VD_FormPosSize;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    btnSubjects: TButton;
		btnItems: TButton;
                btnLanguages: TButton;
    Image1: TImage;
    mnItmDataBasse: TMenuItem;
    statbrMain: TStatusBar;
		theMainMenu: TMainMenu;
		mnItmSettingsFrm: TMenuItem;
		mnItmLookups: TMenuItem;
		mnitmSettings: TMenuItem;
    tlbrMainFrm: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    VDFormPosSize1: TVDFormPosSize;
    procedure btnLanguagesClick(Sender: TObject);
    procedure btnSubjectsClick(Sender: TObject);
		procedure btnItemsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnItmDataBasseClick(Sender: TObject);
		procedure mnItmLookupsClick(Sender: TObject);
    procedure btnItemsClickMulti(Sender: TObject);
    procedure mnItmSettingsFrmClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.lfm}

{ TFrmMain }

uses
  frm_items,
  frm_subjects,
  //Cls_Entities,
  datamodule,
  //VD_Conversie,
  //ps_inifile,
  frm_database,
  frm_lookups,
  frm_languages,
  frm_settings,
  cls_appinit,
  globals;

var
  mItmsFrms: TFormArray;


procedure TFrmMain.FormCreate(Sender: TObject);
var
  lIsAppDataDir: Boolean;
begin
end;

procedure TFrmMain.btnSubjectsClick(Sender: TObject);
begin
  if not Assigned(frmSubjects) then
    frmSubjects := TfrmSubjects.Create(Application);
  frmSubjects.Show;
end;

procedure TFrmMain.btnLanguagesClick(Sender: TObject);
begin
  TfrmLanguages.ShowfrmLanguages;
end;

procedure TFrmMain.btnItemsClick(Sender: TObject);
begin
  if not Assigned(frmItems) then
    frmItems := TfrmItems.Create(Application);
  frmItems.Show;
end;

procedure TFrmMain.btnItemsClickMulti(Sender: TObject);
var
  lLen : integer;
  lTop, lLeft: integer;
begin
  lLen :=  Length(mItmsFrms);

  SetLength(mItmsFrms, lLen + 1);

  mItmsFrms[lLen] := TfrmItems.Create(Application);
  mItmsFrms[lLen].Name := 'frmItems' + IntToStr(lLen);
  mItmsFrms[lLen].Caption := 'Items ' + IntToStr(lLen);
  (mItmsFrms[lLen] as TfrmItems).formTakePosition;


  //if lLen > 1 then
  //  lTop := mItmsFrms[lLen]

  mItmsFrms[lLen].Show;

end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
end;

procedure TFrmMain.mnItmDataBasseClick(Sender: TObject);
begin
   TfrmDataBase.ShowForm;
end;

procedure TFrmMain.mnItmLookupsClick(Sender: TObject);
begin
  if not Assigned(frmLookUps) then
    frmLookUps := TfrmLookUps.Create(Application);
  frmLookUps.Show;
end;

procedure TFrmMain.mnItmSettingsFrmClick(Sender: TObject);
begin
  TfrmSettings.ShowfrmSettings;
end;

procedure TFrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  lLen : integer;
  i: integer;
begin
  lLen :=  Length(mItmsFrms);

  try
    //if not qInd_ProblDataBase then
    for i := 0 to lLen do
    begin
      mItmsFrms[i].Close;
      mItmsFrms[i].Free;
    end;

    if Assigned(frmDataBase) then
    begin
      frmDataBase.Close;
      frmDataBase.Free;
    end;

    if Assigned(MainDataMod) then
      MainDataMod.Destroy;
  except
    ShowMessage(cns_Msg_ProblClosingProgram);
  end;
end;

end.


