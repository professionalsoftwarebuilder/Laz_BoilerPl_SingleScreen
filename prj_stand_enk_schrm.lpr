program prj_stand_enk_schrm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainForm, fpvectorial, fpvutils, frm_subjects, frm_Lookups,
  fram_LkUpItems, frm_items, sqlcommands, fram_standaard,
  frm_database,
  cls_appinit, frm_shownotes
  { you can add units after this };

{$R *.res}

begin

  RequireDerivedFormResource:=True;
  Application.Initialize;
  /// Zet paden ed.
  TAppInit.InitializeApp;
  Application.CreateForm(TfrmItems, frmItems);
  Application.CreateForm(TfrmShowNotes, frmShowNotes);
  Application.Run;
end.

