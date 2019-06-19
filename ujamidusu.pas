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

unit UJamidusu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  // 전체 별의 종류 수
  CSeongCount = 14 + 8 + 8 + 8 + 7 + 8 + 12 + 12 + 12 + 12 + 12;

type
  TCellCursor = record // 각 궁의 정보를 담는 구조체
    Left, Top, // 명반 출력시 쓰이는 현재 커서 위치
    BaseLeft,BaseTop, // 각 궁의 기본 위치
    MaxItem, // 각 궁에서 세로 한 줄에 들어갈 수 있는 최대 별 수
    GanNum: Integer; // 각 궁의 천간
    Sahang: Integer; // 각 궁의 사항궁
  end;

  TJamiCells = class
  public
    CellCursor: array[0..12] of TCellCursor; // 각 궁의 정보
    Seong: array[0..11, 0..50] of Integer; // 별 정보
    // Seong의 구조는 [x, 0]이 x번째 궁의 별 개수를 표시
    // 각 별에 관한 정보는 32비트 내에서 십진수와 이진수 정보의 합으로 표시함
    // 0~999: 별 번호.
    //  1~150-선천, 151~300-대한, 301~450-유년, 451~600-유월, 601~750-유일, 751~900-유시
    // 1000, 2000, 3000, 4000, 5000, 6000: 묘왕평한함지
    // 10000 이후: 사화(Seong[x, y] div 10000으로 읽을 것)
    // 사화 정보: (이진수) 18비트, 3비트 - 000~100까지 각각 (없음, 록, 권, 과, 기)
    //  hhhdddmmmyyyDDDsss (h: 유시, d: 유일, m: 유월, y: 유년, D: 대한, s: 선천)

    IdxSeong: array[1..999] of Integer; // 별이 어느 궁에 들어있는지 기록함

    Ohaengguk, // 오행국수
    Myeonggung, // 명궁 위치
    Singung, // 신궁 위치
    Sign, // Sign = 1은 음력을 기준으로 양남·음녀, -1은 음남·양녀
    BanType, // 0~2까지 천반, 지반, 인반
    Year, Month, Day, Hour, // 명반 작성에 필요한 생년월일시 정보.
                            // 년: 만세력, 월·일: 음력, 시: 만세력
    lYear, lMonth, lDay, // 음력 년월일
    sYear, sMonth, sDay, // 양녁 년월일
    mYear, mMonth, mDay, mHour, mMulti, // 만세력으로 년월일시 및 곱
    oHour, oMinute: Integer; // 숫자로 시간, 분
    lYun, lLargeMonth, // 윤달 및 대소 여부
    SummerTime, IsYajasi: Boolean; // 서머타임시 및 야자시 여부
    StandardTime, EOT: Single; // 기준시(경도), 균시차
    Myeongju, Sinju: Integer; // 명주, 신주

    procedure Config(DefaultFontSize, DefaultMaxLength, DefaultCellMargin,
                                        CanvasWidth, CanvasHeight: Integer);
    procedure ConfigTime(CalType, cYear, cMonth, cDay, cHour, cMinute,
                        Sex, cBanType: Integer; Yajasi: Boolean = False);
    procedure Arrangement;
    procedure SetSigan(Count: Integer; Sigan, IdxSigan: array of Integer);
    procedure BeforeAddItem(Index: Integer; Height: Integer = -1);
    procedure AddItem(Index: Integer; Height: Integer = -1);
    procedure ResetCell(Index: Integer);
    procedure AddSeong(Index, Content: Integer);

    constructor Create(DefaultFontSize, DefaultMaxLength, DefaultCellMargin,
                                        CanvasWidth, CanvasHeight: Integer);
    destructor Destroy; override;
  private
    FontSize, MaxLength, CellMargin, Width, Height: Integer;

    // Name: 입력할 별, Pivot: 기준점(지지 또는 다른 별),  Go: 기준점에서 움직일 거리(순행은 +, 역행은 -, 같은 자리는 +1 또는 -1), Yuseong: 선천, 대한, 유년, 유월, 유일, 유시
    procedure PutSeong(Name, Pivot: string; Go: Integer = 1; Yuseong: Integer = 0);
  end;

  TSahangName = array[0..11] of string;
  TNapeumName = array[0..29] of string;
  TOhaenggukName = array[2..6] of string;
  TBrightnessName = array[1..6] of string;
  TSahwaName = array[1..4] of string;
  TSeongName = array[1..CSeongCount] of string;
  TSiganStr = array[2..6] of string;

var
  SahangName: TSahangName =
    ('명궁', '부모', '복덕', '전택', '관록', '노복',
     '천이', '질액', '재백', '자녀', '배우자', '형제');
  SahangNameC: TSahangName =
    ('命宮', '父母', '福德', '田宅', '官綠', '奴僕',
     '遷移', '疾厄', '財帛', '子女', '夫妻', '兄弟');

  NapeumName: TNapeumName =
    ('해중금', '노중화', '대림목', '노방토', '검봉금', '산두화',
     '윤하수', '성두토', '백랍금', '양류목', '정천수', '옥상토',
     '벽력화', '송백목', '장류수', '사중금', '산하화', '평지목',
     '벽상토', '금박금', '복등화', '천하수', '대역토', '차천금',
     '상자목', '대계수', '사중토', '천상화', '석류목', '대해수');
  NapeumNameC: TNapeumName =
    ('海中金', '爐中火', '大林木', '路傍土', '劍鋒金', '山頭火',
     '澗下水', '城頭土', '白蠟金', '楊柳木', '泉中水', '屋上土',
     '霹靂火', '松柏木', '金箔金', '砂中金', '山下火', '平地木',
     '壁上土', '長流水', '覆燈火', '天下水', '大驛土', '𨥁釧金',
     '桑梧木', '大溪水', '沙中土', '天上火', '石榴木', '大海水');

  OhaenggukName: TOhaenggukName = ('수', '목', '금', '토', '화');
  OhaenggukNameC: TOhaenggukName = ('水', '木', '金', '土', '火');

  BrightnessName: TBrightnessName = ('묘', '왕', '평', '한', '함', '지');
  BrightnessNameC: TBrightnessName = ('廟', '旺', '平', '閑', '陷', '地');

  SahwaName: TSahwaName = ('록', '권', '과', '기');
  SahwaNameC: TSahwaName = ('綠', '權', '科', '忌');

  SeongName: TSeongName =
('자미','천기','태양','무곡','천동','염정',// 자미성계
 '천부','태음','탐랑','거문','천상','천량','칠살','파군',// 천부성계
 '문창','문곡','좌보','우필','천괴','천월','록존','천마',// 길성
 '경양','타라','화성','영성','지공','지겁','천형','천요',// 살성
 '태보','봉고','삼태','팔좌','은광','천귀','용지','봉각', // 백관조공성
 '홍란','천희','대모','홍염','절공','순공','천공',
 '천관','천복','천재','천수','천덕','월덕','천주','천무','해신','년해', // 제길성
 '천곡','천허','음살','고진','과숙','잡성천월','비렴','파쇄','잡성천상','천사',// 제흉성
 '생','욕','대','관','왕','쇠','병','사','묘','절','태','양',// 장생십이신
 '장성','반안','세역','식신','화개','겁살','재살','천살','지배','함지','월살','망신',// 장전십이신
 '박사','역사','청룡','소모','장군','주서','박사비렴','희신','박사병부','박사대모','복병','박사관부',// 박사십이신
 '태세','회기','상문','관색','태세관부','소모','세파','용덕','백호','태세천덕','조객','태세병부' // 태세십이신
);
  SeongNameC: TSeongName =
('紫微','天機','太陽','武曲','天同','廉貞',
 '天府','太陰','貪狼','巨門','天相','天梁','七殺','破軍',
 '文昌','文曲','左輔','右弼','天魁','天鉞','綠存','天馬',
 '擎羊','陀羅','火星','鈴星','地空','地劫','天刑','天姚',
 '台輔','封誥','三台','八座','恩光','天貴','龍池','鳳閣',
 '紅鸞','天喜','大耗','紅艶','截空','旬空','天空',
 '天官','天福','天才','天壽','天德','月德','天廚','天巫','解神','年解',
 '天哭','天虛','陰煞','孤辰','寡宿','天月','蜚廉','破碎','天傷','天使',
 '生','浴','帶','官','旺','衰','病','死','墓','絶','胎','養',
 '將星','攀鞍','歲驛','息神','華蓋','劫煞','災煞','天煞','指背','咸池','月煞','亡神',
 '博士','力士','靑龍','小耗','將軍','奏書','飛廉','喜神','病符','大耗','伏兵','官府',
 '太歲','晦氣','喪門','貫索','官符','小耗','歲破','龍德','白虎','天德','弔客','病符'
);

  SiganStr: TSiganStr = ('대', '년', '월', '일', '시');
  SiganStrC: TSiganStr = ('大', '年', '月', '日', '時');

  Ohaengguksu: array[0..4] of Integer = (4, 2, 6, 5, 3);

implementation

uses
  calendar_unit;

const
  GanName = '자축인묘진사오미신유술해';

  Brightness: array[1..30, 0..11] of Integer =
    // 1~6까지 순서대로 묘왕평한함지
    ((3, 1, 1, 2, 5, 2, 1, 1, 2, 3, 4, 2), // 자미
     (1, 5, 2, 2, 1, 3, 1, 5, 3, 2, 1, 3), // 천기
     (5, 5, 2, 1, 2, 2, 1, 3, 4, 4, 5, 5), // 태양
     (2, 1, 4, 5, 1, 3, 2, 1, 3, 2, 1, 3), // 무곡
     (2, 5, 4, 1, 3, 1, 5, 5, 2, 3, 3, 1), // 천동
     (3, 2, 1, 4, 2, 5, 3, 1, 1, 3, 2, 5), // 염정
     (1, 1, 1, 3, 1, 3, 2, 1, 3, 5, 1, 2), // 천부
     (1, 1, 4, 5, 4, 5, 5, 3, 3, 2, 2, 1), // 태음
     (2, 1, 3, 6, 1, 5, 2, 1, 3, 3, 1, 5), // 탐랑
     (2, 2, 1, 1, 3, 3, 2, 5, 1, 1, 2, 2), // 거문
     (1, 1, 1, 5, 2, 3, 2, 4, 1, 5, 4, 3), // 천상
     (1, 2, 1, 1, 2, 5, 1, 2, 5, 6, 2, 5), // 천량
     (2, 1, 1, 5, 2, 3, 2, 2, 1, 4, 1, 3), // 칠살
     (1, 2, 5, 2, 2, 4, 1, 1, 5, 5, 2, 3), // 파군

     (2, 1, 5, 3, 2, 1, 5, 3, 2, 1, 5, 2), // 문창
     (1, 1, 3, 2, 1, 1, 5, 2, 3, 1, 5, 2), // 문곡
     (2, 1, 1, 5, 1, 3, 2, 1, 3, 5, 1, 4), // 좌보
     (1, 1, 2, 5, 1, 3, 2, 1, 4, 5, 1, 3), // 우필
     (2, 2, 0, 1, 0, 0, 1, 0, 0, 0, 0, 2), // 천괴
     (0, 0, 2, 0, 0, 2, 0, 2, 1, 1, 0, 0), // 천월
     (2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1), // 록존
     (0, 0, 2, 0, 0, 3, 0, 0, 2, 0, 0, 3), // 천마

     (5, 1, 0, 5, 1, 0, 3, 1, 0, 5, 1, 0), // 경양
     (0, 1, 5, 0, 1, 5, 0, 1, 5, 0, 1, 5), // 타라
     (3, 2, 1, 3, 4, 2, 1, 4, 5, 5, 1, 3), // 화성
     (5, 5, 1, 1, 2, 2, 1, 2, 2, 5, 1, 1), // 영성
     (3, 5, 5, 3, 5, 1, 1, 3, 1, 1, 5, 5), // 지공
     (5, 5, 3, 3, 5, 4, 1, 3, 1, 3, 3, 2), // 지겁
     (3, 5, 1, 1, 3, 5, 3, 5, 5, 1, 1, 5), // 천형
     (5, 3, 2, 1, 5, 3, 3, 2, 4, 1, 1, 5));// 천요

  Sahwa: array[0..9, 1..4] of string =
    (('염정', '파군', '무곡', '태양'),
     ('천기', '천량', '자미', '태음'),
     ('천동', '천기', '문창', '염정'),
     ('태음', '천동', '천기', '거문'),
     ('탐랑', '태음', '우필', '천기'),
     ('무곡', '탐랑', '천량', '문곡'),
     ('태양', '무곡', '태음', '천동'),
     ('거문', '태양', '문곡', '문창'),
     ('천량', '자미', '좌보', '무곡'),
     ('파군', '거문', '태음', '탐랑'));

procedure TJamiCells.Config(DefaultFontSize, DefaultMaxLength, DefaultCellMargin,
                                               CanvasWidth, CanvasHeight: Integer);
var
  I, tMaxItem: Integer;
begin
  FontSize:=DefaultFontSize;
  MaxLength:=DefaultMaxLength;
  CellMargin:=DefaultCellMargin;
  Width:=CanvasWidth;
  Height:=CanvasHeight;

  tMaxItem:=Height div (FontSize + CellMargin*2) div 4;


  with CellCursor[12] do
  begin
    MaxItem:=tMaxItem * 2;
    BaseLeft:=Width div 4 + CellMargin;
    BaseTop:=Height div 4 + CellMargin;
  end;

  Dec(tMaxItem, 2);
  for I:=1 to 4 do
  begin
    with CellCursor[I+1] do
    begin
      MaxItem:=tMaxItem;
      BaseLeft:=CellMargin;
      BaseTop:=Height div 4 * (4-I) + CellMargin;
    end;

    with CellCursor[12-I] do
    begin
      MaxItem:=tMaxItem;
      BaseLeft:=Width div 4 * 3 + CellMargin;
      BaseTop:=Height div 4 * (4-I) + CellMargin;
    end;
  end;

  for I:=1 to 2 do
  begin
    with CellCursor[5+I] do
    begin
      MaxItem:=tMaxItem;
      BaseLeft:=Width div 4 * I + CellMargin;
      BaseTop:=CellMargin;
    end;

    with CellCursor[2-I] do
    begin
      MaxItem:=tMaxItem;
      BaseLeft:=Width div 4 * I + CellMargin;
      BaseTop:=Height div 4 * 3 + CellMargin;
    end;
  end;
end;

procedure TJamiCells.PutSeong(Name, Pivot: string; Go: Integer = 1; Yuseong: Integer = 0);
var
  I, Index: Integer;
begin // Go=1, -1은 제자리. 양수는 순행, 음수는 역행. 0은 사용될 수 없습니다.
  I:=Length(Pivot) div Length('가');
  if I = 1 then
    Index:=(Pos(Pivot, GanName)-1) div Length('가')
  else
    for I:=1 to CSeongCount do
      if SeongName[I] = Pivot then
      begin
        Index:=IdxSeong[I] mod 100;
        break;
      end;

  for I:=1 to CSeongCount do
    if SeongName[I] = Name then
    begin
      if Go < 0 then Inc(Go, 2);
      AddSeong(Index + Go - 1, I+150*Yuseong);
      break;
    end;
end;

procedure TJamiCells.ConfigTime(CalType: Integer; cYear, cMonth, cDay, cHour, cMinute, Sex, cBanType: Integer; Yajasi: Boolean = False);
begin
  case CalType of
    0: begin // 양력
      sYear:=cYear;
      sMonth:=cMonth;
      sDay:=cDay;

      TimeAdjustment(sYear, sMonth, sDay, cHour, cMinute, StandardTime, EOT, SummerTime, Yajasi);
      solortolunar(sYear, sMonth, sDay, lYear, lMonth, lDay, lYun, lLargeMonth);
    end;
    else
    begin // 음력
      lYear:=cYear;
      lMonth:=cMonth;
      lDay:=cDay;
      lYun:=CalType = 2;

      lunartosolar(lYear, lMonth, lDay, lYun, sYear, sMonth, sDay);
      TimeAdjustment(sYear, sMonth, sDay, cHour, cMinute, StandardTime, EOT, SummerTime, Yajasi);
      solortolunar(sYear, sMonth, sDay, lYear, lMonth, lDay, lYun, lLargeMonth);
    end;
  end;

  oHour:=cHour;
  oMinute:=cMinute;
  sydtoso24yd(sYear, sMonth, sDay, cHour, cMinute,
                    mMulti, mYear, mMonth, mDay, mHour);
  if Yajasi and (((cHour>=23) and (cMinute>=30)) or
                 ((cHour = 0) and (CMinute<30))) then
    mDay:=(mDay+59) mod 60;

  Year:=(lYear-1984+12000) mod 60;
  if lYun and (lDay > 15) then Month:=lMonth mod 12+1 else Month:=lMonth;
  Day:=lDay;
  Hour:=mHour;

  if (Year mod 2) xor Sex = 0 then Sign:=1
  else Sign:=-1;

  BanType:=cBanType;
  IsYajasi:=Yajasi;
  Arrangement;
end;

procedure TJamiCells.Arrangement;
var
  I, T: Integer;
  str: string;

  function SeongFinder(Name: string): Integer;
  var
    I: Integer;
  begin
    Result:=0;
    for I:=1 to 25 do
      if SeongName[I] = Name then
      begin
        Result:=I;
        Break;
      end;
  end;

begin
  Singung:=(Month + Hour mod 12 + 1) mod 12;
  case BanType of
    0: Myeonggung:=(12 + 1 + Month - Hour mod 12) mod 12;
    1: Myeonggung:=Singung;
    2: Myeonggung:=(12 + 1 + Month - Hour mod 12 + 2) mod 12
  end;

  case Myeonggung of
    0: Myeongju:=SeongFinder('탐랑');
    1: Myeongju:=SeongFinder('거문');
    2: Myeongju:=SeongFinder('록존');
    3: Myeongju:=SeongFinder('문곡');
    4: Myeongju:=SeongFinder('염정');
    5: Myeongju:=SeongFinder('무곡');
    6: Myeongju:=SeongFinder('파군');
    7: Myeongju:=SeongFinder('무곡');
    8: Myeongju:=SeongFinder('염정');
    9: Myeongju:=SeongFinder('문곡');
   10: Myeongju:=SeongFinder('록존');
   11: Myeongju:=SeongFinder('거문');
  end;

  case Year mod 12 of
    0: Sinju:=SeongFinder('화성');
    1: Sinju:=SeongFinder('천상');
    2: Sinju:=SeongFinder('천량');
    3: Sinju:=SeongFinder('천동');
    4: Sinju:=SeongFinder('문곡');
    5: Sinju:=SeongFinder('천기');
    6: Sinju:=SeongFinder('화성');
    7: Sinju:=SeongFinder('천상');
    8: Sinju:=SeongFinder('천량');
    9: Sinju:=SeongFinder('천동');
   10: Sinju:=SeongFinder('문창');
   11: Sinju:=SeongFinder('천기');
  end;

  for I:=0 to 11 do
    with CellCursor[(I+2) mod 12] do
    begin
      GanNum:=((Year mod 5 * 2 + 2) mod 10 + I) mod 10;
      Sahang:=(I + 2 - Myeonggung + 12) mod 12;

      Seong[I, 0]:=0;
    end;

  T:=CellCursor[Myeonggung].GanNum;
  Ohaengguk:=Ohaengguksu[(T div 2 + Myeonggung div 2 mod 3) mod 5];

  ///////////////////////////////////////////////////////////
  T:=Day div Ohaengguk; // T는 몫수
  if Day mod Ohaengguk <> 0 then Inc(T);
  I:=Ohaengguk * T - Day; // I는 보수

  if odd(I) then T:=T - I + 12
  else T:=T + I;

  PutSeong('자미', '인', T);
  PutSeong('천기', '자미', -2);
  PutSeong('태양', '자미', -4);
  PutSeong('무곡', '자미', -5);
  PutSeong('천동', '자미', -6);
  PutSeong('염정', '자미', -9);

  PutSeong('천부', '인', -T);
  PutSeong('태음', '천부', 2);
  PutSeong('탐랑', '천부', 3);
  PutSeong('거문', '천부', 4);
  PutSeong('천상', '천부', 5);
  PutSeong('천량', '천부', 6);
  PutSeong('칠살', '천부', 7);
  PutSeong('파군', '천부', 11);

  PutSeong('문창', '술', -(Hour mod 12+1));
  PutSeong('문곡', '진', (Hour mod 12+1));
  PutSeong('좌보', '진', Month);
  PutSeong('우필', '술', -Month);
  case Year mod 10 of
    0, 4, 6: begin
      PutSeong('천괴', '축');
      PutSeong('천월', '미');
    end;
    1, 5: begin
      PutSeong('천괴', '자');
      PutSeong('천월', '신');
    end;
    2, 3: begin
      PutSeong('천괴', '해');
      PutSeong('천월', '유');
    end;
    7: begin
      PutSeong('천괴', '오');
      PutSeong('천월', '인');
    end;
    8, 9: begin
      PutSeong('천괴', '묘');
      PutSeong('천월', '사');
    end;
  end;
  case Year mod 10 of
    0: PutSeong('록존', '인');
    1: PutSeong('록존', '묘');
    2, 4: PutSeong('록존', '사');
    3, 5: PutSeong('록존', '오');
    6: PutSeong('록존', '신');
    7: PutSeong('록존', '유');
    8: PutSeong('록존', '해');
    9: PutSeong('록존', '자');
  end;
  case Year mod 4 of
    0: PutSeong('천마', '인');
    1: PutSeong('천마', '해');
    2: PutSeong('천마', '신');
    3: PutSeong('천마', '사');
  end;

  PutSeong('타라', '록존', -2);
  PutSeong('경양', '록존', 2);
  case Year mod 4 of
    0: begin
      PutSeong('화성', '인', Hour mod 12+1);
      PutSeong('영성', '술', Hour mod 12+1);
      str:='자';
    end;
    1: begin
      PutSeong('화성', '묘', Hour mod 12+1);
      PutSeong('영성', '술', Hour mod 12+1);
      str:='유';
    end;
    2: begin
      PutSeong('화성', '축', Hour mod 12+1);
      PutSeong('영성', '묘', Hour mod 12+1);
      str:='오';
    end;
    3: begin
      PutSeong('화성', '유', Hour mod 12+1);
      PutSeong('영성', '술', Hour mod 12+1);
      str:='묘';
    end;
  end;
  PutSeong('지공', '해', -(Hour mod 12+1));
  PutSeong('지겁', '해', Hour mod 12+1);
  PutSeong('천형', '유', Month);
  PutSeong('천요', '축', Month);

  PutSeong('태보', '문곡', 3);
  PutSeong('봉고', '문곡', -3);

  case (Month+1) div 2 of
    1: PutSeong('해신', '신');
    2: PutSeong('해신', '술');
    3: PutSeong('해신', '자');
    4: PutSeong('해신', '인');
    5: PutSeong('해신', '진');
    6: PutSeong('해신', '오');
  end;
  PutSeong('년해', '술', -(Year mod 12+1));

  case Month of
    4, 9, 12: PutSeong('잡성천월', '인');
    5, 8: PutSeong('잡성천월', '미');
    2: PutSeong('잡성천월', '사');
    3: PutSeong('잡성천월', '진');
    6: PutSeong('잡성천월', '묘');
    7: PutSeong('잡성천월', '해');
    10: PutSeong('잡성천월', '오');
    1, 11: PutSeong('잡성천월', '술');
  end;

  case Month of
    1, 7: PutSeong('음살', '인');
    2, 8: PutSeong('음살', '자');
    3, 9: PutSeong('음살', '술');
    4, 10: PutSeong('음살', '신');
    5, 11: PutSeong('음살', '오');
    6, 12: PutSeong('음살', '진');
  end;

  case Month mod 4 of
    3: PutSeong('천무', '인');
    0: PutSeong('천무', '해');
    1: PutSeong('천무', '사');
    2: PutSeong('천무', '신');
  end;

  PutSeong('삼태', '좌보', Day);
  PutSeong('팔좌', '우필', -Day);
  PutSeong('은광', '문창', Day-1);
  PutSeong('천귀', '문곡', Day-1);

  case Year mod 10 of
    0: begin
      PutSeong('천복', '유');
      PutSeong('천관', '미');
      PutSeong('천주', '사');
      PutSeong('절공', '신');
      PutSeong('홍염', '오');
    end;
    1: begin
      PutSeong('천복', '신');
      PutSeong('천관', '진');
      PutSeong('천주', '오');
      PutSeong('절공', '미');
      PutSeong('홍염', '신');
    end;
    2: begin
      PutSeong('천복', '자');
      PutSeong('천관', '사');
      PutSeong('천주', '자');
      PutSeong('절공', '진');
      PutSeong('홍염', '인');
    end;
    3: begin
      PutSeong('천복', '해');
      PutSeong('천관', '인');
      PutSeong('천주', '사');
      PutSeong('절공', '묘');
      PutSeong('홍염', '미');
    end;
    4: begin
      PutSeong('천복', '묘');
      PutSeong('천관', '묘');
      PutSeong('천주', '오');
      PutSeong('절공', '자');
      PutSeong('홍염', '진');
    end;
    5: begin
      PutSeong('천복', '인');
      PutSeong('천관', '유');
      PutSeong('천주', '신');
      PutSeong('절공', '유');
      PutSeong('홍염', '진');
    end;
    6: begin
      PutSeong('천복', '오');
      PutSeong('천관', '해');
      PutSeong('천주', '인');
      PutSeong('절공', '오');
      PutSeong('홍염', '술');
    end;
    7: begin
      PutSeong('천복', '사');
      PutSeong('천관', '유');
      PutSeong('천주', '오');
      PutSeong('절공', '사');
      PutSeong('홍염', '유');
    end;
    8: begin
      PutSeong('천복', '오');
      PutSeong('천관', '술');
      PutSeong('천주', '유');
      PutSeong('절공', '인');
      PutSeong('홍염', '자');
    end;
    9: begin
      PutSeong('천복', '사');
      PutSeong('천관', '오');
      PutSeong('천주', '해');
      PutSeong('절공', '축');
      PutSeong('홍염', '신');
    end;
  end;

  case Year div 10 of
    0: if Odd(Year) then PutSeong('순공', '해') else PutSeong('순공', '술');
    1: if Odd(Year) then PutSeong('순공', '유') else PutSeong('순공', '신');
    2: if Odd(Year) then PutSeong('순공', '미') else PutSeong('순공', '오');
    3: if Odd(Year) then PutSeong('순공', '사') else PutSeong('순공', '진');
    4: if Odd(Year) then PutSeong('순공', '묘') else PutSeong('순공', '인');
    5: if Odd(Year) then PutSeong('순공', '축') else PutSeong('순공', '자');
  end;

  T:=(Year+1) mod 12 div 3 * 3;
  PutSeong('고진', '자', T+3);
  PutSeong('과숙', '자', T+11);

  T:=Year mod 12+1;
  PutSeong('천허', '오', T);
  PutSeong('천곡', '오', -T);
  PutSeong('홍란', '묘', -T);
  PutSeong('천희', '홍란', 7);
  PutSeong('용지', '진', T);
  PutSeong('봉각', '술', -T);
  PutSeong('천재', '자', Myeonggung + T);
  PutSeong('천수', '자', Singung + T);
  PutSeong('잡성천상', '자', Myeonggung + 6);
  PutSeong('천사', '자', Myeonggung + 8);
  PutSeong('천공', '자', T+1);
  PutSeong('천덕', '유', T);
  PutSeong('월덕', '사', T);

  //if Odd(T div 3) then PutSeong('비렴', '자', T+2)
  //else PutSeong('비렴', '자', T+8);

  Dec(T);

  PutSeong('비렴', '자', (3-T div 3)*3 + T mod 3 + 12);
  if Odd(T) then T:=T div 2 * 2 + 7
  else T:=T div 2 * 2 + 8;
  PutSeong('대모', '자', T);

  case Year mod 3 of
    0: PutSeong('파쇄', '사');
    1: PutSeong('파쇄', '축');
    2: PutSeong('파쇄', '유');
  end;

  PutSeong('장성', str);
  PutSeong('반안', str, 2);
  PutSeong('세역', str, 3);
  PutSeong('식신', str, 4);
  PutSeong('화개', str, 5);
  PutSeong('겁살', str, 6);
  PutSeong('재살', str, 7);
  PutSeong('천살', str, 8);
  PutSeong('지배', str, 9);
  PutSeong('함지', str, 10);
  PutSeong('월살', str, 11);
  PutSeong('망신', str, 12);

  PutSeong('박사', '록존');
  PutSeong('역사', '록존', Sign*2);
  PutSeong('청룡', '록존', Sign*3);
  PutSeong('소모', '록존', Sign*4);
  PutSeong('장군', '록존', Sign*5);
  PutSeong('주서', '록존', Sign*6);
  PutSeong('박사비렴', '록존', Sign*7);
  PutSeong('희신', '록존', Sign*8);
  PutSeong('박사병부', '록존', Sign*9);
  PutSeong('박사대모', '록존', Sign*10);
  PutSeong('복병', '록존', Sign*11);
  PutSeong('박사관부', '록존', Sign*12);

  T:=Year mod 12;
  PutSeong('태세', '자', T+1);
  PutSeong('회기', '자', T+2);
  PutSeong('상문', '자', T+3);
  PutSeong('관색', '자', T+4);
  PutSeong('태세관부', '자', T+5);
  PutSeong('소모', '자', T+6);
  PutSeong('세파', '자', T+7);
  PutSeong('용덕', '자', T+8);
  PutSeong('백호', '자', T+9);
  PutSeong('태세천덕', '자', T+10);
  PutSeong('조객', '자', T+11);
  PutSeong('태세병부', '자', T+12);

  case Ohaengguk of
    2: str:='신';
    3: str:='해';
    4: str:='사';
    5: str:='신';
    6: str:='인';
  end;

  if Sign = 1 then T:=1 else T:=-1;

  PutSeong('생', str);
  PutSeong('욕', str, 2*T);
  PutSeong('대', str, 3*T);
  PutSeong('관', str, 4*T);
  PutSeong('왕', str, 5*T);
  PutSeong('쇠', str, 6*T);
  PutSeong('병', str, 7*T);
  PutSeong('사', str, 8*T);
  PutSeong('묘', str, 9*T);
  PutSeong('절', str, 10*T);
  PutSeong('태', str, 11*T);
  PutSeong('양', str, 12*T);

  /////////////////////////////////////////////////////////////////////
  for T:=1 to 4 do
    for I:=1 to 20 do
      if SeongName[I] = Sahwa[Year mod 10, T] then
      begin
        Inc(Seong[IdxSeong[I] mod 100, IdxSeong[I] div 100], T*10000);
        Break;
      end;
end;

procedure TJamiCells.SetSigan(Count: Integer; Sigan, IdxSigan: array of Integer);
// Count: 1은 대한, 2는 유년, 3은 유월, 4는 유일, 5는 유시
// Sigan: 선택한 시점. 예) 제1대한, 5세, 2월, 1일, 축시
// IdxSigan: 선택한 시점에 해당하는 궁
var
  I, J, K, T, T2,
  tYear, tMonth, tDay: Integer;
begin
  for I:=0 to Count-1 do
  begin
    case I of // Count에서 -1을 하는 것에 유의할 것.
      0: begin // 대한 유성 - 대한명궁의 천간 지지 지용
        T:=CellCursor[IdxSigan[I]].GanNum; // 유성배치시 기준되는 천간
        T2:=IdxSigan[I]; // 유성배치시 기준되는 지지
      end;
      1: begin // 유년 유성
        T:=Sigan[1]+Year-1; // 생년 육십갑자에서 나이를 더함
        T2:=T mod 12; // 지지를 뽑아냄
        T:=T mod 10; // 천간을 뽑아냄
      end;
      2: begin // 유월 유성
        T:=(Sigan[1]+Year-1) mod 5*2+2+Sigan[2]-1; // 월건법으로 육십갑자를 뽑음
        T2:=T mod 12; // 지지 추출
        T:=T mod 10; // 천간 추출
      end;
      3: begin // 유일 유성
        lunartosolar(lYear+Sigan[1]-1, Sigan[2], Sigan[3], False, tYear, tMonth, tDay);
        // 유일의 연월일시를 양력으로 전환
        T:=60+7-(disp2days(unityear,unitmonth,unitday,tyear,tmonth,tday) mod 60);
        // 일주 구하기
        T2:=T mod 12; // 지지 추출
        T:=T mod 10; // 천간 추출
        tDay:=T; // 유시 유성 작성을 위하여
      end;
      4: begin // 유시 유성
        T:=tDay mod 5*2;
        T2:=Sigan[4];
      end;
    end;

    for J:=1 to 4 do
      for K:=1 to 20 do
        if SeongName[K] = Sahwa[T, J] then
        begin
          Inc(Seong[IdxSeong[K] mod 100, IdxSeong[K] div 100], (J*10000) shl (3*(I+1)));
          Break;
        end;

    // T: 천간 기준으로 배치되는 유성들
    case T of
      0, 4, 6: begin
        PutSeong('천괴', '축', 1, I+1);
        PutSeong('천월', '미', 1, I+1);
      end;
      1, 5: begin
        PutSeong('천괴', '자', 1, I+1);
        PutSeong('천월', '신', 1, I+1);
      end;
      2, 3: begin
        PutSeong('천괴', '해', 1, I+1);
        PutSeong('천월', '유', 1, I+1);
      end;
      7: begin
        PutSeong('천괴', '오', 1, I+1);
        PutSeong('천월', '인', 1, I+1);
      end;
      8, 9: begin
        PutSeong('천괴', '묘', 1, I+1);
        PutSeong('천월', '사', 1, I+1);
      end;
    end;
    case T of
      0: begin
        PutSeong('문창', '사', 1, I+1);
        PutSeong('문곡', '유', 1, I+1);
      end;
      1: begin
        PutSeong('문창', '오', 1, I+1);
        PutSeong('문곡', '신', 1, I+1);
      end;
      2, 4: begin
        PutSeong('문창', '신', 1, I+1);
        PutSeong('문곡', '오', 1, I+1);
      end;
      3, 5: begin
        PutSeong('문창', '유', 1, I+1);
        PutSeong('문곡', '사', 1, I+1);
      end;
      6: begin
        PutSeong('문창', '해', 1, I+1);
        PutSeong('문곡', '묘', 1, I+1);
      end;
      7: begin
        PutSeong('문창', '자', 1, I+1);
        PutSeong('문곡', '인', 1, I+1);
      end;
      8: begin
        PutSeong('문창', '인', 1, I+1);
        PutSeong('문곡', '자', 1, I+1);
      end;
      9: begin
        PutSeong('문창', '묘', 1, I+1);
        PutSeong('문곡', '해', 1, I+1);
      end;
    end;
    case T of
      0: begin
        PutSeong('경양', '묘', 1, I+1);
        PutSeong('록존', '인', 1, I+1);
        PutSeong('타라', '축', 1, I+1);
      end;
      1: begin
        PutSeong('경양', '진', 1, I+1);
        PutSeong('록존', '묘', 1, I+1);
        PutSeong('타라', '인', 1, I+1);
      end;
      2, 4: begin
        PutSeong('경양', '오', 1, I+1);
        PutSeong('록존', '사', 1, I+1);
        PutSeong('타라', '진', 1, I+1);
      end;
      3, 5: begin
        PutSeong('경양', '미', 1, I+1);
        PutSeong('록존', '오', 1, I+1);
        PutSeong('타라', '사', 1, I+1);
      end;
      6: begin
        PutSeong('경양', '유', 1, I+1);
        PutSeong('록존', '신', 1, I+1);
        PutSeong('타라', '미', 1, I+1);
      end;
      7: begin
        PutSeong('경양', '술', 1, I+1);
        PutSeong('록존', '유', 1, I+1);
        PutSeong('타라', '신', 1, I+1);
      end;
      8: begin
        PutSeong('경양', '자', 1, I+1);
        PutSeong('록존', '해', 1, I+1);
        PutSeong('타라', '술', 1, I+1);
      end;
      9: begin
        PutSeong('경양', '축', 1, I+1);
        PutSeong('록존', '자', 1, I+1);
        PutSeong('타라', '해', 1, I+1);
      end;
    end;

    // T2: 지지 기준으로 배치되는 유성들
    case T2 mod 4 of
      0: begin
        PutSeong('천마', '인', 1, I+1);
        PutSeong('화성', '인', Hour mod 12+1, I+1);
        PutSeong('영성', '술', Hour mod 12+1, I+1);
      end;
      1: begin
        PutSeong('천마', '해', 1, I+1);
        PutSeong('화성', '묘', Hour mod 12+1, I+1);
        PutSeong('영성', '술', Hour mod 12+1, I+1);
      end;
      2: begin
        PutSeong('천마', '신', 1, I+1);
        PutSeong('화성', '축', Hour mod 12+1, I+1);
        PutSeong('영성', '묘', Hour mod 12+1, I+1);
      end;
      3: begin
        PutSeong('천마', '사', 1, I+1);
        PutSeong('화성', '유', Hour mod 12+1, I+1);
        PutSeong('영성', '술', Hour mod 12+1, I+1);
      end;
    end;

    PutSeong('홍란', '묘', -T2-1, I+1);
    PutSeong('천희', '유', -T2-1, I+1);
  end;
end;

procedure TJamiCells.BeforeAddItem(Index: Integer; Height: Integer = -1);
begin
  if Height < 0 then Height:=FontSize;

  with CellCursor[Index] do
    if (Top+Height) > BaseTop+MaxItem*(FontSize+CellMargin*2) then
    begin
      Inc(Left, MaxLength);
      Top:=BaseTop;
    end;
end;

procedure TJamiCells.AddItem(Index: Integer; Height: Integer = -1);
begin
  if Height < 0 then Height:=FontSize;

  with CellCursor[Index] do
    Inc(Top, Height);
end;

procedure TJamiCells.ResetCell(Index: Integer);
begin
  with CellCursor[Index] do
  begin
    Left:=BaseLeft;
    Top:=BaseTop;
  end;
end;

procedure TJamiCells.AddSeong(Index, Content: Integer);
begin
  Index:=(Index + 120) mod 12;
  Inc(Seong[Index, 0]);
  IdxSeong[Content]:=Index + Seong[Index, 0] * 100;

  if Content < 31 then Inc(Content, Brightness[Content, Index] * 1000);
  Seong[Index, Seong[Index, 0]]:=Content;
end;

constructor TJamiCells.Create(DefaultFontSize, DefaultMaxLength, DefaultCellMargin,
                                               CanvasWidth, CanvasHeight: Integer);
begin
  inherited Create;

  Config(DefaultFontSize, DefaultMaxLength, DefaultCellMargin,
                                   CanvasWidth, CanvasHeight);
end;

destructor TJamiCells.Destroy;
begin
  inherited Destroy;
end;

end.

