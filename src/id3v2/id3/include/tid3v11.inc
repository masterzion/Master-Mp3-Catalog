//-----------------------------------------------------------------------------
// TID3v11
// version: 2003-05-24
//-----------------------------------------------------------------------------
// this class provides methods for reading, writing and removing ID3 v1.1 tags
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
procedure TID3v11.Clear;
// clear all tag properties
begin
  Artist:='';
  Album:='';
  Title:='';
  Comment:='';
  Genre:=255;
  Year:='';
  Track:=0;
end;


//-----------------------------------------------------------------------------
function TID3v11.LoadFromStream(InStream: TStream): Boolean;
// load tag from stream InStream
var
  ID: array[0..2] of Char;
  s: String;

begin
  Result:=true;
  if InStream.Size>=128 then begin
    // seek at tag position (data size - 128)
    InStream.Seek(InStream.Size-128, soFromBeginning);
    InStream.Read(ID,3);
    if ID='TAG' then begin
      // read Title
      SetLength(s, 30);
      InStream.ReadBuffer(s[1], 30);
      Title:=Trim(s);

      // read Artist
      SetLength(s, 30);
      InStream.ReadBuffer(s[1], 30);
      Artist:=Trim(s);

      // read Album
      SetLength(s, 30);
      InStream.ReadBuffer(s[1], 30);
      Album:=Trim(s);

      // read Year
      SetLength(s, 4);
      InStream.ReadBuffer(s[1], 4);
      Year:=Trim(s);

      // read Comment
      SetLength(s, 28);
      InStream.ReadBuffer(s[1], 28);
      Comment:=Trim(s);

      // ignore zero Byte
      InStream.Seek(1, soFromCurrent);

      // read Title
      InStream.ReadBuffer(FTrack, 1);

      // read Title
      InStream.ReadBuffer(FGenre, 1);
    end
    else
      Result:=false
  end
  else
    Result:=false;
end;


//-----------------------------------------------------------------------------
function TID3v11.LoadFromFile(FileName: String): Boolean;
// load tag from file FileName
var
  fs: TFileStream;

begin
  // open for reading, deny writing
  if (FileExists(FileName)) then begin
    fs:=TFileStream.Create(FileName, fmOpenRead, fmShareDenyWrite);
    Result:=LoadFromStream(fs);
    fs.Free;
  end
  else
    Result:=false;
end;


//-----------------------------------------------------------------------------
procedure TID3v11.SaveToStream(OutStream: TStream);
// save tag to stream OutStream
var
  ID: array[0..2] of Char;
  s: String;

begin
  // try to find tag, otherwise seek at the end of file
  if OutStream.Size>=128 then begin
    // seek at tag position (data size - 128)
    OutStream.Seek(OutStream.Size-128, soFromBeginning);
    OutStream.Read(ID,3);
    if ID='TAG' then
      OutStream.Seek(OutStream.Size-128, soFromBeginning)
    else
      OutStream.Seek(OutStream.Size, soFromBeginning);
  end
  else
    OutStream.Seek(OutStream.Size, soFromBeginning);

  ID:='TAG';
  SetLength(s, 30);
  FillChar(s[1], Length(s), 0);

  // write ID 'TAG'
  OutStream.WriteBuffer(ID, 3);

  // write Title
  if Title<>'' then
    OutStream.WriteBuffer(Title[1], Min(Length(Title), 30));
  OutStream.WriteBuffer(s[1], 30-Min(Length(Title), 30));

  // write Artist
  if Artist<>'' then
    OutStream.WriteBuffer(Artist[1], Min(Length(Artist), 30));
  OutStream.WriteBuffer(s[1], 30-Min(Length(Artist), 30));

  // write Album
  if Album<>'' then
    OutStream.WriteBuffer(Album[1], Min(Length(Album), 30));
  OutStream.WriteBuffer(s[1], 30-Min(Length(Album), 30));

  // write Year
  if Year<>'' then
    OutStream.WriteBuffer(Year[1], Min(Length(Year), 4));
  OutStream.WriteBuffer(s[1], 4-Min(Length(Year), 4));

  // write Comment
  if Comment<>'' then
    OutStream.WriteBuffer(Comment[1], Min(Length(Comment), 28));
  OutStream.WriteBuffer(s[1], 28-Min(Length(Comment), 28));

  // write zero Byte
  OutStream.WriteBuffer(s[1], 1);

  // write Track
  OutStream.WriteBuffer(Track, 1);

  // write Genre
  OutStream.WriteBuffer(Genre, 1);
end;


//-----------------------------------------------------------------------------
procedure TID3v11.SaveToFile(FileName: String);
// save tag to file FileName
var
 fs: TFileStream;

begin
  if(FileExists(FileName)) then
    // open file (read+write)
    fs:=TFileStream.Create(FileName, fmOpenReadWrite, fmShareDenyWrite)
  else
    // create new file
    fs:=TFileStream.Create(FileName, fmCreate, fmShareDenyWrite);

  SaveToStream(fs);
  fs.Free;
end;


//-----------------------------------------------------------------------------
procedure TID3v11.RemoveFromStream(AStream: TStream);
// remove tag from stream AStream
var
  ID: array[0..2] of Char;

begin
  // try to find tag, otherwise seek at the end of file
  if AStream.Size>=128 then begin
    // seek at tag position (data size - 128)
    AStream.Seek(AStream.Size-128, soFromBeginning);
    AStream.Read(ID,3);
    if ID='TAG' then
      AStream.Size:=AStream.Size-128;
  end;
end;


//-----------------------------------------------------------------------------
procedure TID3v11.RemoveFromFile(FileName: String);
// remove tag from file FileName
var
 fs: TFileStream;

begin
  fs:=TFileStream.Create(FileName, fmOpenReadWrite, fmShareDenyWrite);
  RemoveFromStream(fs);
  fs.Free;
end;
