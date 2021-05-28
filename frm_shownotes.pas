unit frm_shownotes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  VD_FormPosSize;

type

  { TfrmShowNotes }

  TfrmShowNotes = class(TForm)
    dbTxtNotes: TDBMemo;
    VDFormPosSize1: TVDFormPosSize;
  private

  public
    class procedure showNotes(var aNotesForm: TfrmShowNotes; aDataSource: TDataSource;
      aFieldNm: String);
  end;

var
  frmShowNotes: TfrmShowNotes;

implementation

{$R *.lfm}

class procedure TfrmShowNotes.showNotes(var aNotesForm: TfrmShowNotes; aDataSource: TDataSource;
  aFieldNm: String);
begin
  if not Assigned(aNotesForm) then
    aNotesForm := TfrmShowNotes.Create(Application);
    aNotesForm.dbTxtNotes.DataSource := aDataSource;
    aNotesForm.dbTxtNotes.DataField := aFieldNm;
  aNotesForm.Show;
end;

end.

