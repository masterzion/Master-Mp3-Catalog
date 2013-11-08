//-----------------------------------------------------------------------------
// TID3v11 class
// version: 2003-05-24
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
constructor TID3v2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFrames:=TID3v2FrameList.Create;
  FFrames.FParent:=self;
end;


//-----------------------------------------------------------------------------
destructor TID3v2.Destroy;
begin
  Frames.Free;
  inherited Destroy;
end;


//-----------------------------------------------------------------------------
function TID3v2.GetTagSize(InStream: TStream): Integer;
// get total tag size (incl. header and footer) from InStream
var
  h: TID3v2Header;
  Position: Longword;

begin
  Result:=0;
  Position:=InStream.Position;
  h:=LoadHeaderFromStream(InStream);
  if ( (h.ID='ID3') and (h.VerMajor>=3) ) then begin
    inc(Result, 10); // header
    inc(Result, h.Size); // tag + padding
    if (h.Flags and $10)=$10 then inc(Result, 10); // footer
  end;
  InStream.Seek(Position, soFromBeginning);
end;


//-----------------------------------------------------------------------------
function TID3v2.GetTagSize(FileName: String): Integer;
// get total tag size (incl. header and footer) from file FileName
var
  fs: TFileStream;

begin
  fs:=TFileStream.Create(FileName, fmOpenRead, fmShareDenyWrite);
  Result:=GetTagSize(fs);
  fs.Free;
end;


//-----------------------------------------------------------------------------
procedure TID3v2.SaveToStream(OutStream :TStream);
// save tag to OutStream
begin
  SaveToStream(OutStream, nil);
end;


//-----------------------------------------------------------------------------
procedure TID3v2.SaveToStream(OutStream : TStream; FrameList: TStrings);
// save tag to OutStream; save only frames included in FrameList
const
  zero: Byte=0;
  id_ID3='ID3';
  id_3DI='3DI';
  
var
  ms: TMemoryStream;
  FrameMS: TMemoryStream;
  Flags: Byte;
  FooterSize: Byte;
  NewTagSize: Longword;
  l: Longword;
  OldTagSize: Longword;

begin
  ms:=TMemoryStream.Create;
  FrameMS:=TMemoryStream.Create;
  OldTagSize:=GetTagSize(OutStream);
  FooterSize:=0;
  Flags:=0;

  // save frames to FrameMS
  Frames.SaveToStream(FrameMS, FrameList);
  if FrameMS.Size<>0 then begin
    // tag isn't empty -> save it

    // footer
    if (Footer) and (VerMajor=4) then begin
      FooterSize:=10;
      Flags:=Flags or $10;
    end;

    // experimental
    if Experimental then
      Flags:=Flags or $20;

    // unsynchronization
    if (VerMajor=3) and (NeedUnSync(FrameMS)) then begin
      UnSynchronize(FrameMS);
      Flags:=Flags or $80;
    end;

    // write at least one #0 at the end of tag
    if Padding<=0 then Padding:=1;

    NewTagSize:=Padding*Ceil((FrameMS.Size+10+FooterSize)/Padding)-10-FooterSize;

    // write padding to FrameMS
    while FrameMS.Size<NewTagSize do
      FrameMS.WriteBuffer(zero, 1);

    with ms do begin
      // write header
      Write(id_ID3[1], 3);
      Write(VerMajor, 1);
      Write(VerMinor, 1);
      Write(Flags, 1);
      l:=SetSSLongWord(NewTagSize);
      Write(l, 4);

      // copy frames to ms
      FrameMS.SaveToStream(ms);

      if (Footer) and (VerMajor=4) then begin
        // write footer
        WriteBuffer(id_3DI[1], 3);
        Write(VerMajor, 1);
        Write(VerMinor, 1);
        Write(Flags, 1);
        l:=SetSSLongWord(ms.Size);
        Write(l, 4);
      end;
    end;

//    if OldTagSize=NewTagSize+10+FooterSize then begin
    if OldTagSize=ms.Size then begin
      // replace old tag
      OutStream.Seek(0, soFromBeginning);
      ms.SaveToStream(OutStream);
//      OutStream.CopyFrom(ms, ms.Size);
    end
    else begin
      // delete old tag & write new one
      OutStream.Seek(OldTagSize, soFromBeginning);
      ms.CopyFrom(OutStream, OutStream.Size-OldTagSize);
      OutStream.Size:=0;
      OutStream.Seek(0, soFromBeginning);
      ms.SaveToStream(OutStream);
    end;

  end
  else
    RemoveFromStream(OutStream);

  FrameMS.Free;
  ms.Free;
end;


//-----------------------------------------------------------------------------
procedure TID3v2.SaveToFile(FileName: string);
// save tag to file FileName
begin
  SaveToFile(FileName, nil);
end;


//-----------------------------------------------------------------------------
procedure TID3v2.SaveToFile(FileName: string; FrameList: TStrings);
// save tag to file FileName; save only frames included in FrameList
var
 fs: TFileStream;

begin
  if(FileExists(FileName)) then
    fs:=TFileStream.Create(FileName, fmOpenReadWrite, fmShareDenyWrite)
  else
    fs:=TFileStream.Create(FileName, fmCreate, fmShareDenyWrite);

  SaveToStream(fs, FrameList);
  fs.Free;
end;

//-----------------------------------------------------------------------------
procedure TID3v2.LoadFromFile(const FileName: string);
// load tag from file FileName
var
  fs: TFileStream;

begin
  // open for reading, deny writing
  if (FileExists(FileName)) then begin
    fs:=TFileStream.Create(FileName, fmOpenRead, fmShareDenyWrite);
    LoadFromStream(fs);
    fs.Free;
  end;
end;


//-----------------------------------------------------------------------------
procedure TID3v2.LoadFromStream(InStream : TStream);
// load tag from InStream
var
  h: TID3v2Header;
  ExtSize: longword;
  ms: TMemoryStream;

begin
  ms:=TMemoryStream.Create;

  h:=LoadHeaderFromStream(InStream);
  if ( (h.ID='ID3') and (h.VerMajor>=3) ) then begin
    VerMajor:=h.VerMajor;
    VerMinor:=h.VerMinor;
    ms.CopyFrom(InStream, h.size);
    ms.seek(0, sofrombeginning);

    with ms do begin
      // unsynchronization (2.3 only)
      if ((VerMajor=3) and ((h.Flags and $80)=$80)) then begin
        Synchronize(ms);
      end;

      // skip extended header (if present)
      if ((h.Flags and $40)=$40) then begin
        ReadBuffer(ExtSize, 4);
        ExtSize:=GetSSLongword(ExtSize);
        Seek(ExtSize, soFromCurrent);
      end;

      // experimental
      if ((h.Flags and $20)=$20) then begin
        Experimental:=True;
      end;

      // footer (not included in tag size)
      if ((h.Flags and $10)=$10) then begin
      end;

      // frame size MUST BE > 11B  -> Size-11
      while (Position<Size-11)and
            (Frames.LoadFromStream(ms)=true) do ;

    end;
  end;

  ms.Free;
end;



//-----------------------------------------------------------------------------
function TID3v2.LoadHeaderFromStream(InStream: TStream): TID3v2Header;
// load tag header from InStream
begin
  FillChar(Result, SizeOf(Result), 0);
  with InStream do begin
    Read(Result.ID[0], 3);
    Read(Result.VerMajor, 1);
    Read(Result.VerMinor, 1);
    Read(Result.Flags, 1);
    Read(Result.Size, 4);
  end;
  Result.Size:=GetSSLongword(Result.Size);
end;


//-----------------------------------------------------------------------------
procedure TID3v2.RemoveFromStream(AStream: TStream);
// remove tag from Astream
var
  ms: TMemoryStream;
  OldTagSize: Longword;

begin
  ms:=TMemoryStream.Create;
  OldTagSize:=GetTagSize(AStream);
  if OldTagSize<>0 then begin
    // tag is present -> remove it
    AStream.Seek(OldTagSize, soFromBeginning);
    ms.CopyFrom(AStream, AStream.Size-OldTagSize);
    AStream.Size:=0;
    AStream.Seek(0, soFromBeginning);
    ms.SaveToStream(AStream);
  end;
  ms.Free;
end;


//-----------------------------------------------------------------------------
procedure TID3v2.RemoveFromFile(FileName: string);
// remove tag from file FileName
var
  fs: TFileStream;

begin
  fs:=TFileStream.Create(FileName, fmOpenReadWrite, fmShareDenyWrite);
  RemoveFromStream(fs);
  fs.Free;
end;

