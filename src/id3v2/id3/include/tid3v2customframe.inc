//-----------------------------------------------------------------------------
// ID3v2CustomFrame
// version: 2003-05-24
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
constructor TID3v2CustomFrame.Create(aID: String);
begin
  inherited Create;
  FID:=aID;
end;


//-----------------------------------------------------------------------------
procedure TID3v2CustomFrame.SaveToStream(OutStream: TStream);
// save frame data to OutStream
var
  Size: Longword;
  Flags: Word;
  ms: TMemoryStream;

begin
  ms:=TMemoryStream.Create;
  SetData(ms); // data conversion is done in this virtual method

  if ms.Size=0 then begin
    // frame MUST be non-empty, -> write #0 to frame
    Flags:=0;
    ms.Write(Flags, 1);
  end;

  Flags:=0;

  // unsynchronization (v2.4.x only)
  if (Parent.Parent.VerMajor=4) and (NeedUnSync(ms)) then begin
    Flags:=Flags or $0200;
    UnSynchronize(ms);
  end;

  Size:=SetSSLongword(ms.Size);
  OutStream.WriteBuffer(ID[1], 4);
  OutStream.WriteBuffer(Size, 4);
  OutStream.WriteBuffer(Flags, 2);
  ms.SaveToStream(OutStream);
  ms.Free;
end;


//-----------------------------------------------------------------------------
procedure TID3v2CustomFrame.LoadFromStream(InStream: TStream);
// load frame data into InStream
var
  aSize: Longword;
  Flags: Word;
  ms: TMemoryStream;

begin
  ms:=TMemoryStream.Create;

  InStream.Read(aSize, 4);
  InStream.Read(Flags, 2);
  aSize:=GetSSLongword(aSize);

  ms.CopyFrom(InStream, aSize);

  // synchronization (v2.4.x only)
  try
    if (Flags and $0200)=$0200 then Synchronize(ms);
  except end;

  GetData(ms);
  ms.Free;
end;


//-----------------------------------------------------------------------------
procedure TID3v2Frame.GetData(InStream: TStream);
// read raw data from InStream
begin
  InStream.Seek(0, soFromBeginning);
  SetLength(FData, InStream.Size);
  InStream.ReadBuffer(FData[1], InStream.Size);
end;


//-----------------------------------------------------------------------------
procedure TID3v2Frame.SetData(OutStream: TStream);
// write raw data to OutStream
begin
  OutStream.WriteBuffer(FData[1], Length(FData));
end;


//-----------------------------------------------------------------------------
procedure TID3v2TextFrame.GetData(InStream: TStream);
// read text frame data from InStream
var
  Encoding: byte;

begin
  InStream.Seek(0, soFromBeginning);
  InStream.ReadBuffer(Encoding, 1);
  // Encoding can be used for UTF-8 or Unicode support in future
  SetLength(FText, InStream.Size-1);
  InStream.ReadBuffer(FText[1], InStream.Size-1);
  Text:=ID3v2Trim(Text);
end;


//-----------------------------------------------------------------------------
procedure TID3v2TextFrame.SetData(OutStream: TStream);
// write text frame data to OutStream
var
  Data: String;

begin
//  case Encoding of ... (Unicode & UTF-8 is not supported now)
  Data:=#0+ID3v2Trim(Text)+#0;
  OutStream.WriteBuffer(Data[1], Length(Data));
end;


//-----------------------------------------------------------------------------
procedure TID3v2xXXXFrame.GetData(InStream: TStream);
// read WXXX or TXXX data from InStream
var
  Data: String;
  Encoding: Byte;

begin
  InStream.Seek(0, soFromBeginning);
  InStream.ReadBuffer(Encoding, 1);
  SetLength(Data, InStream.Size-1);
  InStream.ReadBuffer(Data[1], InStream.Size-1);
//  Data:=ID3v2Trim(Data);
  Description:=copy(Data, 1, pos(#0, Data)-1);
  Value:=ID3v2Trim(copy(Data, pos(#0, Data)+1, Length(Data)));
end;


//-----------------------------------------------------------------------------
procedure TID3v2xXXXFrame.SetData(OutStream: TStream);
// write WXXX or TXXX data to OutStream
var
  Data: String;

begin
  Data:=#0+ID3v2Trim(Description)+#0+ID3v2Trim(Value)+#0;
  OutStream.WriteBuffer(Data[1], Length(Data));
end;


//-----------------------------------------------------------------------------
procedure TID3v2UrlFrame.GetData(InStream: TStream);
// read Wxxx data from InStream
begin
  SetLength(Url, InStream.Size);
  InStream.ReadBuffer(Url[1], Length(Url));
  Url:=ID3v2Trim(Url);
end;


//-----------------------------------------------------------------------------
procedure TID3v2UrlFrame.SetData(OutStream: TStream);
// write Wxxx data to OutStream
var
  Data: String;

begin
  Data:=ID3v2Trim(Url)+#0;
  OutStream.WriteBuffer(Data[1], Length(Data));
end;

