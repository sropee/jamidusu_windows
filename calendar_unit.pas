{*****************************************************************************
  이 파일은 고영창 님의 진짜만세력 소스 코드에서 가져온 것입니다.
  속도 개선을 위해 주요 프로시져와 함수에 수정을 가하였고,
  새로 추가한 프로시져들도 일부 있습니다.
  또 편의상 대부분의 변수형을 Integer로 일원화하였습니다.

  자세한 것은 배포시 동봉한 calsource.zip 파일 내의 소스 코드와 비교하세요.

  아래 GPL 라이센스 정보는 오직 제가 작성한 부분에만 관한 것입니다.

  - 두수초보 -
 *****************************************************************************
  This file was taken from Jinjja Manseryeok by Yeongchang Ko.
  I modified core procedures and functions for optimization and
  added some procedures.
  And I unified most of variable types to Integer for convenience.

  For more details, please compare it with the original source code
  in calsource.zip.

  The following GPL license information is only applied to the part I wrote.

  Regards,
  Dusuchobo
 *****************************************************************************
}

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

unit calendar_unit;

{$MODE Delphi}

interface

uses sysutils;

const
  montharray : array[0..24] of integer =
               (0,21355,42843,64498,86335,108366,130578,152958,
                175471,198077,220728,243370,265955,288432,310767,332928,
                354903,376685,398290,419736,441060,462295,483493,504693,525949);
  { 입춘시점에서 24절기의 시점까지의 길이 - 분 }
  {  yearmin := 525948.75 ; - 실제 1년길이 (분)
     yearmini := 525949 ; - 근사치 (오차 3456년에 1일)}

{  solorlat : array[0..24] of integer =
              (315,330,345,0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,
               225,240,255,270,285,300,315); }

  monthst : array[0..24] of string =
          ('입춘','우수','경칩','춘분','청명','곡우',
           '입하','소만','망종','하지','소서','대서',
           '입추','처서','백로','추분','한로','상강',
           '입동','소설','대설','동지','소한','대한','입춘');
  gan : array[0..9] of string =
          ('甲','乙','丙','丁','戊','己','庚','辛','壬','癸');
  ji : array[0..11] of string =
          ('子','丑','寅','卯','辰','巳','午','未','申','酉','戌','亥');
  ganji : array[0..59] of string =
       ('甲子','乙丑','丙寅','丁卯','戊辰',
        '己巳','庚午','辛未','壬申','癸酉',
        '甲戌','乙亥','丙子','丁丑','戊寅',

        '己卯','庚辰','辛巳','壬午','癸未',
        '甲申','乙酉','丙戌','丁亥','戊子',
        '己丑','庚寅','辛卯','壬辰','癸巳',

        '甲午','乙未','丙申','丁酉','戊戌',
        '己亥','庚子','辛丑','壬寅','癸卯',
        '甲辰','乙巳','丙午','丁未','戊申',

        '己酉','庚戌','辛亥','壬子','癸丑',
        '甲寅','乙卯','丙辰','丁巳','戊午',
        '己未','庚申','辛酉','壬戌','癸亥');

  ///////// 아래 ~~K는 한글용으로 진짜만세력에서 추가한 것입니다.
  ganK : array[0..9] of string =
          ('갑','을','병','정','무','기','경','신','임','계');
  jiK : array[0..11] of string =
          ('자','축','인','묘','진','사','오','미','신','유','술','해');
  ganjiK : array[0..59] of string =
       ('갑자','을축','병인','정묘','무진',
        '기사','경오','신미','임신','계유',
        '갑술','을해','병자','정축','무인',

        '기묘','경진','신사','임오','계미',
        '갑신','을유','병술','정해','무자',
        '기축','경인','신묘','임진','계사',

        '갑오','을미','병신','정유','무술',
        '기해','경자','신축','임인','계묘',
        '갑진','을사','병오','정미','무신',

        '기유','경술','신해','임자','계축',
        '갑인','을묘','병진','정사','무오',
        '기미','경신','신유','임술','계해');

  weekday : array[0..6] of string =
             ('일요일','월요일','화요일','수요일','목요일','금요일','토요일');

  s28day : array[0..27] of string =
             ('角','亢','저','房','心','尾','箕',
              '斗','牛','女','虛','危','室','壁',
              '奎','누','胃','昴','畢','자','參',
              '井','鬼','柳','星','張','翼','진');

  {병자년 경인월 신미일 기해시 - 입춘 }
  unityear  : integer = 1996;
  unitmonth : integer = 2;
  unitday   : integer = 4;
  unithour  : integer = 22;
  unitmin   : integer = 8;
  unitsec   : integer = 0;

 {1996년 음력 1월 1일 합삭 일시 }
  unitmyear : integer =1996;
  unitmmonth : integer=2;
  unitmday : integer=19;
  unitmhour : integer=8;
  unitmmin : integer=30;
  unitmsec : integer=0;
  moonlength : integer= 42524 ; { =42524분 2.9초 }

var
  disp2dayscnt: Integer = 0;

// solor - 그레고리력 년월일시분
// so24 - 60년의 배수, so24year
// so24year,so24month,so24day,so24hour - 60간지의 번호

{y1,m1,d1일부터 y2,m2,d2까지의 일수 계산 }
function disp2days(const y1:integer;m1,d1:integer;y2:integer;m2,d2:integer):integer;

// 그레고리력 년월일시분 --->  60년의 배수,세차,월건(태양력),일진,시주
procedure sydtoso24yd(const soloryear:integer;const solormonth,solorday,solorhour,solormin:integer;
                      var so24:integer;var so24year,so24month,so24day,so24hour:integer );

// 그레고리력 년월일시분이 들어있는 절기의 이름번호,년월일시분을 얻음
procedure SolortoSo24(const soloryear:integer;const solormonth,solorday,solorhour,solormin : integer;
                      var inginame:integer; var ingiyear:integer; var ingimonth,ingiday,ingihour,ingimin : integer;
                      var midname:integer;var midyear:integer;var midmonth,midday,midhour,midmin : integer;
                      var outginame:integer;var outgiyear:integer;var outgimonth,outgiday,outgihour,outgimin : integer);


//  그레고리력 년월일--> 음력 년월일,윤달,대소
procedure solortolunar(const solyear:integer;solmon,solday:integer;
                       var lyear:integer;var lmonth,lday:integer;
                       var lmoonyun,largemonth:boolean);

//  음력 년월일윤달-->그레고리력 년월일
procedure lunartosolar(const lyear:integer;lmonth,lday:integer;
                       const moonyun:boolean;
                       var syear:integer;var smonth,sday:integer);


// 그레고리력 년월일이 들어있는 태음월의 시작합삭일지,망일시,끝합삭일시
procedure getlunarfirst(const syear:integer;const smonth,sday:integer;
                        var year:integer;var month,day,hour,min:integer;
                        var yearm:integer;var monthm,daym,hourm,minm:integer;
                        var year1:integer;var month1,day1,hour1,min1:integer);


// 그레고리력 날짜->요일
function getweekday(const syear:integer; const smonth,sday:integer):integer;

// 그레고리력날짜->28수 얻음
function get28sday(const syear:integer;const smonth,sday:integer):integer;

// uyear,umonth,uday,uhour,umin으로부터 tmin(분)떨이진 시점의 년월일시분(태양력)
procedure getdatebymin(const tmin : int64;
                       const uyear:integer;const umonth,uday,uhour,umin:integer;
                       var y1:integer;var mo1,d1,h1,mi1 : integer );


// uy,umm,ud,uh,umin과 y1,mo1,d1,h1,mm1사이의 시간(분)
function  getminbytime(const uy:integer;const umm,ud,uh,umin:integer;const y1:integer; const mo1,d1,h1,mm1:integer):int64 ;



{** 아랫부분은 진짜만세력에서 추가한 부분입니다. **}

// 표준시(KST) 변경, 서머타임 시행, 야자시설 등에 따른 시간 보정
// 진짜만세력은 한국에서의 동경 표준시를 기준으로 만세력을 뽑습니다.
procedure TimeAdjustment(var Year, Month, Day, Hour, Minute: Integer;
                       var StandardTime, EOT: Single; var SummerTime: Boolean; Yajasi: Boolean = False);

// 특정 연월일시분에서 분을 가감하였을 때의 연월일시분을 구함.
procedure MinuteAdjustedTime(const MinuteAdjustment: Int64; var Year, Month, Day, Hour, Minute: Integer);

// 음력으로 큰달, 작은달 구분
function IsLunarLargeMonth(const LunarYear, LunarMonth: Integer): Boolean;

// 음력 윤달이 존재하는지 확인
function IsLunarLeapMonth(LunarYear, LunarMonth: Integer): Boolean;

implementation

{ year의 1월 1일부터 year의 month월, day일까지의 날수계산 }
// 가장 자주 호출되는 함수이므로 최적화가 중요함. 진짜만세력에서 수정했습니다.
function disptimeday(const year:integer;month,day:integer):integer;
const
  Sum: array[0..11] of Integer =
    (0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334);
begin
  if (month > 2) and IsLeapYear(year) then Result:=Sum[month-1] + day + 1
  else Result:=Sum[month-1] + day;
end;

{y1,m1,d1일부터 y2,m2,d2까지의 일수 계산 }
// 자주 호출되는 함수이므로 최적화가 중요함. 진짜만세력에서 수정했습니다.
// 양수는 date1이 date2보다 이후의 날짜라는 뜻.
function disp2days(const y1:integer;m1,d1:integer;y2:integer;m2,d2:integer):integer;
var
  I: Integer;

  function LeapCount(const Year: Integer): Integer;
  begin
    Result:=Year div 4 - Year div 100 + Year div 400;
  end;

begin
  if y1 = y2 then Result:=disptimeday(y1, m1, d1) - disptimeday(y2, m2, d2)
  else if y1 > y2 then
  begin
    if IsLeapYear(y2) then
      Result:=366 - disptimeday(y2, m2, d2) + disptimeday(y1, m1, d1)
    else Result:=365 - disptimeday(y2, m2, d2) + disptimeday(y1, m1, d1);

    Inc(Result, 365*(y1-y2-1)+LeapCount(y1-1)-LeapCount(y2));
    if (y2+1 <= 0) and (0 <= y1-1) then Inc(Result);
    {for I:=y2+1 to y1-1 do
      if IsLeapYear(I) then Inc(Result, 366)
      else Inc(Result, 365);}
  end
  else
  begin
    if IsLeapYear(y1) then
      Result:=366 - disptimeday(y1, m1, d1) + disptimeday(y2, m2, d2)
    else Result:=365 - disptimeday(y1, m1, d1) + disptimeday(y2, m2, d2);

    {for I:=y1+1 to y2-1 do
      if IsLeapYear(I) then Inc(Result, 366)
      else Inc(Result, 365);}

    Inc(Result, 365*(y2-y1-1)+LeapCount(y2-1)-LeapCount(y1));
    if (y1+1 <= 0) and (0 <= y2-1) then Inc(Result);
    Result:=-Result;
  end;
end;

{특점시점에서 특정시점까지의 분 - 부호주의 }
function  getminbytime(const uy:integer;const umm,ud,uh,umin:integer;const y1:integer; const mo1,d1,h1,mm1:integer):int64 ;
var
  dispday,t : int64 ;
begin
  dispday:=disp2days(uy,umm,ud,y1,mo1,d1);
  t := dispday * 24 * 60 + (uh-h1)* 60 + (umin-mm1) ;
  getminbytime :=t
end;


{1996년 2월 4일 22시 8분부터 tmin분 떨어진 날자와 시간을 구하는 프로시져
 특정시점(udate)으로부터 tmin분 떨어진 날짜를 구하는 프로시져 }
// 진짜만세력에서 수정하였습니다.
procedure getdatebymin(const tmin : int64;
                       const uyear:integer;const umonth,uday,uhour,umin:integer;
                       var y1:integer;var mo1,d1,h1,mi1 : integer );
begin
  y1:=uyear; mo1:=umonth; d1:=uday; h1:=uhour; mi1:=umin;
  MinuteAdjustedTime(-tmin, y1, mo1, d1, h1, mi1);
end;

// 그레고리력 년월일시분 --> 경과년수,60간지년주,월주,일주,시주
procedure sydtoso24yd(const soloryear:integer;const solormonth,solorday,solorhour,solormin:integer;
                      var so24:integer; var so24year,so24month,so24day,so24hour:integer );
var
  displ2min : int64;
  displ2day,monthmin100,j,t : integer ;
  i : integer;
begin
  displ2min := getminbytime(unityear,unitmonth,unitday,unithour,unitmin,
                            soloryear,solormonth,solorday,solorhour,solormin);
  displ2day := disp2days(unityear,unitmonth,unitday,soloryear,solormonth,solorday) ;
  so24 :=  displ2min div 525949  ; { 무인년(1996)입춘시점부터 해당일시까지 경과년수 }

  if displ2min >= 0  then so24 := so24 + 1;
  so24year := -1 * (so24 mod 60) ;
  so24year := so24year + 12 ;
  if so24year < 0 then so24year := so24year + 60 ;
  if so24year > 59 then so24year := so24year - 60 ;  { 년주 구함 끝 }

  monthmin100 := displ2min mod 525949 ;
  monthmin100 := 525949 - monthmin100 ;

  if monthmin100 <  0 then monthmin100 := monthmin100 + 525949 ;
  if monthmin100 >= 525949 then monthmin100 := monthmin100 - 525949   ;

  for i := 0 to 11 do
  begin
    j := i * 2 ;
    if  (montharray[j] <= monthmin100) and (monthmin100 < montharray[j+2]) then
    begin
      so24month := i;
    end
  end;

  i := so24month;
  t := so24year mod 10 ;
  t := t mod 5 ;
  t := t * 12 + 2 + i;
  so24month := t ;  { 월주 구함 끝 }
  if so24month > 59 then so24month := so24month - 60 ;

  so24day := displ2day mod 60 ;
  so24day := -1 * so24day  ;
  so24day := so24day + 7;

  if so24day < 0 then so24day := so24day + 60 ;
  if so24day > 59 then so24day :=so24day - 60 ; { 일주 구함 끝}

  if ( solorhour=0 ) or ((solorhour=1) and (solormin < 30)) then i:= 0;

  if ((solorhour=1) and (solormin >= 30 )) or (solorhour=2) or
     ((solorhour=3) and (solormin<30)) then i:=1;

  if (( solorhour=3) and (solormin >= 30 )) or (solorhour=4) or
     ((solorhour=5) and (solormin<30 )) then i:=2;

  if (( solorhour=5) and (solormin >= 30 )) or (solorhour=6) or
     ((solorhour=7) and (solormin<30 )) then i:=3;

  if (( solorhour=7) and (solormin >= 30 )) or (solorhour=8) or
     ((solorhour=9) and (solormin<30)) then i:=4;

  if (( solorhour=9) and (solormin >= 30 )) or (solorhour=10) or
     ((solorhour=11) and (solormin<30 )) then i:=5;

  if (( solorhour=11) and (solormin >= 30 )) or (solorhour=12) or
     ((solorhour=13) and (solormin<30 )) then i:=6;

  if (( solorhour=13) and (solormin >= 30 )) or (solorhour=14) or
     ((solorhour=15) and (solormin<30 )) then i:=7;

  if (( solorhour=15) and (solormin >= 30 )) or (solorhour=16) or
     ((solorhour=17) and (solormin<30 )) then i:=8;

  if (( solorhour=17) and (solormin >= 30 )) or (solorhour=18) or
     ((solorhour=19) and (solormin<30 )) then i:=9;

  if (( solorhour=19) and (solormin >= 30 )) or (solorhour=20) or
     ((solorhour=21) and (solormin<30 )) then i:=10;

  if (( solorhour=21) and (solormin >= 30 )) or (solorhour=22) or
     ((solorhour=23) and (solormin<30 )) then i:=11;

  if ( solorhour=23) and (solormin >= 30 ) then
  begin
    so24day := so24day + 1;
    if so24day = 60 then so24day:=0;
    i := 0
  end;

  t := so24day mod 10 ;
  t := t mod 5 ;
  t := t * 12 + i;
  so24hour := t    {시주 구함 끝 }
end;

// 그레고리력 년월일시분 --> 해당일자가 들어있는 시작절기,중기,다음절기
procedure SolortoSo24(const soloryear:integer;const solormonth,solorday,solorhour,solormin : integer;
                      var inginame:integer; var ingiyear:integer; var ingimonth,ingiday,ingihour,ingimin : integer;
                      var midname:integer;var midyear:integer;var midmonth,midday,midhour,midmin : integer;
                      var outginame:integer;var outgiyear:integer;var outgimonth,outgiday,outgihour,outgimin : integer);
var
  i,monthmin100,j : integer;
  tmin,displ2min : int64;
  y1:integer;
  mo1,d1,h1: integer;
  mi1 : integer = 0;
  so24 : integer;
  so24year: integer = 0;
  so24month: integer = 0;
  so24day: integer = 0;
  so24hour: integer = 0;
begin
  sydtoso24yd(soloryear,solormonth,solorday,solorhour,solormin,
              so24,so24year,so24month,so24day,so24hour);
  displ2min := getminbytime(unityear,unitmonth,unitday,unithour,unitmin,
                            soloryear,solormonth,solorday,solorhour,solormin);

  monthmin100 := displ2min mod 525949 ;
  monthmin100 := 525949 - monthmin100 ;

  if monthmin100 <  0 then monthmin100 := monthmin100 + 525949 ;
  if monthmin100 >= 525949 then monthmin100 := monthmin100 - 525949   ;

  i := so24month mod 12 - 2 ;
  if i=-2 then i := 10  ;
  if i=-1 then i := 11 ;

  inginame :=i*2;
  midname :=i*2+1;
  outginame :=i*2+2;

  j := i * 2 ;
  tmin :=  displ2min +  ( monthmin100 - montharray[j]);
  getdatebymin(tmin,unityear,unitmonth,unitday,unithour,unitmin,y1,mo1,d1,h1,mi1);

  ingiyear:=y1;
  ingimonth:=mo1;
  ingiday:=d1;
  ingihour:=h1;
  ingimin :=mi1;

  tmin :=  displ2min + monthmin100 - montharray[j+1];
  getdatebymin(tmin,unityear,unitmonth,unitday,unithour,unitmin,y1,mo1,d1,h1,mi1);

  midyear:=y1;
  midmonth:=mo1;
  midday:=d1;
  midhour:=h1;
  midmin :=mi1;

  tmin :=  displ2min + monthmin100 - montharray[j+2];
  getdatebymin(tmin,unityear,unitmonth,unitday,unithour,unitmin,y1,mo1,d1,h1,mi1);

  outgiyear:=y1;
  outgimonth:=mo1;
  outgiday:=d1;
  outgihour:=h1;
  outgimin :=mi1
end;

//미지의 각도를 0~360도 이내로 만듬
function degreelow(const d:extended):extended;
var
  i : int64 ;
  di : extended ;
begin
  di := d;
  i := trunc(di);
  i := i div 360 ;
  di := di - ( 360 * i );

  while ((di >= 360) or (di < 0))  do
  begin
    if di > 0 then di:=di-360
              else di:=di+360
  end;
  degreelow := di
end;

// 태양황경과 달황경의 차이
// = 0 : 합삭
// =180 : 망
function moonsundegree(day:extended):extended;
var
  sl,smin,sminangle,sd,sreal,ml,mmin,mminangle,msangle,msdangle,md,mreal : extended;
begin { 1996년 기준 }
  sl:=day*0.98564736+278.956807;  { 평균 황경 }
  smin:=282.869498+0.00004708*day; {근일점 황경 }
  sminangle := Pi*(sl-smin)/180 ; {근점이각 }
  sd := 1.919*SIN(sminangle)+0.02*SIN(2*sminangle); { 황경차 }
  sreal := degreelow(sl + sd) ; { 진황경 }

  ml := 27.836584+13.17639648*day; { 평균황경 }
  mmin :=280.425774+0.11140356*day; { 근지점 황경 }
  mminangle :=Pi*(ml-mmin)/180; { 근점이각 }
  msangle := 202.489407-0.05295377*day; { 교점황경 }
  msdangle := Pi*(ml-msangle)/180; { 교점이각 }
  md := 5.068889*SIN(mminangle)+0.146111*SIN(2*mminangle)+0.01*SIN(3*mminangle)
       -0.238056*SIN(sminangle)-0.087778*SIN(mminangle+sminangle)  { 황경차 }
       +0.048889*SIN(mminangle-sminangle)-0.129722*SIN(2*msdangle)
       -0.011111*SIN(2*msdangle-mminangle)-0.012778*SIN(2*msdangle+mminangle);
  mreal := degreelow(ml + md) ; { 진황경 }
  moonsundegree := degreelow(mreal-sreal)
end;


{ syear,smonth,sday의 전후 합삭일시,망일시 및 합삭일시 }
procedure getlunarfirst(const syear:integer;const smonth,sday:integer;
                        var year:integer;var month,day,hour,min:integer;
                        var yearm:integer;var monthm,daym,hourm,minm:integer;
                        var year1:integer;var month1,day1,hour1,min1:integer);
var
  dm,dem,
  d,de,pd: extended;
  i : int64;
begin
  dm:=disp2days(syear,smonth,sday,1995,12,31);
  dem :=moonsundegree(dm);

  d:=dm;
  de :=dem;

  while (de>13.5) do
  begin
    d := d - 1;
    de := moonsundegree(d);
  end;

  while (de>1) do
  begin
    d := d - 0.04166666666;
    de := moonsundegree(d);
  end;

  while (de<359.99) do
  begin
    d := d - 0.000694444;
    de := moonsundegree(d);
  end;

  d := d+0.375;

  d := d*1440 ;
  i := -1*trunc(d);
  getdatebymin(i,1995,12,31,0,0,year,month,day,hour,min);

  d:=dm;
  de :=dem;

  while (de<346.5) do
  begin
    d := d + 1;
    de := moonsundegree(d);
  end;

  while (de<359) do
  begin
    d := d + 0.04166666666;
    de := moonsundegree(d);
  end;

  while (de>0.01) do
  begin
    d := d + 0.000694444;
    de := moonsundegree(d);
  end;

  pd := d ;

  d := d+0.375;

  d := d*1440 ;
  i := -1*trunc(d);
  getdatebymin(i,1995,12,31,0,0,year1,month1,day1,hour1,min1);

  if (smonth=month1) and (sday=day1) then
  begin
    year := year1;
    month := month1;
    day :=day1 ;
    hour := hour1;
    min := min1;

    d:=pd;

    while (de<347) do
    begin
      d := d + 1;
      de := moonsundegree(d);
    end;
    while (de<359) do
    begin
      d := d + 0.04166666666;
      de := moonsundegree(d);
    end;
    while (de>0.01) do
    begin
      d := d + 0.000694444;
      de := moonsundegree(d);
    end;

    d := d+0.375;
    d := d*1440 ;
    i := -1*trunc(d);
    getdatebymin(i,1995,12,31,0,0,year1,month1,day1,hour1,min1)
  end;

  d:=disp2days(year,month,day,1995,12,31); // 음력 초하루
  d:=d+12; //음력 12일
  de :=moonsundegree(d);

  while (de<166.5) do
  begin
    d := d + 1;
    de := moonsundegree(d);
  end;

  while (de<179) do
  begin
    d := d + 0.04166666666;
    de := moonsundegree(d);
  end;

  while (de<179.99) do
  begin
    d := d + 0.000694444;
    de := moonsundegree(d);
  end;

  d := d+0.375;

  d := d*1440 ;
  i := -1*trunc(d);
  getdatebymin(i,1995,12,31,0,0,yearm,monthm,daym,hourm,minm);

end;

// 그레고리력 년월일 --> 태음태양력 년,월,일, 평/윤, 대/소
procedure solortolunar(const solyear:integer;solmon,solday:integer;
                       var lyear:integer;var lmonth,lday:integer;
                       var lmoonyun,largemonth:boolean);
var
  s0:int64 ;
  i : integer;
  lnp,lnp2 : boolean;
  ingiyear,midyear1,midyear2,outgiyear:integer;
  inginame,ingimonth,ingiday,ingihour,ingimin,
  midname1,midmonth1,midday1,midhour1,midmin1,
  midname2,midmonth2,midday2,midhour2,midmin2,
  outginame,outgimonth,outgiday,outgihour,outgimin : integer;
  smomonth,smoday,smohour,smomin :integer;
  smoyear,y0,y1:integer;
  mo0,d0,h0,mi0,
  mo1,d1,h1,mi1 : integer;

begin;

  getlunarfirst(solyear,solmon,solday,
                smoyear,smomonth,smoday,smohour,smomin,
                y0,mo0,d0,h0,mi0,
                y1,mo1,d1,h1,mi1);

  lday:=disp2days(solyear,solmon,solday,smoyear,smomonth,smoday) + 1;

  i := abs(disp2days(smoyear,smomonth,smoday,y1,mo1,d1));
  if i=30 then largemonth := true ;
  if i=29 then largemonth := false ;

  SolortoSo24(smoyear,smomonth,smoday,smohour,smomin, {true,i,lnp, }
              inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
              midname1,midyear1,midmonth1,midday1,midhour1,midmin1,
              outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);

  midname2:=midname1+2;
  if midname2 > 24 then midname2 := 1;
  s0 := montharray[midname2]-montharray[midname1];
  if s0 < 0 then s0:=s0 + 525949 ;
  s0 := -1 * s0 ;

  getdatebymin(s0, midyear1,midmonth1,midday1,midhour1,midmin1,
                   midyear2,midmonth2,midday2,midhour2,midmin2 ) ;

  if ( (midmonth1=smomonth) and (midday1>=smoday) ) or
     ( (midmonth1=mo1) and (midday1<d1)) then
  begin
    lmonth:=(midname1-1) div 2+1;
    lmoonyun:=false
  end
  else
    if ((midmonth2=mo1) and (midday2<d1)) or ((midmonth2=smomonth) and (midday2>=smoday)) then
    begin
      lmonth:=(midname2-1) div 2 + 1;
      lmoonyun:=false
    end
    else
    begin
      if (smomonth<midmonth2) and (midmonth2<mo1) then
      begin
        lmonth :=(midname2-1) div 2 + 1;
        lmoonyun := false
      end
      else
      begin
        lmonth:=(midname1-1) div 2 + 1;
        lmoonyun:=true
      end
    end;

  lyear := smoyear;
  if (lmonth=12) and (smomonth=1) then lyear:=lyear-1;

  if ((lmonth=11) and lmoonyun) or (lmonth=12) or (lmonth<6) then
  begin
    getdatebymin(2880, smoyear,smomonth,smoday,smohour,smomin,
                       midyear1,midmonth1,midday1,midhour1,midmin1 ) ;

    solortolunar(midyear1,midmonth1,midday1,
                 outgiyear,outgimonth,outgiday,
                 lnp,lnp2);
    outgiday := lmonth-1;
    if outgiday=0 then outgiday:=12;

    if outgiday=outgimonth then
    begin
      if lmoonyun then lmoonyun:=false
    end
    else
    begin
      if lmoonyun then
      begin
        if lmonth<>outgimonth then
        begin
          lmonth := lmonth-1;
          if lmonth=0 then lyear := lyear-1;
          if lmonth=0 then lmonth:=12;
          lmoonyun := false
        end
      end
      else
      begin
        if lmonth=outgimonth then
        begin
          lmoonyun := true;
        end
        else
        begin
          lmonth:=lmonth-1;
          if lmonth=0 then lyear := lyear-1;
          if lmonth=0 then lmonth:=12
        end
      end
    end
  end
end;

// 태음태양력 년월일,평/윤 --> 그레고리력 년월일
procedure lunartosolar(const lyear:integer;lmonth,lday:integer;
                       const moonyun:boolean;
                       var syear:integer;var smonth,sday:integer);
var
  lnp,lnp2 : boolean;
  inginame,ingimonth,ingiday,ingihour,ingimin : integer;
  midname,midmonth,midday,midhour,midmin : integer;
  outginame,outgimonth,outgiday,outgihour,outgimin : integer   ;
  tmin : int64 ;
  year0,year1,lyear2,ingiyear,midyear,outgiyear:integer;
  month0,day0,hour0,min0 :integer;
  month1,day1,hour1,min1 :integer;
  lmonth2,lday2,hour,min:integer;
begin
  lnp:=false; lnp2:=false;
  year0:=0; year1:=0; lyear2:=0; ingiyear:=0; midyear:=0; outgiyear:=0;
  lmonth2:=0; lday2:=0; hour:=0; min:=0;
  month0:=0; day0:=0; hour0:=0; min0:=0;

  SolortoSo24(lyear,2,15,0,0,
              inginame,ingiyear,ingimonth,ingiday,ingihour,ingimin,
              midname,midyear,midmonth,midday,midhour,midmin,
              outginame,outgiyear,outgimonth,outgiday,outgihour,outgimin);
  midname := lmonth * 2 - 1 ;
  tmin := -1*montharray[midname];
  getdatebymin(tmin,ingiyear,ingimonth,ingiday,ingihour,ingimin,
               midyear,midmonth,midday,midhour,midmin ) ;

  getlunarfirst(midyear,midmonth,midday,
                outgiyear,outgimonth,outgiday,hour,min,
                year0,month0,day0,hour0,min0,
                year1,month1,day1,hour1,min1);

  solortolunar(outgiyear,outgimonth,outgiday,
               lyear2,lmonth2,lday2,
               lnp,lnp2);

  if (lyear=lyear2) and (lmonth=lmonth2) then
  begin  { 평달,윤달 }
    tmin := -1440 * lday+10 ;
    getdatebymin(tmin,outgiyear,outgimonth,outgiday,0,0,
                 syear,smonth,sday,hour,min);

    if moonyun then
    begin
      solortolunar(year1,month1,day1,
                   lyear2,lmonth2,lday2,
                   lnp,lnp2);
      if (lyear2=lyear) and (lmonth=lmonth2) then
      begin
        tmin := -1440 * lday + 10;
        getdatebymin(tmin,year1,month1,day1,0,0,
                     syear,smonth,sday,hour,min);
      end
    end
  end
  else
  begin   {중기가 두번든 달의 전후 }
    solortolunar(year1,month1,day1,
                 lyear2,lmonth2,lday2,
                 lnp,lnp2);
    if (lyear2=lyear) and (lmonth=lmonth2) then
    begin
      tmin := -1440 * lday + 10;
      getdatebymin(tmin,year1,month1,day1,0,0,
                   syear,smonth,sday,hour,min);
    end
  end
end;

// 요일구하기
function getweekday(const syear:integer; const smonth,sday:integer):integer;
var
  d,i : integer ;
begin
  d := disp2days(syear,smonth,sday,unityear,unitmonth,unitday);
  i := d div 7 ;
  d := d - ( i * 7 );

  while ((d > 6) or (d < 0))  do
  begin
    if d > 6 then d:=d-7
             else d:=d+7;
  end;
  if d < 0  then d:= d+7;
  result := d
end;

// 28수 구하기
function get28sday(const syear:integer;const smonth,sday:integer):integer;
var
  d,i : integer ;
begin
  d := disp2days(syear,smonth,sday,unityear,unitmonth,unitday);
  i := d div 28 ;
  d := d - ( i * 28 );

  while ((d > 27) or (d < 0))  do
  begin
    if d > 27 then d:=d-28
              else d:=d+28
  end;
  d := d - 11;
  if d < 0  then d:= d+28;
  result := d
end;

{** 아랫부분은 진짜만세력에서 추가한 부분입니다. **}

// 표준시(KST) 변경, 서머타임 시행, 야자시설 등에 따른 시간 보정
// 진짜만세력은 한국에서의 동경 표준시(-30분)를 기준으로 만세력을 뽑습니다.
procedure TimeAdjustment(var Year, Month, Day, Hour, Minute: Integer;
  var StandardTime, EOT: Single; var SummerTime: Boolean; Yajasi: Boolean = False);
const
  StandardTimeCount = 4;
  StandardTimeTable : array[1..StandardTimeCount, 1..2] of Single =
                    ((19080401, 127.5),
                     (19100401, 135),
                     (19540321, 127.5),
                     (19610810, 135));

  SummerTimeCount = 12;
  SummerTimeTable : array[1..SummerTimeCount, 1..2] of Integer =
                  ((1948040100, 1948091224),
                   (1949040300, 1949091024),
                   (1950040100, 1950090924),
                   (1951050700, 1951090824),
                   (1955050501, 1955090901),
                   (1956052001, 1956093001),
                   (1957050501, 1957092201),
                   (1958050401, 1958092101),
                   (1959050301, 1959092001),
                   (1960050101, 1960091801),
                   (1987051003, 1987101103),
                   (1988050803, 1988100903));

var
  I, T: Integer;
  M: Single;
begin
  StandardTime:=120;

  for I:=StandardTimeCount downto 1 do
    if (Year * 10000 + Month * 100 + Day) >= StandardTimeTable[I, 1] then
    begin
      StandardTime:=StandardTimeTable[I, 2];
      Break;
    end;

  M:=2 * pi * disptimeday(Year, Month, Day) / 365.242;
  EOT:=-7.657 * sin(M) + 9.862 * sin(2*M+3.599); // 균시차

  MinuteAdjustedTime(Trunc((135-StandardTime)/7.5*30+EOT), Year, Month, Day, Hour, Minute);

  SummerTime:=False;
  for I:=1 to SummerTimeCount do
  begin
    T:=Year * 1000000 + Month * 10000 + Day * 100 + Hour;
    if (T >= SummerTimeTable[I, 1]) and (T < SummerTimeTable[I, 2]) then
    begin
      SummerTime:=True;
      MinuteAdjustedTime(-60, Year, Month, Day, Hour, Minute);
      Break;
    end;
  end;

  if Yajasi then
    if (Hour = 0) and (Minute < 30) then
      MinuteAdjustedTime(-30, Year, Month, Day, Hour, Minute)
    else
  else
    if (Hour = 23) and (Minute >= 30) then
      MinuteAdjustedTime(30, Year, Month, Day, Hour, Minute);
end;

// 특정 연월일시분에서 분을 가감하였을 때의 연월일시분을 구함.
procedure MinuteAdjustedTime(const MinuteAdjustment: Int64;
          var Year, Month, Day, Hour, Minute: Integer);
const
  CCommonYearToMinute = 365*60*24;
var
  T: Int64;
  D, K: Integer;
begin
  T:=MinuteAdjustment;

  if Abs(T) >= CCommonYearToMinute then
  begin
    K:=T div CCommonYearToMinute;
    T:=T mod CCommonYearToMinute;
    D:=disp2days(Year, Month, Day, Year+K, Month, Day)*60*24 +
      K*CCommonYearToMinute;
    Inc(Year, K);
    MinuteAdjustedTime(T+D, Year, Month, Day, Hour, Minute);
    Exit;
  end;

  Inc(T, Minute);
  Inc(Hour, T div 60);
  Minute:=T mod 60;

  if T >= 0 then
  begin
    Inc(Day, Hour div 24);
    Hour:=Hour mod 24;

    while Day > 28 do
      // case문을 쓰면 보기는 좋지만 속도가 조금 떨어집니다.
      if Month in [1, 3, 5, 7, 8, 10] then
        if Day > 31 then
        begin
          Inc(Month);
          Dec(Day, 31);
        end
        else Break
      else if Month = 2 then
        if IsLeapYear(Year) then
          if Day > 29 then
          begin
            Inc(Month);
            Dec(Day, 29);
          end
          else Break
        else
          if Day > 28 then
          begin
            Inc(Month);
            Dec(Day, 28);
          end
          else Break
      else if Month = 12 then
        if Day > 31 then
        begin
          Inc(Year);
          Month:=1;
          Dec(Day, 31);
        end
        else Break
      else
        if Day > 30 then
        begin
          Inc(Month);
          Dec(Day, 30);
        end
        else Break;
  end
  else if T < 0 then
  begin
    Minute:=(Minute + 60) mod 60;
    if Minute <> 0 then Dec(Hour);
    if Hour < 0 then
    begin
      Inc(Day, Hour div 24 - 1);
      Hour:=(Hour mod 24 + 24) mod 24;
      if Hour = 0 then Inc(Day);
    end;

    while Day < 1 do
      if (Month in [5, 7, 10, 12]) then
      begin
        Dec(Month);
        Inc(Day, 30);
      end
      else if Month = 3 then
        if IsLeapYear(Year) then
        begin
          Dec(Month);
          Inc(Day, 29);
        end
        else
        begin
          Dec(Month);
          Inc(Day, 28);
        end
      else if (Month = 1) then
      begin
        Dec(Year);
        Month:=12;
        Inc(Day, 31);
      end
      else
      begin
        Dec(Month);
        Inc(Day, 31);
      end;

    if Month in [1, 3, 5, 7, 8, 10] then
      if Day > 31 then
      begin
        Inc(Month);
        Dec(Day, 31);
      end
      else
    else if Month = 2 then
      if IsLeapYear(Year) then
        if Day > 29 then
        begin
          Inc(Month);
          Dec(Day, 29);
        end
        else
      else
        if Day > 28 then
        begin
          Inc(Month);
          Dec(Day, 28);
        end
        else
    else if Month = 12 then
      if Day > 31 then
      begin
        Inc(Year);
        Month:=1;
        Dec(Day, 31);
      end
      else
    else
      if Day > 30 then
      begin
        Inc(Month);
        Dec(Day, 30);
      end
      else;
  end;
end;

// 음력으로 큰달, 작은달 구분
function IsLunarLargeMonth(const LunarYear, LunarMonth: Integer): Boolean;
var
  solyear, solmon, solday,
  smoyear, smomonth, smoday, smohour, smomin,
  y0,mo0,d0,h0,mi0,
  y1,mo1,d1,h1,mi1: Integer;
begin // 무식한 방법으로 구현했습니다 -.-
  lunartosolar(LunarYear, LunarMonth, 15, False, solyear, solmon, solday);

  getlunarfirst(solyear,solmon,solday,
                smoyear,smomonth,smoday,smohour,smomin,
                y0,mo0,d0,h0,mi0,
                y1,mo1,d1,h1,mi1);

  if Abs(disp2days(smoyear,smomonth,smoday,y1,mo1,d1))=30 then Result:=True
  else Result:=False;
end;

// 음력 윤달이 존재하는지 확인
function IsLunarLeapMonth(LunarYear, LunarMonth: Integer): Boolean;
var
  solyear, solmon, solday, T, T2: Integer;
  ll: Boolean;
begin // 무식한 방법으로 구현했습니다 -.-
  lunartosolar(LunarYear, LunarMonth, 15, False, solyear, solmon, solday);
  T:=5;
  T2:=30;
  MinuteAdjustedTime(60*24*30, solyear, solmon, solday, T, T2);
  solortolunar(solyear, solmon, solday, LunarYear, LunarMonth, T, Result, ll);
end;

end.
