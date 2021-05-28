unit Cls_Entities;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Type
TEntityClass = Class
  private
    FId: Integer;
    FSleutel: LongInt;
    FNm: String;

  Public
    property Sleutel: LongInt read FSleutel write FSleutel;
    property Nm: String read FNm write FNm;
    property Id: LongInt read FId write FId;

    constructor Create;

  end;


TDocumentClass = class(TEntityClass);
TDocTypeClass = class(TEntityClass);

TAddressClass = class(TEntityClass);

TLijstArtikelClass = class(TEntityClass);

TEenHeidClass = class(TEntityClass);

implementation
     constructor TEntityClass.Create;
     begin
           FSleutel := 0;
           FId := 0;
     End;

end.

