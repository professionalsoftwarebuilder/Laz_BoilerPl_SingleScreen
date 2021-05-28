unit sqlcommands;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils;

const
  cns_Sql_ItemsBySubj =
    'Select ' + #13 +
        '_id    , '  + #13 + #10 +
        'itm_Fk_Subj    , '  + #13 + #10 +
        'cast (itm_Ctrl as varchar(20)) as itm_Ctrl    , '  + #13 + #10 +
        'cast (itm_Title as varchar(254)) as itm_Title    , '  + #13 + #10 +
        'cast (itm_Nm  as varchar(85)) as itm_Nm  , '  + #13 + #10 +
        'itm_Notes    , '  + #13 + #10 +
        'itm_KeyWords    , '  + #13 + #10 +
        'cast (itm_DocFile as varchar(254)) as itm_DocFile    , '  + #13 + #10 +
        'cast (itm_DatLastPrinted as varchar(20)) as itm_DatLastPrinted    , '  + #13 + #10 +
        'cast (itm_DatGen as varchar(20)) as itm_DatGen        , '  + #13 + #10 +
        'cast (itm_DatAlt as varchar(20)) as itm_DatAlt          , '  + #13 + #10 +
        'itm_YNPrint         , '  + #13 + #10 +
        'itm_YNShow       , '  + #13 + #10 +
        'itm_VolgNr       , '  + #13 + #10 +
        'itm_LastSerial ' +
     'From ' + #13 +
         'Items  '   +
    'Where  ' +
         '(itm_Fk_Subj = :SubjectId) ' +
     'Order by ' + #13 +
         'itm_VolgNr, '  + #13 + #10 +
        'itm_Nm, '  + #13 + #10 +
        'itm_Title';


  cns_Sql_ItemsAll =
    'Select ' + #13 +
        '_id    , '  + #13 + #10 +
        'pkey, ' +
        'pkey As tblapkey, ' +
        'itm_Fk_Subj    , '  + #13 + #10 +
        'cast (itm_Ctrl as varchar(20)) as itm_Ctrl    , '  + #13 + #10 +
        'cast (itm_Title as varchar(254)) as itm_Title    , '  + #13 + #10 +
        'cast (itm_Nm  as varchar(85)) as itm_Nm  , '  + #13 + #10 +
        'itm_Notes    , '  + #13 + #10 +
        'itm_KeyWords    , '  + #13 + #10 +
        'cast (itm_DocFile as varchar(254)) as itm_DocFile    , '  + #13 + #10 +
        'cast (itm_DatLastPrinted as varchar(20)) as itm_DatLastPrinted    , '  + #13 + #10 +
        'cast (itm_DatGen as varchar(20)) as itm_DatGen        , '  + #13 + #10 +
        'cast (itm_DatAlt as varchar(20)) as itm_DatAlt          , '  + #13 + #10 +
        'itm_YNPrint         , '  + #13 + #10 +
        'itm_YNShow       , '  + #13 + #10 +
        'itm_VolgNr       , '  + #13 + #10 +
        'itm_LastSerial '  +
     'From ' + #13 +
         'Items  '  +
     'Order by ' + #13 +
         'itm_VolgNr, '  + #13 + #10 +
        'itm_Nm, '  + #13 + #10 +
        'itm_Title';

  cns_Sql_DVDsByGenre =
    'Select ' + #13 +
   	'DVDs._id	, '  + #13 + #10 +
    'dvd_Fk_Subj	, '  + #13 + #10 +
    'cast(dvd_Title as varchar(125)) as dvd_Title, '  + #13 + #10 +
    'cast(dvd_ArtNr as varchar(25)) as dvd_ArtNr, '  + #13 + #10 +
    'cast(dvd_FlyerNm as varchar(125)) as dvd_FlyerNm, '  + #13 + #10 +
    'cast(dvd_OmschKort as varchar(250)) as dvd_OmschKort, '  + #13 + #10 +
    'dvd_OmschLang	, '  + #13 + #10 +
    'dvd_Speeltijd, '  + #13 + #10 +
    'dvd_Leeftijd, '  + #13 + #10 +
    'dvd_Notes	, '  + #13 + #10 +
    'dvd_KeyWords	, '  + #13 + #10 +
    'dvd_DocFile	, '  + #13 + #10 +
    'dvd_YNPrint	, '  + #13 + #10 +
    'dvd_Rslt_Aant10	, '  + #13 + #10 +
   	'dvd_Rslt_Aant9	, '  + #13 + #10 +
   	'dvd_Rslt_Aant8	, '  + #13 + #10 +
   	'dvd_Rslt_Aant7	, '  + #13 + #10 +
   	'dvd_Rslt_Aant6	, '  + #13 + #10 +
   	'dvd_Rslt_IsLastKwrtChng	, '  + #13 + #10 +
    'cast(dvd_Rslt_AvrOud as varchar(40)) as dvd_Rslt_AvrOud, '  + #13 + #10 +
    'cast(dvd_Rslt_AvrNieuw as varchar(40)) as dvd_Rslt_AvrNieuw, '  + #13 + #10 +
   	'dvd_LastSerial	 '  + #13 + #10 +
   	'From ' + #13 +
    'DVDs ' + #13 + #10 +
    'inner join ' +
    'TT_genr_dvd ' +
    'on ' +
    'DVDs._id = TT_genr_dvd.TT_genr_Fk_dvd ' +
        'Where ' +
    '(TT_genr_dvd.TT_genr_Fk_genr = :SubjectId) ' + #13 + #10 +
    'Order by ' + #13 +
    'dvd_Title ';

  cns_Sql_DVDsByFlyer =
    'Select ' + #13 +
   	'_id	, '  + #13 + #10 +
    'dvd_Fk_Subj	, '  + #13 + #10 +
    'cast(dvd_Title as varchar(125)) as dvd_Title, '  + #13 + #10 +
    'cast(dvd_ArtNr as varchar(25)) as dvd_ArtNr, '  + #13 + #10 +
    'cast(dvd_FlyerNm as varchar(125)) as dvd_FlyerNm, '  + #13 + #10 +
    'cast(dvd_OmschKort as varchar(250)) as dvd_OmschKort, '  + #13 + #10 +
    'dvd_OmschLang	, '  + #13 + #10 +
    'dvd_Speeltijd, '  + #13 + #10 +
    'dvd_Leeftijd, '  + #13 + #10 +
    'dvd_Notes	, '  + #13 + #10 +
    'dvd_KeyWords	, '  + #13 + #10 +
    'dvd_DocFile	, '  + #13 + #10 +
    'dvd_YNPrint	, '  + #13 + #10 +
    'dvd_Rslt_Aant10	, '  + #13 + #10 +
   	'dvd_Rslt_Aant9	, '  + #13 + #10 +
   	'dvd_Rslt_Aant8	, '  + #13 + #10 +
   	'dvd_Rslt_Aant7	, '  + #13 + #10 +
   	'dvd_Rslt_Aant6	, '  + #13 + #10 +
   	'dvd_Rslt_IsLastKwrtChng	, '  + #13 + #10 +
    'cast(dvd_Rslt_AvrOud as varchar(40)) as dvd_Rslt_AvrOud, '  + #13 + #10 +
    'cast(dvd_Rslt_AvrNieuw as varchar(40)) as dvd_Rslt_AvrNieuw, '  + #13 + #10 +
   	'dvd_LastSerial	 '  + #13 + #10 +
   	'From ' + #13 +
    'DVDs ' + #13 + #10 +
    'Where ' +
    '(dvd_IsInFlyer = 1) ' + #13 + #10 +
    'Order by ' + #13 +
    'dvd_Title ';


implementation

end.

