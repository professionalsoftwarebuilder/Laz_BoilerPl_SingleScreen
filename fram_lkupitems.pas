unit fram_LkUpItems;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, DbCtrls, ComCtrls, DBGrids,
  StdCtrls, Dialogs;

type

  { TframLkUpItems }

  TframLkUpItems = class(TFrame)
				btnChangcode: TButton;
    DBEdit1: TDBEdit;
    dbEdtLkupCode: TDBEdit;
    DBEdit3: TDBEdit;
    dbmmItmMemVal: TDBMemo;
    dsLkUpItems: TDataSource;
    dbgrdLkUpItems: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    lblLookUpCd: TLabel;
    lblTextVal: TLabel;
    pgcntrlLkUpItems: TPageControl;
    tbshtNotes: TTabSheet;
    tbshtDetails: TTabSheet;
    tbshtOverview: TTabSheet;
		procedure btnChangcodeClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

{ TframLkUpItems }

procedure TframLkUpItems.btnChangcodeClick(Sender: TObject);
begin
  ShowMessage('Let op: De waarde in dit veld kan hardcode worden gebruikt in het programma.');
  dbEdtLkupCode.ReadOnly := false;
end;

end.

