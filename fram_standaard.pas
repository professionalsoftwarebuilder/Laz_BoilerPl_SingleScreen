unit fram_standaard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, DbCtrls, ComCtrls, DBGrids,
  StdCtrls, Dialogs, ExtCtrls;

type

  { TframStandaard }

  TframStandaard = class(TFrame)
			     btnAddGenre: TButton;
    DBMemo1: TDBMemo;
		dbTxtPnlSelectedRec: TDBText;
    dsNtnItems: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
		Panel1: TPanel;
    tbshtNotes: TTabSheet;
    tbshtDetails: TTabSheet;
    tbshtOverview: TTabSheet;
    thePageControl: TPageControl;
		theToolBar: TToolBar;
    procedure btnAddGenreClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private
    { private declarations }
    _OnTable: String;
  public
    { public declarations }
    property OnTable : String Read _OnTable Write _OnTable;
    constructor Create(TheOwner: TComponent); override;
  end;

implementation

{$R *.lfm}

{ TframStandaard }

uses
  Vd_Conversie,
  frm_languages,
  globals;

constructor TframStandaard.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  thePageControl.ActivePageIndex := 0;
end;

procedure TframStandaard.FrameEnter(Sender: TObject);
begin
  //MainDataMod.qOnTableGenres := _OnTable;
end;

procedure TframStandaard.btnAddGenreClick(Sender: TObject);
begin

  /// Gekoppelde keuze form Modal openen
  if TfrmLanguages.ShowModalLanguages then
  begin
    With MainDataMod do
    begin
      SQLQryTT_tbla_tblb.DisableControls;

      SQLQryTT_tbla_tblb.Insert;
      SQLQryTT_tbla_tblb.Post;
      SQLQryTT_tbla_tblb.Refresh;

      SQLQryTT_tbla_tblb.EnableControls;
    end;
  end;
end;

end.

