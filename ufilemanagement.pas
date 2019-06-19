unit UFileManagement;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

const
  CFileID: string[8] = 'JAMIDUSU';
  CFileVersion: Integer = 1; // 저장파일 버전
  CFileName = 'jamidusu.list';

type
  TClientInfo = record
    Yeokbeop, Sex, Ban: Integer;
    Name: string;
    Birth: string[17];
    Memo: TStringList;
  end;

  TClients = class
  public
    ClientInfo: array of TClientInfo;
    Count: Integer;
    ReadOnly: Boolean;

    procedure Add(Info: TClientInfo);
    procedure Delete(Index: Integer);
    procedure Swap(From, Toward: Integer);
    procedure Edit(Index: Integer; Memo: TStringList);

    procedure OpenFile;
    procedure SaveFile;

    constructor Create;
    destructor Destroy; override;
  private
    FileStream: TFileStream;
    FileVersion: Integer;

    function CreateFile: Boolean;
  end;

implementation

procedure TClients.OpenFile;
var
  I, Len: Integer;
  MemStream: TMemoryStream;
  FileID: string[8];
begin
  try
    if FileExists(CFileName) then
      FileStream:=TFileStream.Create(CFileName, fmOpenReadWrite or fmShareDenyWrite)
    else if not CreateFile then Exit;

  except
    on E:Exception do
      try
        ReadOnly:=True;
        FileStream:=TFileStream.Create(CFileName, fmOpenRead or fmShareDenyNone);
        ShowMessage(CFileName + ' 파일이 다른 프로그램에 의해 열려 있습니다. 읽기전용 모드로 시작합니다.');
      except
        on E:Exception do
          ShowMessage(E.Message);
      end;
  end;

  try
    with FileStream do
    begin
      Position:=0;
      ReadBuffer(FileID, SizeOf(FileID));
      if FileID <> CFileID then
      begin
        ShowMessage(CFileName + ' 파일이 잘못되었습니다. 해당 파일을 지우고 프로그램을 다시 시작해주세요.');
        ReadOnly:=True;
        Exit;
      end;

      ReadBuffer(FileVersion, SizeOf(FileVersion));
      if FileVersion > CFileVersion then
      begin
        ShowMessage(CFileName + ' 파일버전이 상위버전이라서 열 수 없습니다.  최신 버전을 이용해주세요. 읽기전용 모드로 시작합니다.');
        ReadOnly:=True;
        Exit;
      end;

      ReadBuffer(Count, SizeOf(Count));
      SetLength(ClientInfo, Count);

      try
        MemStream:=TMemoryStream.Create;

        for I:=0 to Count-1 do
          with ClientInfo[I] do
          begin
            ReadBuffer(Yeokbeop, SizeOf(Integer));
            ReadBuffer(Sex, SizeOf(Integer));
            ReadBuffer(Ban, SizeOf(Integer));
            ReadBuffer(Len, SizeOf(Len));
            SetLength(Name, Len);
            ReadBuffer(Name[1], Len);
            ReadBuffer(Birth, SizeOf(Birth));

            ReadBuffer(Len, SizeOf(Len));
            Memo:=TStringList.Create;
            if Len > 0 then
            begin
              MemStream.CopyFrom(FileStream, Len);
              MemStream.Position:=0;
              Memo.LoadFromStream(MemStream);
              MemStream.Clear;
            end;
          end;

      finally
        MemStream.Free;
      end;
    end;

  except
    on E:Exception do
    begin
      ShowMessage(CFileName + ' 파일이 잘못되었습니다. 해당 파일을 지우고 프로그램을 다시 시작해주세요.');
      ReadOnly:=True;
    end;
  end;

end;

procedure TClients.SaveFile;
var
  I, Len: Integer;
  MemStream: TMemoryStream;
begin
  if ReadOnly then Exit;

  try
    with FileStream do
    begin
      Position:=0;
      WriteBuffer(CFileID, SizeOf(CFileID));
      WriteBuffer(CFileVersion, SizeOf(CFileVersion));
      WriteBuffer(Count, SizeOf(Count));

      try
        MemStream:=TMemoryStream.Create;

        for I:=0 to Count-1 do
          with ClientInfo[I] do
          begin
            WriteBuffer(Yeokbeop, SizeOf(Integer));
            WriteBuffer(Sex, SizeOf(Integer));
            WriteBuffer(Ban, SizeOf(Integer));
            Len:=Length(Name);
            WriteBuffer(Len, SizeOf(Len));
            WriteBuffer(Name[1], Len);
            WriteBuffer(Birth, SizeOf(Birth));

            Memo.SaveToStream(MemStream);
            Len:=MemStream.Size;
            WriteBuffer(Len, SizeOf(Len));
            MemStream.Position:=0;
            MemStream.SaveToStream(FileStream);
            MemStream.Clear;
          end;

      finally
        MemStream.Free;
      end;
    end;

  except
    on E:Exception do
      ShowMessage(E.Message);
  end;
end;

function TClients.CreateFile: Boolean;
begin
  try
    FileStream:=TFileStream.Create(CFileName, fmCreate or fmOpenReadWrite or fmShareDenyWrite);

    with FileStream do
    begin
      WriteBuffer(CFileID, SizeOf(CFileID));
      WriteBuffer(CFileVersion, SizeOf(CFileVersion));
      WriteBuffer(Count, SizeOf(Count));
    end;

    Result:=True;

  except
    on E:Exception do
    begin
      ReadOnly:=True;
      Result:=False;
      ShowMessage('디스크에 ' + CFileName + ' 파일을 생성할 수 없습니다. List와 메모 기능을 쓸 수 없습니다.');
    end;
  end;
end;

procedure TClients.Add(Info: TClientInfo);
begin
  Inc(Count);
  SetLength(ClientInfo, Count);

  with ClientInfo[Count-1] do
  begin
    Yeokbeop:=Info.Yeokbeop;
    Sex:=Info.Sex;
    Ban:=Info.Ban;
    Name:=Info.Name;
    Birth:=Info.Birth;
    Memo:=TStringList.Create;
    if Info.Memo <> nil then Memo.Assign(Info.Memo);
  end;
end;

procedure TClients.Delete(Index: Integer);
var
  I: Integer;
begin
  Dec(Count);
  ClientInfo[Index].Memo.Free;
  for I:=Index to Count-1 do
    ClientInfo[I]:=ClientInfo[I+1];

  SetLength(ClientInfo, Count);
end;

procedure TClients.Swap(From, Toward: Integer);
var
  T: TClientInfo;
begin
  T:=ClientInfo[From];
  ClientInfo[From]:=ClientInfo[Toward];
  ClientInfo[Toward]:=T;
end;

procedure TClients.Edit(Index: Integer; Memo: TStringList);
begin
  ClientInfo[Index].Memo.Assign(Memo);
end;

constructor TClients.Create;
begin
  Count:=0;
  ReadOnly:=False;
  OpenFile;
end;

destructor TClients.Destroy;
var
  I: Integer;
begin
  FileStream.Free;

  for I:=0 to Count-1 do
    ClientInfo[I].Memo.Free;

  SetLength(ClientInfo, 0);

  inherited Destroy;
end;

end.

