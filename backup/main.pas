{*****************************************************************************
                           자미두수명반 프로그램
                 Jamidusu(Zi Wei Dou Shu) Charting Program
 *****************************************************************************
                                   Copyright (C) 2011 두수초보(Dusuchobo)
                                   http://tinyurl.com/jamidusu
 *****************************************************************************
  This program is free software: you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published
  by the Free Software Foundation, either version 3 of the License,
  or (at your option) any later version.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
  or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see < http://www.gnu.org/licenses/ >.
 *****************************************************************************
  이 프로그램은 자유 소프트웨어입니다: 당신은 이것을 자유 소프트웨어 재단이
  발표한 GNU 일반 공중 사용허가서의 제3 버전이나 (선택에 따라) 그 이후 버전의
  조항 아래 재배포하거나 수정할 수 있습니다.

  이 프로그램은 유용하게 쓰이리라는 희망 아래 배포되지만, 특정한 목적에 대한
  프로그램의 적합성이나 상업성 여부에 대한 보증을 포함한 어떠한 형태의 보증도
  하지 않습니다.
  세부 사항은 GNU 일반 공중 사용허가서를 참조하십시오.

  당신은 이 프로그램과 함께 GNU 일반 공중 사용허가서를 받았을 것입니다.
  만약 그렇지 않다면, < http://www.gnu.org/licenses/ > 를 보십시오.

  GNU General Public License ver 3에 관한 비공식 한국어 번역문은
  < http://wiki.kldp.org/wiki.php/GNU/GPLV3Translation > 를 참조하십시오.
 *****************************************************************************
}

unit main;

{$mode objfpc}{$H+}
//{$DEFINE DebugMode}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, MaskEdit, StdCtrls, Buttons, ComCtrls, ColorBox, Printers, ActnList,
  PrintersDlgs, strutils, calendar_unit, UJamidusu, LCLType, UFileManagement,
  fphttpclient, LCLIntf, Windows;

type
  TRedrawInfo = set of (riNew, riNewSigan);

  { TForm1 }

  TForm1 = class(TForm)
    actDaehan: TAction;
    actList: TAction;
    actSave: TAction;
    actYuil: TAction;
    actYuwol: TAction;
    actYunyeon: TAction;
    ActionList1: TActionList;
    btnDisplay: TButton;
    Button1: TButton;
    btnListFind: TButton;
    btnSave: TButton;
    btnImage: TButton;
    btnAC: TButton;
    Button2: TButton;
    btnPrint: TButton;
    btnChartFinderResult: TButton;
    btnListAdd: TButton;
    btnListDelete: TButton;
    btnListUpward: TButton;
    btnListDownward: TButton;
    btnListUpdate: TButton;
    cmbSex: TComboBox;
    cmbYeokbeop: TComboBox;
    cmbHour: TComboBox;
    cmbBan: TComboBox;
    ColorBox1: TColorBox;
    edtNyeonju: TEdit;
    edtSajuFinder: TEdit;
    edtName: TEdit;
    Image1: TImage;
    lstList: TListBox;
    lstSajuFinder: TListBox;
    meBirth: TMaskEdit;
    Memo1: TMemo;
    PageControl1: TPageControl;
    pnlChartFinder: TPanel;
    pnlControl: TPanel;
    pnlList: TPanel;
    pnlSajuFinder: TPanel;
    pnlPreferences: TPanel;
    PrintDialog1: TPrintDialog;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tgbxDaehan: TToggleBox;
    tgbxSajuFinder: TToggleBox;
    tgbxYunyeon: TToggleBox;
    tgbxYuwol: TToggleBox;
    tgbxYuil: TToggleBox;
    tgbxList: TToggleBox;
    tgbxMemo: TToggleBox;
    tgbxHanja: TToggleBox;
    tgbxYajasi: TToggleBox;
    tgbxNyeonju: TToggleBox;
    tgbxChartFinder: TToggleBox;
    tgbxChartFinderJwabo: TToggleBox;
    tgbxChartFinderJigong: TToggleBox;
    tgbxChartFinderSamtae: TToggleBox;
    tgbxChartFinderJami: TToggleBox;
    tgbxChartFinderSungong: TToggleBox;
    tgbxChartFinderCheongong: TToggleBox;
    procedure actDaehanExecute(Sender: TObject);
    procedure actListExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actYuilExecute(Sender: TObject);
    procedure actYunyeonExecute(Sender: TObject);
    procedure actYuwolExecute(Sender: TObject);
    procedure btnChartFinderResultClick(Sender: TObject);
    procedure btnDisplayClick(Sender: TObject);
    procedure btnListAddClick(Sender: TObject);
    procedure btnListDeleteClick(Sender: TObject);
    procedure btnListDownwardClick(Sender: TObject);
    procedure btnListFindClick(Sender: TObject);
    procedure btnListUpwardClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnImageClick(Sender: TObject);
    procedure btnACClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnListUpdateClick(Sender: TObject);
    procedure cmbSexChange(Sender: TObject);
    procedure cmbYeokbeopChange(Sender: TObject);
    procedure cmbHourChange(Sender: TObject);
    procedure cmbBanChange(Sender: TObject);
    procedure edtNyeonjuKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edtSajuFinderKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lstListSelectionChange(Sender: TObject; User: boolean);
    procedure lstSajuFinderDblClick(Sender: TObject);
    procedure meBirthChange(Sender: TObject);
    procedure meBirthKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure meBirthKeyPress(Sender: TObject; var Key: char);
    procedure Memo1Exit(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tgbxChartFinderChange(Sender: TObject);
    procedure tgbxChartFinderCheongongChange(Sender: TObject);
    procedure tgbxChartFinderSamtaeChange(Sender: TObject);
    procedure tgbxChartFinderSungongChange(Sender: TObject);
    procedure tgbxChartFinderJamiChange(Sender: TObject);
    procedure tgbxChartFinderJwaboChange(Sender: TObject);
    procedure tgbxChartFinderJigongChange(Sender: TObject);
    procedure tgbxDaehanChange(Sender: TObject);
    procedure tgbxMemoClick(Sender: TObject);
    procedure tgbxSajuFinderClick(Sender: TObject);
    procedure tgbxYajasiChange(Sender: TObject);
    procedure tgbxYunyeonChange(Sender: TObject);
    procedure tgbxYuwolChange(Sender: TObject);
    procedure tgbxYuilChange(Sender: TObject);
    procedure tgbxListChange(Sender: TObject);
    procedure tgbxHanjaChange(Sender: TObject);
    procedure tgbxNyeonjuChange(Sender: TObject);
  private
    { private declarations }
    JamiCells: TJamiCells;
    Sigan, IdxSigan: array[1..5] of Integer;
    LangType,
    SiganCount, DayButtonCount,
    SelectGung,
    Age,
    ThisSolarYear, ThisSolarMonth, ThisSolarDay,
    ThisLunarYear, ThisLunarMonth, ThisLunarDay,
    // Variables of Chart Finder: CF*
    CFJwabo, CFJigong, CFSamtae, CFJami, CFSungong, CFCheongong,
    CFYearGan, CFYearJi, CFMonth, CFDay, CFHourJi,
    BonGung: Integer;
    ThisLunarYundal,
    DayButtonChecked, NewClient: Boolean;
    SambangSajeong: set of Byte;
    Clients: TClients;

    procedure GetTimeFromText(var Year, Month, Day, Hour, Minute: Integer);
    procedure SetTimeToText(const Year, Month, Day, Hour, Minute: Integer);

    procedure Redraw(RedrawInfo: TRedrawInfo = []; Yajasi: Boolean = False);
    procedure DrawLine;
    procedure SelectionMessage(Index: Integer; Content: string; BkColor: TColor = clYellow; BottomLine: Integer = 3);
    procedure ShowInfo(X, Y: Integer; Content: string; BkColor: TColor = clYellow);

    procedure SetDaehan(Value: Integer);
    procedure SetYunyeon(Value: Integer);
    procedure SetYuwol(Value: Integer);
    procedure SetYuil(Value: Integer);
    procedure InitSigan;

    procedure ValidateChartFinder;

    function GetImageName: string;
  public
    procedure CheckUpdates;
  end; 

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

const
  CFontSize = 11;
  CCellMargin = 2;
  CCanvasFont = '굴림';
  CFixedFont = '굴림체';
  CProjectVersion = '0.6.7';
  CWebsite = 'http://tinyurl.com/jamidusu';
  CRealSite = 'http://zwds.egloos.com/734433';

var
  LengthChar, PrevListSel: Integer;
  FoundName: string;

procedure TForm1.DrawLine;
var
  I: Integer;
begin
  with Image1.Canvas do
  begin
    Pen.Color := clBlack;
    Rectangle(0, 0, Image1.Width, Image1.Height);

    for I:=1 to 3 do
    begin
      Line(Trunc(Image1.Width/4*I), 0, Trunc(Image1.Width/4*I), Image1.Height);
      Line(0, Trunc(Image1.Height/4*I), Image1.Width, Trunc(Image1.Height/4*I));
    end;

    Pen.Color := clWhite;
    Line(Image1.Width div 2, Image1.Height div 4 + 1,
          Image1.Width div 2, Trunc(Image1.Height/4*3));
    Line(Image1.Width div 4 + 1, Image1.Height div 2,
          Trunc(Image1.Width/4*3), Image1.Height div 2);
  end;
end;

procedure TForm1.Redraw(RedrawInfo: TRedrawInfo = []; Yajasi: Boolean = False);
type
  TGan = array[0..9] of string;
  TJi = array[0..11] of string;
  TGanji = array[0..59] of string;
var
  I, T,
  tYear, tMonth, tDay, tHour, tMinute,
  tiYear, tiMonth, tiDay,
  mSign,
  Daeun,
  preName, preYear, preMonth, preDay, preHour, preMin,
  midName, midYear, midMonth, midDay, midHour, midMin,
  postName, postYear, postMonth, postDay, postHour, postMin: Integer;
  twYear, twMonth, twDay: Word;
  tempstr, GukMessage, SingungMessage, JojasiMessage, YajasiMessage: string;
  LargeMonth: Boolean;
  PSahangName: ^TSahangName;
  PNapeumName: ^TNapeumName;
  POhaenggukName: ^TOhaenggukName;
  PBrightnessName: ^TBrightnessName;
  PSahwaName: ^TSahwaName;
  PSeongName: ^TSeongName;
  PSiganStr: ^TSiganStr;
  PGan: ^TGan;
  PJi: ^TJi;
  //PGanji: ^TGanji;

  procedure PrintOut(Index: Integer; Text: string; Forced: Boolean = False);
  var
    Left, Top, P, Q, R: Integer;
    BrushColor: TColor;
    FontStyle: TFontStyles;
    T: string;
  begin
    with Image1.Canvas, JamiCells do
    begin
      if not Forced then BeforeAddItem(Index, TextHeight('綠'));
      Left:=CellCursor[Index].Left;
      Top:=CellCursor[Index].Top;

      BrushColor:=Brush.Color;
      FontStyle:=Font.Style;

      repeat
        P:=Pos('&', Text);

        if P > 0 then
        begin
          T:=Copy(Text, 1, P-1);
          TextOut(Left, Top, T);
          Inc(Left, TextWidth(T));
          Text:=Copy(Text, P+1, 255);

          Q:=Pos(',', Text);
          R:=StrToInt(Copy(Text, 1, Q-1));
          if R = -1 then Font.Color:=BrushColor else Font.Color:=R;
          Text:=Copy(Text, Q+1, 255);
		  
	  Q:=Pos(',', Text);
          case StrToInt(Copy(Text, 1, Q-1)) of
           -1: Font.Style:=FontStyle;
	    0: Font.Style:=[];
            1: Font.Style:=[fsBold];
            2: Font.Style:=[fsStrikeOut];
            3: Font.Style:=[fsBold, fsStrikeOut];
	  end;
          Text:=Copy(Text, Q+1, 255);
		  
	  Q:=Pos(';', Text);
          //if Brush.Color<>clWhite then Inc(Left);
          R:=StrToInt(Copy(Text, 1, Q-1));
          if R = -1 then Brush.Color:=BrushColor else Brush.Color:=R;
          Text:=Copy(Text, Q+1, 255);
        end
        else
        begin
          TextOut(Left, Top, Text);
          Break;
        end;
      until False;

      AddItem(Index, TextHeight(Text)+1);

      Brush.Color:=BrushColor;
      Font.Style:=FontStyle;
    end;
  end;

  procedure FormattedTextOut(Left, Top: Integer; Text: string);
  var
    P, Q, R: Integer;
    T: string;
    BrushColor: TColor;
    FontStyle: TFontStyles;
  begin
    with Image1.Canvas do
    begin
      BrushColor:=Brush.Color;
      FontStyle:=Font.Style;

      repeat
        P:=Pos('&', Text);

        if P > 0 then
        begin
          T:=Copy(Text, 1, P-1);
          TextOut(Left, Top, T);
          Inc(Left, TextWidth(T));
          Text:=Copy(Text, P+1, 255);

          Q:=Pos(',', Text);
          R:=StrToInt(Copy(Text, 1, Q-1));
          if R = -1 then Font.Color:=BrushColor else Font.Color:=R;
          Text:=Copy(Text, Q+1, 255);

	  Q:=Pos(',', Text);
          case StrToInt(Copy(Text, 1, Q-1)) of
           -1: Font.Style:=FontStyle;
	    0: Font.Style:=[];
            1: Font.Style:=[fsBold];
            2: Font.Style:=[fsStrikeOut];
            3: Font.Style:=[fsBold, fsStrikeOut];
	  end;
          Text:=Copy(Text, Q+1, 255);

	  Q:=Pos(';', Text);
          //if Brush.Color<>clWhite then Inc(Left);
          R:=StrToInt(Copy(Text, 1, Q-1));
          if R = -1 then Brush.Color:=BrushColor else Brush.Color:=R;
          Text:=Copy(Text, Q+1, 255);
        end
        else
        begin
          TextOut(Left, Top, Text);
          Break;
        end;
      until False;

      Brush.Color:=BrushColor;
      Font.Style:=FontStyle;
    end;
  end;

  function SeongColor(Seong: Integer; FontStyle: Integer = -1; Background: Integer = -1): string;
  begin
    case Seong of
     -1: ;
      0: Seong:=clWhite;
      1..14: begin
        Seong:=clFuchsia;
	if FontStyle = -1 then FontStyle:=1;
      end;
      15..20, 22: begin
        Seong:=clBlue;
        if FontStyle = -1 then FontStyle:=1;
      end;
      21: begin
        Seong:=clBlue;
        if Background = -1 then Background:=clMoneyGreen;
        if FontStyle = -1 then FontStyle:=1;
      end;
      23..30: begin
        Seong:=clRed;
        if FontStyle = -1 then FontStyle:=1;
      end;

      1000: Seong:=clPurple;
      10000: Seong:=clNavy;
      20000: Seong:=clGreen;
      30000: Seong:=clTeal;
      40000: Seong:=clOlive;
      50000: Seong:=clGray;
      60000: Seong:=clMaroon;
      else Seong:=clBlack;
    end;

    if FontStyle = -1 then FontStyle:=0;
    Result:=Format('&%d,%d,%d;', [Seong, FontStyle, Background]);
  end;

  function SeongFormat(Seong: Integer): string;
  var
    T, X: Integer;
  begin
    if Seong < 10000 then // 사화가 붙지 않은 경우.
    begin
      T:=(Seong mod 1000-1) mod 150 + 1;
      Result:=PSeongName^[T];
      if Length(Result) div LengthChar = 4 then
        Result:=Copy(Result, Length(Result)-LengthChar*2+1, 255);

      X:=(Seong mod 1000-1) div 150 + 1;
      if X>1 then
        Result:=SeongColor(X*10000) + PSiganStr^[X] + SeongColor(T, 0) + Result
      else
        Result:=SeongColor(T) + Result;

      T:=Seong div 1000; // 묘왕리함 표시
      if T > 0 then
        Result:=Result + SeongColor(1000, 1) + PBrightnessName^[T];
    end
    else
    begin
      Seong:=Seong div 10000;
      Result:='';
      for T:=1 to SiganCount+1 do // 선천사화까지 포함하기 때문에 +1
      begin
        X:=Seong and 7; // 유시, 유일, 유월, 유년, 대한, 선천 순으로 각각 3비트씩.
        case X of
          0: Result:=Result + SeongColor(-1, 0) + '權'; // 사화 없음.
          1: Result:=Result + SeongColor(T*10000, 1, clMoneyGreen) + PSahwaName^[1]; // 화록은 배경색을 달리함.
          4: Result:=Result + SeongColor(T*10000, 1, RGBToColor(255, 150, 255)) + PSahwaName^[4]; // 화기도
          else Result:=Result + SeongColor(T*10000, 1) + PSahwaName^[X];
        end;

        Seong:=Seong shr 3;
      end;
    end;
  end;

  procedure ArrangeGung; // 각 궁의 정보와 별들을 배치.
  var
    I, J, K, T: Integer;
    Content, Twelves, tempstr: string;
  begin
    for I:=0 to 11 do
      with Image1.Canvas, JamiCells, CellCursor[I] do
      begin
        ResetCell(I);

        Pen.Color:=clBlack;
        if I in SambangSajeong then Brush.Color:=RGBToColor(220, 220, 220)
        else if I = Bongung then Brush.Color:=RGBToColor(200, 255, 255)
        else Brush.Color:=clWhite;

        if Brush.Color<>clWhite then
          Rectangle(BaseLeft-CCellMargin, BaseTop-CCellMargin,
            BaseLeft-CCellMargin+Width div 4, BaseTop-CCellMargin+Height div 4);

        Font.Size:=CFontSize;
        //Font.Name:=CCanvasFont;
        Font.Style:=[fsBold];
        Twelves:=''; // 십이성들을 따로 빼내서 배치함.
        for J:=1 to Seong[I, 0] do
        begin
          T:=Seong[I, J];
          K:=(T mod 1000-1) mod 150 + 1;
          if K <= 30 then // 주성 + 길성 + 살성
          begin
            if (T mod 1000-1) div 150 + 1 > 1 then Font.Size:=CFontSize-1
            else Font.Size:=CFontSize;
            PrintOut(I, SeongFormat(T mod 10000))
          end
          else if K<=CSeongCount - 12*4 then
          begin
            Font.Size:=CFontSize-1;
            PrintOut(I, SeongFormat(T mod 10000)) // 십이성 이외의 잡성
          end
          else
          begin
            Content:=PSeongName^[(T mod 1000-1) mod 150 + 1];
            if Length(Content) div LengthChar = 4 then
              Twelves:=Twelves+Copy(Content, Length(Content)-LengthChar*2+1, 255)
            else Twelves:=Twelves+Content;
          end;

          if T >= 10000 then // 사화가 있는 경우
          begin
            Font.Size:=Trunc(CFontSize/5*4);
            //Font.Name:=CFixedFont;
            Dec(Top, CCellMargin-1);
            PrintOut(I, SeongFormat(T div 10000 * 10000), True);
            //Font.Name:=CCanvasFont;
          end;
        end;

        Font.Size:=CFontSize;
        Font.Style:=[];

	if I = Myeonggung then T:=clYellow else T:=-1;
        if SiganCount > 2 then
          tempstr:=Copy(PSahangName^[Sahang], 1, LengthChar)
        else
        begin
          tempstr:=PSahangName^[Sahang];
          if tempstr = '배우자' then tempstr:='부처';
        end;
        Content:=' ' + SeongColor(10000, 1, T) + tempstr;

        if I = Singung then
          Content:=Content + SeongColor(10000, 0, T) + '|'
                           + SeongColor(60000, 1, clYellow) + SingungMessage;

        for K:=1 to SiganCount do
	begin
	  tempstr:=SahangName[(I-IdxSigan[K]+12) mod 12];
	  if tempstr = '명궁' then T:=clYellow else T:=-1;
          if SiganCount > 2 then
            tempstr:=Copy(PSahangName^[(I-IdxSigan[K]+12) mod 12], 1, LengthChar)
          else
          begin
            tempstr:=PSahangName^[(I-IdxSigan[K]+12) mod 12];
            if tempstr = '배우자' then tempstr:='부처';
          end;
          Content:=Content + SeongColor(99999, 1) + ', '
                           + SeongColor((K+1)*10000, 1, T) + tempstr;
	end;
        FormattedTextOut(BaseLeft,
          BaseTop + Height div 4 - TextHeight('綠') - CCellMargin*3,
          Content);

        Font.Size:=CFontSize - 1;
        Font.Color:=clNavy;
        T:=BaseLeft + Width div 4 - TextWidth('가나') - CCellMargin*2;
        TextOut(T+TextWidth('가'),
          BaseTop+Height div 4 - TextHeight('綠')*2 - CCellMargin*4,
          Copy(Twelves, LengthChar*6+1, LengthChar));

        for J:=0 to 2 do
          TextOut(T, BaseTop+(CFontSize+CCellMargin*2)*J,
            Copy(Twelves, J*LengthChar*2+1, LengthChar*2));

        Font.Color:=clMaroon;
        if Seong[I, 0]*(Seong[I, 1] mod 100-15) >= 0 then
           Font.Style:=[fsStrikeOut]; // 공궁이면 스트라이크 표시
        TextOut(T, BaseTop+Height div 4 - TextHeight('綠') - CCellMargin*3,
          PGan^[CellCursor[I].GanNum]+PJi^[I]);
      end;
  end;

begin
  case LangType of
    0: begin
      PSahangName:=@SahangName;
      PNapeumName:=@NapeumName;
      POhaenggukName:=@OhaenggukName;
      PBrightnessName:=@BrightnessName;
      PSahwaName:=@SahwaName;
      PSeongName:=@SeongName;
      PSiganStr:=@SiganStr;
      PGan:=@ganK;
      PJi:=@jiK;
      //PGanji:=@ganjiK;
      GukMessage:='국';
      SingungMessage:='신';
      JojasiMessage:='조';
      YajasiMessage:='야';
    end;
    1: begin
      PSahangName:=@SahangNameC;
      PNapeumName:=@NapeumNameC;
      POhaenggukName:=@OhaenggukNameC;
      PBrightnessName:=@BrightnessNameC;
      PSahwaName:=@SahwaNameC;
      PSeongName:=@SeongNameC;
      PSiganStr:=@SiganStrC;
      PGan:=@gan;
      PJi:=@ji;
      //PGanji:=@ganji;
      GukMessage:='局';
      SingungMessage:='身';
      JojasiMessage:='朝';
      YajasiMessage:='夜';
    end;
  end;

  with Image1.Canvas do
  begin
    Brush.Color:=clWhite;
    Clear;
    DrawLine;

    with JamiCells do
    begin
      ResetCell(12);
      Font.Size:=CFontSize;
      Font.Style:=[];
      tempstr:='';

      for I:=1 to SiganCount do
        case I of
          1: tempstr:=tempstr + tgbxDaehan.Caption + '세';
          2: tempstr:=tempstr + ', ' + tgbxYunyeon.Caption;
          3: tempstr:=tempstr + ', ' + tgbxYuwol.Caption;
          4: tempstr:=tempstr + ', ' + tgbxYuil.Caption;
        end;

      // 기본정보 출력
      AddItem(12); AddItem(12);
      if SiganCount = 0 then AddItem(12);
      PrintOut(12, '   ' + SeongColor(9999, 1) + Format('%s - %s %s, %s, %s',
        [edtName.Text, cmbYeokbeop.Text, meBirth.Text, cmbSex.Text, cmbBan.Text]));

      // 선택시점 출력
      PrintOut(12, '   ' + SeongColor(30, 0) + tempstr);
      AddItem(12);

      // 날짜 정보 등 출력
      ResetCell(12);
      Font.Size:=CFontSize;
      Font.Color:=clBlack;

      AddItem(12, pnlControl.Height+CCellMargin);

      DecodeDate(Date, twYear, twMonth, twDay);
      ThisSolarYear:=twYear;
      ThisSolarMonth:=twMonth;
      ThisSolarDay:=twDay;

      solortolunar(ThisSolarYear, ThisSolarMonth, ThisSolarDay, ThisLunarYear, ThisLunarMonth, ThisLunarDay, ThisLunarYundal, LargeMonth);
      if ThisLunarYundal then tempstr:='윤달' else tempstr:='';
      PrintOut(12, Format(' 오늘: %d.%d.%d. %s',
        [ThisSolarYear, ThisSolarMonth, ThisSolarDay,
         weekday[getweekday(ThisSolarYear, ThisSolarMonth, ThisSolarDay)]]));
      PrintOut(12, Format(' 오늘: %d.%d.%d. (음력%s)',
        [ThisLunarYear, ThisLunarMonth, ThisLunarDay, tempstr]));

      GetTimeFromText(tYear, tMonth, tDay, tHour, tMinute);

      if (riNew in RedrawInfo) or (riNewSigan in RedrawInfo) then
      begin
        ConfigTime(cmbYeokbeop.ItemIndex,
          tYear, tMonth, tDay, tHour, tMinute,
          cmbSex.ItemIndex, cmbBan.ItemIndex, Yajasi);
      end;

      if riNewSigan in RedrawInfo then
        SetSigan(SiganCount, Sigan, IdxSigan);

      AddItem(12, 5);

      PrintOut(12, Format(' 앙력: %d.%d.%d. %s',
                   [sYear, sMonth, sDay, weekday[getweekday(sYear, sMonth, sDay)]]));

      if lYun then tempstr:='(윤달)' else tempstr:='';
      PrintOut(12, Format(' 음력: %d.%d.%d. %s', [lYear, lMonth, lDay, tempstr]));

      if SummerTime then tempstr:=', 서머타임' else tempstr:='';
      PrintOut(12, Format(' 동경 %0.1f도' + tempstr, [StandardTime]));
      PrintOut(12, Format(' 균시차: %0.1f분', [EOT]));
      AddItem(12, 5);

      Age:=ThisLunarYear-lYear+1;
      I:=CellCursor[Myeonggung].GanNum;
      PrintOut(12, Format(' %s%d%s, %s, 현재 %d세',
        [POhaenggukName^[Ohaengguk], Ohaengguk, GukMessage,
         PNapeumName^[((I-Myeonggung+12) mod 12 div 2*10+I) div 2],
         ThisSolarYear-sYear+1]));
      PrintOut(12, ' 명주: ' + PSeongName^[Myeongju] +
                   ', 신주: ' + PSeongName^[Sinju]);

      AddItem(12, 5);
      if SiganCount = 4 then
      begin
        lunartosolar(Sigan[2]+lYear-1, Sigan[3], Sigan[4], False, tiYear, tiMonth, tiDay);
        PrintOut(12, Format(' 선택일: %d.%d.%d. (양력)', [tiYear, tiMonth, tiDay]), True);
      end;

      // 사주 출력
      Font.Size:=20;

      CellCursor[12].Left:=Memo1.Left+CCellMargin*2;
      CellCursor[12].Top:=Memo1.Top+CCellMargin;

      PrintOut(12, ' ' + PGan^[mHour mod 10] + '   ' + PGan^[mDay mod 10] + '   '
                 + PGan^[mMonth mod 10] + '   ' + PGan^[mYear mod 10]);
      PrintOut(12, ' ' + PJi^[mHour mod 12] + '   ' + PJi^[mDay mod 12] + '   '
                 + PJi^[mMonth mod 12] + '   ' + PJi^[mYear mod 12]);

      // 조자시/야자시 버튼 출력
      Font.Color:=clRed;
      Font.Size:=CFontSize-1;
      T:=TextHeight(' ');
      with tgbxYajasi do
        if ((oHour = 23) and (oMinute >= 30)) or
           ((oHour = 0) and (oMinute < 30)) then
        begin
          Left:=CellCursor[12].Left-Width+T;
          Top:=CellCursor[12].Top-Height;
          if Yajasi then
          begin
            Caption:=YajasiMessage;
            State:=cbChecked;
          end
          else
          begin
            Caption:=JojasiMessage;
            State:=cbUnchecked;
          end;

          tempstr:=Caption;
          TextOut(Left+Width-TextWidth(tempstr)-CCellMargin,
            Top+Height-TextHeight(tempstr)-CCellMargin,
            tempstr);
          Visible:=True;
          SendToBack;
        end
        else Visible:=False;

      // 대운 정립
      SolortoSo24(sYear, sMonth, sDay, tHour, tMinute,
         preName, preYear, preMonth, preDay, preHour, preMin,
         midName, midYear, midMonth, midDay, midHour, midMin,
         postName, postYear, postMonth, postDay, postHour, postMin);

      // 양·음/남·여의 판별은 자미두수와 다르므로 .Sign 변수를 써서는 안 됨
      if (mYear mod 2) xor cmbSex.ItemIndex = 0 then // 양남, 음녀일 경우
      begin
        mSign:=1;
        Daeun:=-disp2days(sYear, sMonth, sDay, postYear, postMonth, postDay);
      end
      else // 음남, 양녀일 경우
      begin
        mSign:=-1;
        Daeun:=disp2days(sYear, sMonth, sDay, preYear, preMonth, preDay);
      end;
      if Daeun mod 3 = 2 then Daeun:=Daeun div 3 + 1
      else Daeun:=Daeun div 3;

      // Daeun:=Daeun mod 10;
      // if Daeun = 0 then Daeun:=10;
      Font.Size:=10;
      Font.Name:=CFixedFont;
      Font.Color:=clBlack;
      AddItem(12);
      tempstr:=' ';
      for I:=8 downto 0 do // 대운수 출력
        tempstr:=tempstr + ' ' + IntToStr(Daeun+I*10);
      PrintOut(12, tempstr);

      tempstr:='';
      for I:=1 to 9 do // 대운의 천간 출력
        tempstr:=' ' + PGan^[(mMonth+I*mSign+10) mod 10] + tempstr;
      PrintOut(12, ' ' + tempstr);

      tempstr:='';
      for I:=1 to 9 do // 대운의 지지 출력
        tempstr:=' ' + PJi^[(mMonth+I*mSign+12) mod 12] + tempstr;
      PrintOut(12, ' ' + tempstr);

      // 프로그램 정보 출력
      Font.Name:=CCanvasFont;

      tempstr:='ver ' + CProjectVersion;
      with CellCursor[12] do
      begin
        //CheckBox1.Left:=BaseLeft + Width div 4;
        //CheckBox1.Top:=Top;

        TextOut(BaseLeft + Width div 4,
          BaseTop+Height div 2 - TextHeight('綠')*2 - CCellMargin*3,
          CWebsite);
        TextOut(CellCursor[11].BaseLeft - TextWidth(tempstr) - CCellMargin*3,
          BaseTop+Height div 2 - TextHeight('綠') - CCellMargin*3,
          tempstr);
      end;

      // 기본적으로 명궁의 삼방사정이 선택되어 있게 함
      if SambangSajeong = [] then
      begin
        SambangSajeong:=[(Myeonggung+4) mod 12, (Myeonggung+6) mod 12, (Myeonggung+8) mod 12];
        Bongung:=Myeonggung;
      end;
    end;

    ArrangeGung;
    btnImage.Hint:='''' + GetImageName + '''로 저장';

    // 글꼴 설정 초기화
    Font.Name:=CCanvasFont;
    Font.Size:=CFontSize;
    Font.Color:=clBlack;
    Font.Style:=[];
  end;
end;

procedure TForm1.SelectionMessage(Index: Integer; Content: string; BkColor: TColor = clYellow; BottomLine: Integer = 3);
begin
  Index:=(Index+120) mod 12;
  with Image1.Canvas, JamiCells.CellCursor[Index] do
    ShowInfo(BaseLeft+(Width div 4 - TextWidth(Content)) div 2,
      BaseTop + Height div 4 - TextHeight(Content)*BottomLine, Content, BkColor);
end;

procedure TForm1.ShowInfo(X, Y: Integer; Content: string; BkColor: TColor = clYellow);
begin
  with Image1.Canvas do
  begin
    Brush.Color:=BkColor;
    Pen.Color:=clBlack;

    TextOut(X, Y, Content);

    Brush.Color:=clWhite;;
  end;
end;

procedure TForm1.SetTimeToText(const Year, Month, Day, Hour, Minute: Integer);
begin
  meBirth.Text:=Format('%.4d.%.2d.%.2d. %.2d:%.2d', [Year, Month, Day, Hour, Minute]);
end;

procedure ScaleDPI(Control: TControl; FromDPI: integer);
var
  i: integer;
  WinControl: TWinControl;
begin
  if Screen.PixelsPerInch = FromDPI then
    exit;

  with Control do
  begin
    Left := ScaleX(Left, FromDPI);
    Top := ScaleY(Top, FromDPI);
    Width := ScaleX(Width, FromDPI);
    Height := ScaleY(Height, FromDPI);
  end;

  if Control is TWinControl then
  begin
    WinControl := TWinControl(Control);
    if WinControl.ControlCount = 0 then
      exit;
    for i := 0 to WinControl.ControlCount - 1 do
      ScaleDPI(WinControl.Controls[i], FromDPI);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  temp: Word;
begin
  ScaleDPI(Self, 96);

  SiganCount:=0;
  LangType:=0;
  LengthChar:=Length('가');
  SambangSajeong:=[];
  tgbxDaehan.State:=cbUnchecked;
  tgbxDaehanChange(nil);
  edtSajuFinderKeyUp(Sender, temp, []);

  with Image1.Canvas do
  begin
    Font.Size:=CFontSize;
    Font.Style:=[fsBold];
    Font.Name:=CCanvasFont;

    JamiCells:=TJamiCells.Create(CFontSize, TextWidth('가나다라'), CCellMargin,
                                            Image1.Width, Image1.Height);

    DoubleBuffered:=True;
  end;

  FoundName:='';
  pnlControl.Left:=JamiCells.CellCursor[12].BaseLeft;
  pnlControl.Top:=JamiCells.CellCursor[12].BaseTop;
  meBirth.Text:=FormatDateTime('yyyy.mm.dd. hh:nn', Now);
  pnlList.Left:=pnlControl.Left;
  pnlList.Top:=pnlControl.Top+pnlControl.Height;
  pnlPreferences.Left:=pnlList.Left;
  pnlPreferences.Top:=pnlList.Top;
  Memo1.Left:=pnlControl.Left + pnlControl.Width - Memo1.Width;
  Memo1.Top:=pnlList.Top;
  pnlChartFinder.Left:=pnlControl.Left+tgbxChartFinder.Left;
  pnlChartFinder.Top:=pnlControl.Top+pnlControl.Height;
  pnlSajuFinder.Left:=Memo1.Left;
  pnlSajuFinder.Top:=pnlList.Top;
  PrevListSel:=-1;

  Redraw([riNew]);

  Clients:=TClients.Create;
  with Clients do
  begin
    if Count > 0 then
      for temp:=0 to Count-1 do
        lstList.Items.Add(ClientInfo[temp].Name);
    if ReadOnly then
    begin
      Form1.Caption:=Form1.Caption + ' <읽기전용>';
      btnListAdd.Enabled:=False;
    end;
  end;

  //CheckUpdates;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  meBirth.SetFocus;
end;

procedure TForm1.SetDaehan(Value: Integer);
// Value는 대한의 순서. 0대한, 1대한..
begin
  if Value < 0 then Value:=0;

  with tgbxDaehan, JamiCells do
  begin
    Sigan[1]:=Value;
    IdxSigan[1]:=(Sign*Value+Myeonggung+12) mod 12;
    SiganCount:=1;

    State:=cbChecked;
    Font.Style:=[fsBold];
    Caption:=Format('대한: %d~%d', [Value*10+Ohaengguk, (Value+1)*10+Ohaengguk-1]);
    btnAC.Enabled:=True;

    if (Value = 0) and (Age < Ohaengguk) then
      Sigan[1]:=-1; // 없으면 시작하자마자 유월 이하 버튼 클릭시 크래쉬 남.
  end;
end;

procedure TForm1.SetYunyeon(Value: Integer);
// Value는 유년궁의 번호. 자궁부터 해궁까지 0~11번
var
  T: Double;
begin
  Value:=Value mod 12;

  with tgbxYunyeon, JamiCells do
  begin
    if Sigan[1] = -99 then SetDaehan((Age-Ohaengguk) div 10);

    T:=((Sigan[1]*10+Ohaengguk-1)-(Value-Year mod 12))/12;
    if Frac(T) <> 0 then T:=T+1;

    IdxSigan[2]:=Value;
    Inc(Value, -Year mod 12+12*Trunc(T)+1);
    if (Value-(Sigan[1]*10+Ohaengguk) > 9) or
       ((Sigan[1] = -1) and (Value >= Ohaengguk)) then
      Exit;

    Sigan[2]:=Value;
    SiganCount:=2;
    Font.Style:=[fsBold];
    Caption:=Format('유년: %d세', [Value]);

    State:=cbChecked;
    tgbxYuwol.Enabled:=True;
  end;
end;

procedure TForm1.SetYuwol(Value: Integer);
// Value는 유월궁의 번호. 자궁부터 해궁까지 0~11번
begin
  Value:=Value mod 12;

  with tgbxYuwol, JamiCells do
  begin
    // 유년이 선택되어 있지 않다면
    if Sigan[2] = -99 then SetYunyeon(Year mod 12 + Age - 1);

    Sigan[3]:=(Value-(IdxSigan[2]-Month+Hour mod 12+1)+24) mod 12+1;
    IdxSigan[3]:=Value;
    SiganCount:=3;

    Font.Style:=[fsBold];
    Caption:=Format('유월: 음%d월', [Sigan[3]]);

    State:=cbChecked;
    tgbxYuil.Enabled:=True;
  end;
end;

procedure TForm1.SetYuil(Value: Integer);
// Value는 유일궁의 번호. 자궁부터 해궁까지 0~11번
var
  T: Integer;
begin
  Value:=Value mod 12;

  with tgbxYuil, JamiCells do
  begin
    if Sigan[3] = -99 then
    begin
      if Sigan[2] = -99 then SetYunyeon(Year mod 12 + Age - 1);

      SetYuwol(ThisLunarMonth+IdxSigan[2]-Month+Hour mod 12);
    end;

    IdxSigan[4]:=Value;
    SiganCount:=4;

    Value:=12*DayButtonCount+(Value-IdxSigan[3]+12) mod 12+1;
    Sigan[4]:=Value;

    if IsLunarLargeMonth(Sigan[2]+lYear-1, Sigan[3]) then T:=0 else T:=1;

    if Value<31-T then
    begin
      Font.Style:=[fsBold];
      Caption:=Format('유일: 음%d일', [Value]);
      Hint:='다시 클릭하면 날짜 재선택(F4)';
    end
    else
    begin
      DayButtonChecked:=False;
      tgbxYuil.State:=cbUnchecked;
      tgbxYuilChange(nil);
    end;
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  ClickArea: array[0..3, 0..3] of Integer =
    ((5,  6,  7, 8),
     (4, -1, -1, 9),
     (3, -1, -1, 10),
     (2,  1,  0, 11));
var
  T: Integer;
begin
  with Image1.Canvas, JamiCells do
  begin
    T:=ClickArea[Y div (Height div 4), X div (Width div 4)];
    if T>=0 then // 각 궁을 클릭했을 때
    begin
      case SelectGung of
        // 1 ~ 4: 유성 설정
        1: SetDaehan((Sign*(T - Myeonggung) + 12) mod 12);
        2: SetYunyeon(T);
        3: SetYuwol(T);
        4: SetYuil(T);
        // 5 ~ 10: 명반으로 찾기
        5: begin
          CFJwabo:=T;
          SelectionMessage(T, '좌보', clAqua, 7);
        end;
        6: begin
          CFJigong:=T;
          SelectionMessage(T, '지공', clFuchsia, 6);
        end;
        7: begin
          CFSamtae:=T;
          SelectionMessage(T, '삼태', clYellow, 5);
        end;
        8: begin
          CFJami:=T;
          SelectionMessage(T, '자미', clSilver, 4);
        end;
        9: begin
          CFSungong:=T;
          SelectionMessage(T, '순공', clLime);
        end;
        10: begin
          CFCheongong:=T;
          SelectionMessage(T, '천공', clSkyBlue, 2);
        end;
      end;

      SambangSajeong:=[(T+4) mod 12, (T+6) mod 12, (T+8) mod 12];
      Bongung:=T;

      if not tgbxChartFinder.Checked then
        if SelectGung = 0 then Redraw([], IsYajasi)
        else Redraw([riNewSigan], IsYajasi)
      else
        if (CFJwabo > -1) and (CFJigong > -1) and
           (CFSamtae > -1) and (CFJami > -1) and
           (CFSungong > -1) and (CFCheongong > -1) then
          ValidateChartFinder;

      SelectGung:=0;
    end;
  end;
end;

procedure TForm1.lstListSelectionChange(Sender: TObject; User: boolean);
begin
  if lstList.ItemIndex = -1 then
  begin
    btnListDelete.Enabled:=False;
    btnListUpward.Enabled:=False;
    btnListDownward.Enabled:=False;
    btnListUpdate.Enabled:=False;
    Memo1.Enabled:=False;
    PrevListSel:=-1;
    Exit;
  end;

  with Clients.ClientInfo[lstList.ItemIndex] do
  begin
    cmbYeokbeop.ItemIndex:=Yeokbeop;
    cmbSex.ItemIndex:=Sex;
    cmbBan.ItemIndex:=Ban;
    edtName.Text:=Name;
    meBirth.Text:=Birth;
    if PrevListSel > -1 then
      Clients.Edit(PrevListSel, TStringList(Memo1.Lines));
    if Memo <> nil then Memo1.Lines.Assign(Memo)
    else Memo1.Clear;

    PrevListSel:=lstList.ItemIndex;
    btnDisplayClick(Sender);
  end;

  if not Clients.ReadOnly then
  begin
    btnListDelete.Enabled:=True;
    btnListUpward.Enabled:=True;
    btnListDownward.Enabled:=True;
    btnListUpdate.Enabled:=True;
    Memo1.Enabled:=True;
  end;
end;

procedure TForm1.lstSajuFinderDblClick(Sender: TObject);
begin
  with lstSajuFinder do
    if ItemIndex > 0 then
    begin
      InitSigan;
      meBirth.Text:=Items[ItemIndex];
      tgbxSajuFinder.Checked:=False;
      cmbYeokbeop.ItemIndex:=0;
    end;
end;

procedure TForm1.meBirthChange(Sender: TObject);
var
  I: Integer;
begin
  with meBirth do
  begin
    OnChange:=nil;
    for I:=1 to 10 do
      if Text[I] = ' ' then
        Text:=StuffString(Text, I, 1, '0');

    for I:=13 to 17 do
      if Text[I] = ' ' then
        Text:=StuffString(Text, I, 1, '0');
    OnChange:=@meBirthChange;
  end;
end;

procedure TForm1.meBirthKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_BACK) and tgbxNyeonju.Checked and (meBirth.CaretPos.x = 6) then
    edtNyeonju.SetFocus
  else if Key = VK_ESCAPE then
    Key:=0;
end;

procedure TForm1.meBirthKeyPress(Sender: TObject; var Key: char);
begin
  cmbHour.ItemIndex:=0;
  tgbxDaehan.Enabled:=False;
  tgbxYunyeon.Enabled:=False;
  tgbxYuwol.Enabled:=False;
  tgbxYuil.Enabled:=False;
  btnAC.Enabled:=False;
end;

procedure TForm1.Memo1Exit(Sender: TObject);
begin
  if lstList.ItemIndex > -1 then
    Clients.Edit(lstList.ItemIndex, TStringList(Memo1.Lines));
end;

procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if lstList.ItemIndex > -1 then
    btnSave.Enabled:=True;
end;

procedure TForm1.tgbxChartFinderChange(Sender: TObject);
begin
  if tgbxChartFinder.Checked then // 활성화됨
  begin
    tgbxSajuFinder.Checked:=False;
    tgbxList.Checked:=False;

    Image1.Canvas.Brush.Color:=clWhite;
    Image1.Canvas.Clear;
    DrawLine;

    pnlChartFinder.Visible:=True;
    CFJwabo:=-1;
    CFJigong:=-1;
    CFSamtae:=-1;
    CFJami:=-1;
    CFSungong:=-1;
    CFCheongong:=-1;

    tgbxChartFinderJwabo.Checked:=False;
    tgbxChartFinderJigong.Checked:=False;
    tgbxChartFinderSamtae.Checked:=False;
    tgbxChartFinderJami.Checked:=False;
    tgbxChartFinderSungong.Checked:=False;
    tgbxChartFinderCheongong.Checked:=False;
    btnChartFinderResult.Enabled:=False;
  end
  else // 비활성화됨
  begin
    pnlChartFinder.Visible:=False;
    Redraw([], JamiCells.IsYajasi);
  end;
end;

procedure TForm1.tgbxChartFinderCheongongChange(Sender: TObject);
begin
  if tgbxChartFinderCheongong.Checked then SelectGung:=10
  else
  begin
    SelectGung:=0;
    if CFCheongong <> -1 then
      SelectionMessage(CFCheongong, '      ', clWhite, 2);
    CFCheongong:=-1;
  end;
end;

procedure TForm1.tgbxChartFinderSamtaeChange(Sender: TObject);
begin
  if tgbxChartFinderSamtae.Checked then SelectGung:=7
  else
  begin
    SelectGung:=0;
    if CFSamtae <> -1 then
      SelectionMessage(CFSamtae, '      ', clWhite, 5);
    CFSamtae:=-1;
  end;
end;

procedure TForm1.tgbxChartFinderSungongChange(Sender: TObject);
begin
  if tgbxChartFinderSungong.Checked then SelectGung:=9
  else
  begin
    SelectGung:=0;
    if CFSungong <> -1 then
      SelectionMessage(CFSungong, '      ', clWhite);
    CFSungong:=-1;
  end;
end;

procedure TForm1.tgbxChartFinderJamiChange(Sender: TObject);
begin
  if tgbxChartFinderJami.Checked then SelectGung:=8
  else
  begin
    SelectGung:=0;
    if CFJami <> -1 then
      SelectionMessage(CFJami, '      ', clWhite, 4);
    CFJami:=-1;
  end;
end;

procedure TForm1.tgbxChartFinderJwaboChange(Sender: TObject);
begin
  if tgbxChartFinderJwabo.Checked then SelectGung:=5
  else
  begin
    SelectGung:=0;
    if CFJwabo <> -1 then
      SelectionMessage(CFJwabo, '      ', clWhite, 7);
    CFJwabo:=-1;
  end;
end;

procedure TForm1.tgbxChartFinderJigongChange(Sender: TObject);
begin
  if tgbxChartFinderJigong.Checked then SelectGung:=6
  else
  begin
    SelectGung:=0;
    if CFJigong <> -1 then
      SelectionMessage(CFJigong, '      ', clWhite, 6);
    CFJigong:=-1;
  end;
end;

procedure TForm1.tgbxDaehanChange(Sender: TObject);
var
  I: Integer;
begin
  with tgbxDaehan, JamiCells do
    if Checked then
    begin
      SelectGung:=1;

      Redraw([], IsYajasi);
      for I:=0 to 11 do
        SelectionMessage(Myeonggung+Sign*I,
          Format('%d~%d세, %d~%d년', [Ohaengguk+10*I, Ohaengguk+10*(I+1)-1,
                     Ohaengguk+10*I+lYear-1, Ohaengguk+10*(I+1)-1+lYear-1]));
    end
    else
    begin
      Font.Style:=[];
      Caption:='대한 선택';
      Sigan[1]:=-99;

      tgbxYunyeon.State:=cbUnchecked;
      tgbxYunyeonChange(nil);
      SiganCount:=0;

      if Sender <> nil then
        Redraw([riNewSigan], IsYajasi);
    end;
end;

procedure TForm1.tgbxMemoClick(Sender: TObject);
begin
  Memo1.Visible:=tgbxMemo.Checked;

  if tgbxMemo.Checked then
  begin
    tgbxChartFinder.Checked:=False;
    tgbxSajuFinder.Checked:=False;
  end;
end;

procedure TForm1.tgbxSajuFinderClick(Sender: TObject);
begin
  pnlSajuFinder.Visible:=tgbxSajuFinder.Checked;
  if tgbxSajuFinder.Checked then
  begin
    edtSajuFinder.SetFocus;
    tgbxList.Checked:=False;
    tgbxChartFinder.Checked:=False;
  end
  else meBirth.SetFocus;
end;

procedure TForm1.tgbxYajasiChange(Sender: TObject);
begin
  SambangSajeong:=[];
  tgbxDaehan.State:=cbUnchecked;
  tgbxDaehanChange(nil);

  with tgbxYajasi do
    if Checked then
      Redraw([riNew], True)
    else
      Redraw([riNew], False);
end;

procedure TForm1.tgbxYunyeonChange(Sender: TObject);
var
  I, T, T2: Integer;
begin
  with tgbxYunyeon, JamiCells do
    if Checked then
    begin
      if Sigan[1] = -99 then SetDaehan((Age-Ohaengguk) div 10);

      Redraw([], IsYajasi);
      SelectGung:=2;
      T:=Sigan[1]*10+Ohaengguk;
      if T<0 then T2:=T+1 else T2:=0;
      for I:=T2 to 9 do
        if T+I > 0 then
          SelectionMessage(T+I+Year mod 12-1,
            Format('%d세, %d년', [T+I, lYear+T+I-1]));
    end
    else
    begin
      Font.Style:=[];
      Caption:='유년 선택';
      Sigan[2]:=-99;

      tgbxYuwol.State:=cbUnchecked;
      tgbxYuwolChange(nil);
      SiganCount:=1;

      if Sender <> nil then
        Redraw([riNewSigan], IsYajasi);
    end;
end;

procedure TForm1.tgbxYuwolChange(Sender: TObject);
var
  I: Integer;
  tempstr: string;
begin
  with tgbxYuwol, JamiCells do
    if Checked then // 활성화되었을 때
    begin
      // 유년이 선택되지 않았을 때
      if Sigan[2] = -99 then SetYunyeon(Year mod 12 + Age - 1);

      SelectGung:=3;

      Redraw([], IsYajasi);
      // 전년도 음력 12월이 윤달인 경우 금년도 1월에도 윤달 표시를 해줘야 함
      if IsLunarLeapMonth(Sigan[2]+lYear-2, 12) then
        tempstr:=', 윤12월16일~끝'
      else if IsLunarLeapMonth(Sigan[2]+lYear-1, 1) then
        tempstr:=', 윤1월1~15일'
      else tempstr:='';

      SelectionMessage(1+IdxSigan[2]-Month+Hour mod 12, '1월'+tempstr);

      for I:=2 to 12 do
      begin
        if IsLunarLeapMonth(Sigan[2]+lYear-1, I) then // 윤달인 경우
          tempstr:=', 윤' + IntToStr(I) + '월1~15일'
        else if IsLunarLeapMonth(Sigan[2]+lYear-1, I-1) then // 전달이 윤달일 때
          tempstr:=', 윤' + IntToStr(I-1) + '월16일~끝'
        else tempstr:='';

        SelectionMessage(I+IdxSigan[2]-Month+Hour mod 12,
                         IntToStr(I)+'월'+tempstr);
      end;

      // 구체적으로 선택한 경우는 TForm1.Image1MouseDown에서 처리합니다
    end
    else // 비활성화됐을 때
    begin
      Font.Style:=[];
      Caption:='유월 선택';
      Sigan[3]:=-99;

      DayButtonChecked:=False;

      tgbxYuil.State:=cbUnchecked;
      tgbxYuilChange(nil);
      SiganCount:=2;

      if Sender <> nil then
        Redraw([riNewSigan], IsYajasi);
    end;
end;

procedure TForm1.tgbxYuilChange(Sender: TObject);
var
  I, T, T2: Integer;
begin
  with tgbxYuil, JamiCells do
    if Checked then
    begin
      if Sigan[3] = -99 then
      begin
        if Sigan[2] = -99 then SetYunyeon(Year mod 12 + Age - 1);

        SetYuwol(ThisLunarMonth+IdxSigan[2]-Month+Hour mod 12);
      end;

      SelectGung:=4;
      DayButtonChecked:=True;
      Font.Style:=[];
      Caption:='유일: x' + IntToStr(DayButtonCount);
      Hint:='다시 클릭하면 다음 날짜 표시(F4)';

      Redraw([], IsYajasi);
      for I:=0 to 11 do
      begin
        SelectionMessage(I+IdxSigan[3], '       ');
        SelectionMessage(I+IdxSigan[3], IntToStr(DayButtonCount*12+I+1)+'일');
      end;
    end
    else
      if DayButtonChecked then
      begin
        if Font.Style = [] then
          DayButtonCount:=(DayButtonCount+1) mod 3
        else Font.Style:=[];

        SelectGung:=4;
        Caption:='유일: x' + IntToStr(DayButtonCount);
        Hint:='다시 클릭하면 다음 날짜 표시(F4)';
        State:=cbChecked;

        if (DayButtonCount = 2) and
          IsLunarLargeMonth(Sigan[2]+lYear-1, Sigan[3]) then T2:=0
        else T2:=1;

        for I:=0 to 11 do
        begin
          T:=DayButtonCount*12+I+1;
          SelectionMessage(I+IdxSigan[3], '       ');
          if T<31-T2 then SelectionMessage(I+IdxSigan[3], IntToStr(T)+'일')
          else SelectionMessage(I+IdxSigan[3], '해제');
        end;
      end
      else
      begin
        Font.Style:=[];
        Caption:='유일 선택';
        Hint:='F4';
        Sigan[4]:=-99;
        SiganCount:=3;
        SelectGung:=0;
        DayButtonCount:=0;
        DayButtonChecked:=False;

        if Sender <> nil then
          Redraw([riNewSigan], IsYajasi);
      end;
end;

procedure TForm1.tgbxListChange(Sender: TObject);
begin
  pnlList.Visible:=tgbxList.Checked;
  tgbxMemo.Checked:=tgbxList.Checked;

  if tgbxList.Checked then
  begin
    tgbxChartFinder.Checked:=False;
    tgbxSajuFinder.Checked:=False;
  end;
end;

procedure TForm1.tgbxHanjaChange(Sender: TObject);
begin
  with tgbxHanja do
    if Checked then
    begin
      Caption:='漢字';
      LangType:=1;
    end
    else
    begin
      Caption:='한글';
      LangType:=0;
    end;

  Redraw([], JamiCells.IsYajasi);
end;

procedure TForm1.tgbxNyeonjuChange(Sender: TObject);
begin
  edtNyeonju.Visible:=tgbxNyeonju.Checked;

  if tgbxNyeonju.Checked then
  begin
    InitSigan;
    edtNyeonju.SetFocus;
    cmbYeokbeop.ItemIndex:=1;
  end;
end;

procedure TForm1.GetTimeFromText(var Year, Month, Day, Hour, Minute: Integer);
var
  tempstr: string;
begin
  tempstr:=meBirth.Text;

  Year:=StrToInt(Copy(tempstr, 1, 4));
  Month:=StrToInt(Copy(tempstr, 6, 2));
  Day:=StrToInt(Copy(tempstr, 9, 2));
  Hour:=StrToInt(Copy(tempstr, 13, 2));
  Minute:=StrToInt(Copy(tempstr, 16, 2));
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if btnSave.Enabled and
    (MessageDlg('저장 확인', '변경사항이 있습니다. 저장하시겠습니까?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    btnSaveClick(Sender);

  JamiCells.Free;
  Clients.Free;
end;

procedure TForm1.btnDisplayClick(Sender: TObject);
var
  Key: Word;
begin
  NewClient:=True;

  tgbxDaehan.Enabled:=True;
  tgbxYunyeon.Enabled:=True;
  tgbxYuwol.Enabled:=True;
  tgbxYuil.Enabled:=True;

  tgbxDaehan.State:=cbUnchecked;
  tgbxDaehanChange(nil);

  Caption:='자미두수명반 - ' + edtName.Text + '(' + cmbSex.Text + ')';
  if Clients.ReadOnly then Caption:=Caption + ' <읽기전용>';
  if cmbSex.ItemIndex = 0 then edtName.Color:=$00FBF5CE
  else edtName.Color:=$00FFD9FF;

  if tgbxNyeonju.Checked and (edtNyeonju.Color = clAqua) then
    edtNyeonjuKeyUp(Sender, Key, []); // 확인을 위해서 한 번 더 호출

  SambangSajeong:=[];
  if cmbHour.ItemIndex = 13 then
    Redraw([riNew, riNewSigan], True)
  else
    Redraw([riNew, riNewSigan], False);
end;

procedure TForm1.btnListAddClick(Sender: TObject);
var
  Info: TClientInfo;
  I: Integer;
begin
  with Info do
  begin
    Yeokbeop:=cmbYeokbeop.ItemIndex;
    Sex:=cmbSex.ItemIndex;
    Ban:=cmbBan.ItemIndex;
    Name:=edtName.Text;
    Birth:=meBirth.Text;
    Memo:=TStringList.Create;
    Clients.Add(Info);
    Memo.Free;
  end;

  with lstList do
  begin
    Items.Add(edtName.Text);
    Memo1.Clear;
    ItemIndex:=Count-1;
  end;

  btnSave.Enabled:=True;
end;

procedure TForm1.btnListDeleteClick(Sender: TObject);
var
  T: Integer;
begin
  with lstList do
  begin
    T:=ItemIndex;
    Clients.Delete(T);
    lstList.Items.Delete(T);
    btnSave.Enabled:=True;
    PrevListSel:=-1;
    if Count = 0 then
    begin
      btnListDelete.Enabled:=False;
      Memo1.Clear;
      Memo1.Enabled:=False;
      btnListUpward.Enabled:=False;
      btnListDownward.Enabled:=False;
    end
    else if T = Count then ItemIndex:=T-1
    else ItemIndex:=T;
  end;
end;

procedure TForm1.btnListDownwardClick(Sender: TObject);
var
  T: Integer;
  S: string;
begin
  T:=lstList.ItemIndex;
  if T < lstList.Count-1 then
    with lstList do
    begin
      Clients.Swap(T, T+1);
      S:=Items[T];
      Items[T]:=Items[T+1];
      Items[T+1]:=S;
      PrevListSel:=T+1;
      ItemIndex:=T+1;
    end;

  btnSave.Enabled:=True;
end;

procedure TForm1.btnListFindClick(Sender: TObject);
var
  I: Integer;
begin
  FoundName:=InputBox('찾기', '찾을 이름: (현재 선택된 명단 이후부터 찾습니다)', FoundName);

  if FoundName='' then Exit;
  with lstList do
    for I:=ItemIndex+1 to Count-1 do
      if Pos(FoundName, Items[I]) > 0 then
      begin
        ItemIndex:=I;
        Exit;
      end;

  ShowMessage('찾을 수 없습니다(명단의 끝).');
end;

procedure TForm1.btnListUpwardClick(Sender: TObject);
var
  T: Integer;
  S: string;
begin
  T:=lstList.ItemIndex;
  if T > 0 then
    with lstList do
    begin
      Clients.Swap(T, T-1);
      S:=Items[T];
      Items[T]:=Items[T-1];
      Items[T-1]:=S;
      PrevListSel:=T-1;
      ItemIndex:=T-1;
    end;

  btnSave.Enabled:=True;
end;

procedure TForm1.btnChartFinderResultClick(Sender: TObject);
var
  Key: Word;
begin
  tgbxNyeonju.Checked:=True;
  edtNyeonju.Caption:=ganK[CFYearGan] + jiK[CFYearJi];
  edtNyeonjuKeyUp(nil, Key, []);
  meBirth.Text:=Copy(meBirth.Text, 1, 5) + Format('%2d.%2d. 11:11', [CFMonth, CFDay]);
  cmbHour.ItemIndex:=CFHourJi+1;
  cmbHourChange(nil);
  btnDisplayClick(nil);

  tgbxChartFinder.Checked:=False;
end;

procedure TForm1.actDaehanExecute(Sender: TObject);
begin
  tgbxDaehan.Checked:=not tgbxDaehan.Checked;
end;

procedure TForm1.actListExecute(Sender: TObject);
begin
  tgbxList.Checked:=not tgbxList.Checked;
end;

procedure TForm1.actSaveExecute(Sender: TObject);
begin
  btnSaveClick(nil);
end;

procedure TForm1.actYuilExecute(Sender: TObject);
begin
  tgbxYuil.Checked:=not tgbxYuil.Checked;
end;

procedure TForm1.actYunyeonExecute(Sender: TObject);
begin
  tgbxYunyeon.Checked:=not tgbxYunyeon.Checked;
end;

procedure TForm1.actYuwolExecute(Sender: TObject);
begin
  tgbxYuwol.Checked:=not tgbxYuwol.Checked;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  Clients.SaveFile;
  btnSave.Enabled:=False;
end;

procedure TForm1.btnImageClick(Sender: TObject);
begin
  Image1.Picture.SaveToFile(GetImageName, 'png');
end;

procedure TForm1.btnACClick(Sender: TObject);
begin
  SambangSajeong:=[];
  btnAC.Enabled:=False;
  tgbxDaehan.State:=cbUnchecked;
  tgbxDaehanChange(Sender);
end;

procedure TForm1.btnPrintClick(Sender: TObject);
begin
  if PrintDialog1.Execute then
    with Printer, Image1.Canvas do
    try
      BeginDoc;
      Canvas.CopyRect(Classes.Rect(100, 100, PaperSize.Width-100,
        Round((PaperSize.Width-100)/Width*Height)),
        Image1.Canvas, Classes.Rect(0, 0, Width, Height));
    finally
      EndDoc;
    end;
end;

procedure TForm1.btnListUpdateClick(Sender: TObject);
begin
  with Clients.ClientInfo[lstList.ItemIndex] do
  begin
    Yeokbeop:=cmbYeokbeop.ItemIndex;
    Sex:=cmbSex.ItemIndex;
    Ban:=cmbBan.ItemIndex;
    Name:=edtName.Text;
    Birth:=meBirth.Text;
    lstList.Items[lstList.ItemIndex]:=Name;
  end;

  btnSave.Enabled:=True;
end;

procedure TForm1.cmbSexChange(Sender: TObject);
begin
  InitSigan;
end;

procedure TForm1.cmbYeokbeopChange(Sender: TObject);
begin
  InitSigan;
end;

procedure TForm1.cmbHourChange(Sender: TObject);
var
  Year, Month, Day, Hour, Minute: Integer;
  StandardTime, EOT: Single;
  SummerTime: Boolean;
  Movement: Integer;
begin
  with cmbHour do
    if ItemIndex = 13 then // 야자시
    begin
      InitSigan;
      GetTimeFromText(Year, Month, Day, Hour, Minute);
      Hour:=23; Minute:=30;
      TimeAdjustment(Year, Month, Day, Hour, Minute, StandardTime, EOT, SummerTime, True);
      Movement:=Trunc(((135.0-StandardTime)/15*60-EOT)*2);
      if SummerTime then Inc(Movement, 120);
      MinuteAdjustedTime(Movement+1, Year, Month, Day, Hour, Minute);
      SetTimeToText(Year, Month, Day, Hour, Minute);
    end
    else if ItemIndex > 0 then
    begin
      InitSigan;
      GetTimeFromText(Year, Month, Day, Hour, Minute);
      Hour:=(ItemIndex-1)*2; Minute:=30;
      TimeAdjustment(Year, Month, Day, Hour, Minute, StandardTime, EOT, SummerTime);
      Movement:=Trunc(((StandardTime-135.0)/15*60-EOT)*2);
      if SummerTime then Inc(Movement, 120);
      MinuteAdjustedTime(Movement, Year, Month, Day, Hour, Minute);
      SetTimeToText(Year, Month, Day, Hour, Minute);
    end;
end;

procedure TForm1.cmbBanChange(Sender: TObject);
begin
  InitSigan;
end;

procedure TForm1.edtNyeonjuKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I, Year, Month, Day, Hour, Minute: Integer;
  Flag: Boolean;
begin
  with edtNyeonju do
    if Length(Text) div LengthChar = 2 then
    begin
      Flag:=False;
      for I:=0 to 59 do
        if ganjiK[I] = Text then
        begin
          Flag:=True;
          Break;
        end;

      if Flag then Color:=clAqua
      else
      begin
        Color:=clFuchsia;
        Exit;
      end;

      GetTimeFromText(Year, Month, Day, Hour, Minute);
      SetTimeToText(1924+I, Month, Day, Hour, Minute);
      meBirth.SetFocus;
      meBirth.SelStart:=5;
      meBirth.SelLength:=1;
    end
    else
      Color:=clFuchsia;
end;

procedure TForm1.edtSajuFinderKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  T: string;
  Flag: Boolean;
  I: Integer;
  Idx: array[1..4] of Integer;

  procedure Notice(Message: string);
  begin
    lstSajuFinder.Clear;
    lstSajuFinder.Items.Add(Message);
  end;

  procedure Seeking;
  var
    tY, tM, tD, tH, tMin, Multi,
    rY, rM, rD, rH,
    I, T: Integer;
    StandardTime, EOT: Single;
    SummerTime: Boolean;
  begin
    tY:=1984+Idx[1];
    if ThisSolarYear+60 > tY then
      Inc(tY, (ThisSolarYear+60 - tY) div 60*60);

    lstSajuFinder.Items.BeginUpdate;
    for I:=tY div 60 downto 0 do
    begin
      Dec(tY, 60);
      tM:=(Idx[2] + 11) mod 12+1;
      tD:=15; tH:=(Idx[4]*2) mod 24; tMin:=30;
      sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH);

      if rM = Idx[2] then
      else if (Idx[2]-rM+60) mod 60 <= 12 then
      begin
        tM:=(tM+(Idx[2]-rM+60) mod 60) mod 12;
        Inc(tY, (Idx[2]-rM+60) mod 60 div 12);
        sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH);
      end
      else if (rM-Idx[2]+60) mod 60 <= 12 then
      begin
        tM:=(tM-(rM-Idx[2]+60) mod 60+12) mod 12;
        Dec(tY, (rM-Idx[2]+60) mod 60 div 12);
        sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH);
      end
      else Continue;

      if rY <> Idx[1] then Continue;

      if rD = Idx[3] then
      else if (rD-Idx[3]+60) mod 60 <= 31 then
      begin
        MinuteAdjustedTime(-(rD-Idx[3]+60) mod 60*60*24, tY, tM, tD, tH, tMin);
        sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH)
      end
      else if (Idx[3]-rD+60) mod 60 <= 31 then
      begin
        MinuteAdjustedTime((Idx[3]-rD+60) mod 60*60*24, tY, tM, tD, tH, tMin);
        sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH)
      end
      else Continue;

      if (rY <> Idx[1]) or (rM <> Idx[2]) then Continue;

      if rH = Idx[4] then
      else if (rH-Idx[4]+60) mod 60 <= 24 then
      begin
        MinuteAdjustedTime(-(rH-Idx[4]+60) mod 60*60*2, tY, tM, tD, tH, tMin);
        sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH);
      end
      else if (Idx[4]-rH+60) mod 60 <= 24 then
      begin
        MinuteAdjustedTime((Idx[4]-rH+60) mod 60*60*2, tY, tM, tD, tH, tMin);
        sydtoso24yd(tY, tM, tD, tH, tMin, Multi, rY, rM, rD, rH);
      end
      else Continue;

      if (rY <> Idx[1]) or (rM <> Idx[2]) then Continue;
      if ((Idx[3]+1) mod 60 = rD) then // 야자시
      else if (rD <> Idx[3]) then Continue;

      rY:=tY;
      rM:=tM;
      rD:=tD;
      rH:=tH;
      T:=tMin;

      TimeAdjustment(rY, rM, rD, rH, T, StandardTime, EOT, SummerTime);
      if SummerTime then T:=60 else T:=0;
      MinuteAdjustedTime(Trunc((StandardTime-135.0)/15*60-EOT-1)+T,
        tY, tD, tM, tH, tMin);
      lstSajuFinder.Items.Add(Format('%.4d.%.2d.%.2d. %.2d:%.2d',
        [tY, tM, tD, tH, tMin]));
    end;
    lstSajuFinder.Items.EndUpdate;
  end;

begin
  with edtSajuFinder do
    if Length(Text) < LengthChar * 2 then Notice('년주 입력(예: 갑자)')
    else
    begin
      T:=Copy(Text, 1, LengthChar*2);
      Flag:=True;
      for I:=0 to 59 do
        if T = ganjiK[I] then
        begin
          Flag:=False;
          Idx[1]:=I;
          Break;
        end;

      if Flag then Notice('년주 입력(예: 갑자)')
      else if Length(Text) < LengthChar * 4 then Notice('월주 입력(예: 갑술)')
      else
      begin
        T:=Copy(Text, LengthChar*2+1, LengthChar*2);
        Flag:=True;
        for I:=0 to 59 do
          if T = ganjiK[I] then
          begin
            Flag:=False;
            Idx[2]:=I;
            Break;
          end;
        if Flag then Notice('월주 입력(예: 갑술)')
        else if Length(Text) < LengthChar * 6 then Notice('일주 입력(예: 갑신)')
        else
        begin
          T:=Copy(Text, LengthChar*4+1, LengthChar*2);
          Flag:=True;
          for I:=0 to 59 do
            if T = ganjiK[I] then
            begin
              Flag:=False;
              Idx[3]:=I;
              Break;
            end;
          if Flag then Notice('일주 입력(예: 갑신)')
          else if Length(Text) < LengthChar * 8 then Notice('시주 입력(예: 갑자)')
          else if Length(Text) = LengthChar * 8 then
          begin
            Notice('시주 입력(예: 갑자)');

            T:=Copy(Text, LengthChar*6+1, LengthChar*2);
            Flag:=True;
            if Length(T) = LengthChar*2 then
              for I:=0 to 59 do
                if T = ganjiK[I] then
                begin
                  Flag:=False;
                  Idx[4]:=I;
                  Break;
                end;

            if Flag then Notice('시주 입력(예: 갑자)')
            else
            begin
              Notice('아래중 선택하세요.');
              Seeking;
            end;
          end;
        end;
      end;
    end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin

end;

procedure TForm1.InitSigan;
begin
  tgbxDaehan.Enabled:=False;
  tgbxYunyeon.Enabled:=False;
  tgbxYuwol.Enabled:=False;
  tgbxYuil.Enabled:=False;
  btnAC.Enabled:=False;
end;

procedure TForm1.ValidateChartFinder;
var
  tMyeonggungJi, tMyeonggungGan, tOhaengguk,
  J, T: Integer;
  Valid: Boolean = False;
begin
  CFMonth:=(CFJwabo - 4 + 12) mod 12 + 1;
  CFHourJi:=11 - CFJigong;
  CFYearJi:=(CFCheongong - 1 + 12) mod 12;

  // 순중공망 자리에 년지가 있으면 잘못된 입력
  if CFSungong div 2 <> CFYearJi div 2 then
  begin
    CFYearGan:=(CFYearJi - (CFSungong div 2+1)*2 + 12) mod 12 mod 10;

    CFDay:=(CFSamtae - CFJwabo + 12) mod 12 + 1;

    tMyeonggungJi:=(1 + CFMonth - CFHourJi + 12) mod 12;
    tMyeonggungGan:=((2+CFYearGan mod 5*2) mod 10+(tMyeonggungJi-2 + 12) mod 12) mod 10;
    tOhaengguk:=Ohaengguksu[(tMyeonggungGan div 2 + tMyeonggungJi div 2 mod 3) mod 5];

    repeat
      T:=CFDay div tOhaengguk; // T는 몫수
      if CFDay mod tOhaengguk <> 0 then Inc(T);
      J:=tOhaengguk * T - CFDay; // J는 보수

      if odd(J) then T:=T - J + 12
      else T:=T + J;

      if (T+1) mod 12 = CFJami then // 자미의 위치와 일치한다면 바로 그때의 생일
      begin
        Valid:=True;
        Break;
      end;

      Inc(CFDay, 12);
    until CFDay>30;
  end;

  with btnChartFinderResult do
  begin
    Enabled:=Valid;
    if not Valid then Caption:='잘못된 입력'
    else Caption:='결과 입력';
  end;
end;

function TForm1.GetImageName: string;
var
  I: Integer;
begin
  Result:=cmbYeokbeop.Text;

  with JamiCells do
  begin
    if cmbYeokbeop.ItemIndex = 0 then
      Result:=Result + Format('%.4d%.2d%.2d', [sYear, sMonth, sDay])
    else
      Result:=Result + Format('%.4d%.2d%.2d', [lYear, lMonth, lDay]);

    if IsYajasi then
      Result:=Result + '야자시'
    else Result:=Result + jiK[mHour mod 12] + '시';

    Result:=Result + cmbSex.Text + cmbBan.Text;
    for I:=1 to SiganCount do
      case I of
        1: Result:=Result + '제' + IntToStr(Sigan[1]+1) + '대한';
        2: Result:=Result + IntToStr(Sigan[2]+lYear-1);
        else Result:=Result + Format('%.2d', [Sigan[I]]);
      end;
  end;

  Result:=edtName.Text + '-' + Result + '.png';
end;

procedure TForm1.CheckUpdates;
const
  CIndicator = '<meta property="og:title" content="자미두수 명반 프로그램입니다(';
var
  Body: string;
  P: Integer;
begin
  try
    Body:=TFPHTTPClient.SimpleGet(CRealSite);
    P:=Pos(CIndicator, Body);
    if P > 0 then
    begin
      Body:=Copy(Body, P+Length(CIndicator), 20);
      Delete(Body, Pos(')." />', Body), 20);
      if Body <> CProjectVersion then
        if MessageDlg('업데이트 확인', '현재 ' + Body + ' 버전이 최신입니다. 확인하시겠습니까?', mtConfirmation, mbYesNo, '') = mrYes then
          OpenURL(CRealSite);
    end;
  except
    on E:Exception do
      ShowMessage(E.Message);
  end;
end;

end.


