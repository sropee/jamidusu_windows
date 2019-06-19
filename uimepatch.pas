unit UIMEPatch;

//{$MODE Delphi}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows, StdCtrls, imm, LazUtils;

type

  { TMemo }

  TMemo = class(StdCtrls.TMemo)
  private
    FLastChar: PChar;
    FComp: Boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

constructor TMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  GetMem(FLastChar, 4);
  FComp:=False;
end;

destructor TMemo.Destroy;
begin
  inherited Destroy;

  FreeMem(FLastChar, 4);
end;

procedure TMemo.WndProc(var Message: TMessage);
var
  IMC: HIMC;
  Len: LONG;
  Str: PWideChar;
begin
  case Message.msg of
    WM_IME_STARTCOMPOSITION: FComp:=True;
    WM_CHAR: FComp:=False;
    WM_IME_COMPOSITION:
    begin
      inherited;
      if (Message.lParam and GCS_RESULTSTR) <> 0 then
      begin
        IMC:=ImmGetContext(Self.Handle);
        Len:=ImmGetCompositionStringW(IMC, GCS_RESULTSTR, nil, 0);
        if Len<>0 then
        begin
          GetMem(Str, Len+2);
          ImmGetCompositionStringW(IMC, GCS_RESULTSTR, Str, Len);
          Str[Len]:=#0;
          Str[Len+1]:=#0;
          UnicodeToUtf8(FLastChar, Str, 4);
          FreeMem(Str, Len+2);
        end;
        ImmReleaseContext(Self.Handle, IMC);
      end
    end;

    WM_KILLFOCUS:
    begin
      //if FComp then Self.Text:=Self.Text+FLastChar;
      inherited;
    end;

    else
      inherited;
  end;
end;

end.

