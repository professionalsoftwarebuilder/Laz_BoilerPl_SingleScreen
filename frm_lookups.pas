unit frm_Lookups;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  ComCtrls, DBGrids, StdCtrls, fram_LkUpItems;

type

  { TfrmLookUps }

  TfrmLookUps = class(TForm)
    dbedtLkupCode: TDBEdit;
    dbedtCode: TDBEdit;
    dbedtLookupNm: TDBEdit;
    dsLookups: TDataSource;
    dbgrdLookups: TDBGrid;
    DBNavigator1: TDBNavigator;
    framLkUpItems1: TframLkUpItems;
    lblNumCode: TLabel;
    lblLookUpCode: TLabel;
    lblLookup: TLabel;
    pgcntrlLookUps: TPageControl;
    TabSheet1: TTabSheet;
    tbshtItems: TTabSheet;
    tbshtNotes: TTabSheet;
    tbshtOvervw: TTabSheet;
    procedure pgcntrlLookUpsChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLookUps: TfrmLookUps;

implementation



{$R *.lfm}

{ TfrmLookUps }

uses
  Globals;

procedure TfrmLookUps.pgcntrlLookUpsChange(Sender: TObject);
var
  lLkupId: Integer;
begin
  DBNavigator1.Enabled := (pgcntrlLookUps.ActivePage <> tbshtItems);

  if pgcntrlLookUps.ActivePage = tbshtItems then
  begin
         With MainDataMod do
    begin
      if (SQLQryLookUpItems.State in [dsEdit, dsInsert] ) then
      begin
        UpdateAll(SQLQryLookUpItems);
      end;

      ResetDetailDs(SQLQryLookUpItems, 'LkUpId', SQLQryLookUpslkup_LookUpCd.AsLongint);
    end;
  end;

end;

end.

