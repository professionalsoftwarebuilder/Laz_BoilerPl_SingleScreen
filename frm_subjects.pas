unit frm_subjects;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  ComCtrls, DBGrids, StdCtrls, VD_FormPosSize;

type

  { TfrmSubjects }

  TfrmSubjects = class(TForm)
    dbedtSubTitle: TDBEdit;
    dbGrdSubjects: TDBGrid;
    dbMmSubjects: TDBMemo;
    dsSubjects: TDataSource;
    dbNavSubjects: TDBNavigator;
    lblSubjTitle: TLabel;
    pgcntrlSubjects: TPageControl;
    tbshtNotes: TTabSheet;
    tbshtDetails: TTabSheet;
    tbshtOverz: TTabSheet;
    VDFormPosSize1: TVDFormPosSize;
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmSubjects: TfrmSubjects;

implementation

{$R *.lfm}

{ TfrmSubjects }

procedure TfrmSubjects.FormShow(Sender: TObject);
begin
  pgcntrlSubjects.ActivePageIndex := 0;
end;

end.

