// ----------------------------------------------------------------------------
function TID3v2FrameList.GetItem(Index: Integer): TID3v2CustomFrame;
begin
  Result:=TID3v2CustomFrame(inherited GetItem(Index));
end;


// ----------------------------------------------------------------------------
procedure TID3v2FrameList.SetItem(Index: Integer; Value: TID3v2CustomFrame);
begin
//  inherited SetItem(Index, TObject(Value));
  inherited SetItem(Index, Value);
end;


// ----------------------------------------------------------------------------
function TID3v2FrameList.GetFrame(ID: String): TID3v2CustomFrame;
var
  i: Integer;

begin
  Result:=nil;
  for i:=0 to Count-1 do
    if Items[i].ID=ID then Result:=Items[i];
end;


// ----------------------------------------------------------------------------
procedure TID3v2FrameList.SetFrame(ID: String; Value: TID3v2CustomFrame);
var
  i: integer;

begin
  for i:=0 to Count-1 do
    if Items[i].ID=ID then Items[i]:=Value;
end;


// ----------------------------------------------------------------------------
function TID3v2FrameList.Add(AFrame: TID3v2CustomFrame): Integer;
// add new frame into framelist
// to avoid multiple frame IDs use UpdateOrAdd method
begin
  result:=0;
  if AFrame<>nil then begin
    AFrame.FParent:=self;
    Result:=inherited Add(AFrame);
  end;
end;


//-----------------------------------------------------------------------------
procedure TID3v2FrameList.UpdateOrAdd(AFrame: TID3v2CustomFrame);
// update frame (if present) otherwise create new frame
begin
  if Frames[AFrame.ID]<>nil then
    Delete(AFrame.ID);
  Add(AFrame)
end;


//-----------------------------------------------------------------------------
procedure TID3v2FrameList.Delete(Index: Integer);
// delete frame with index Index
begin
  inherited Delete(Index);
  Pack;
end;


//-----------------------------------------------------------------------------
procedure TID3v2FrameList.Delete(ID: String);
// delete frame with index ID
begin
  Delete(IndexOf(Frames[ID]));
end;



//-----------------------------------------------------------------------------
procedure TID3v2FrameList.Sort;
// sort frames by ID
// sorting of frames isn't mandatory,
// but it is useful to keep same order of frames

begin
  inherited Sort(@CompareFrames);
end;


// ----------------------------------------------------------------------------
procedure TID3v2FrameList.SaveToStream(OutStream: TStream);
// save all frames to OutStream

begin
  SaveToStream(OutStream, nil);
end;

procedure TID3v2FrameList.SaveToStream(OutStream: TStream; Framelist: TStrings);
// save frames to OutStream; save only frames included in FrameList
var
 i: Integer;

begin
  if Assigned(FrameList) then begin
    // save only frames included in FrameList
    for i:=0 to FrameList.Count-1 do begin
      if Frames[FrameList.Strings[i]]<>nil then
        Frames[FrameList.Strings[i]].SaveToStream(OutStream);
    end;
  end
  else begin
    // save all frames
    for i:=0 to Count-1 do
      Items[i].SaveToStream(OutStream);
  end;
end;


// ----------------------------------------------------------------------------
function TID3v2FrameList.LoadFromStream(InStream: TStream): Boolean;
// load all frames from InStream
var
  FrameID: array[0..3] of char;
  f: TID3v2CustomFrame;

begin
  Result:=true;

  with InStream do begin
    Read(FrameID[0], 4);

    // FrameID must be alphanumerical
    if not( (FrameID[0] in ['A'..'Z', '0'..'9']) or
            (FrameID[1] in ['A'..'Z', '0'..'9']) or
            (FrameID[2] in ['A'..'Z', '0'..'9']) or
            (FrameID[3] in ['A'..'Z', '0'..'9']) ) then
      Result:=false
    else begin
      if FrameID='TXXX' then
        f:=TID3v2xXXXFrame.Create(FrameID)
      else if FrameID='WXXX' then
        f:=TID3v2xXXXFrame.Create(FrameID)
      else if FrameID[0]='T' then
        f:=TID3v2TextFrame.Create(FrameID)
      else if FrameID[0]='W' then
        f:=TID3v2UrlFrame.Create(FrameID)
      else
        f:=TID3v2Frame.Create(FrameID);

      f.LoadFromStream(InStream); // read & parse frame
      UpdateOrAdd(f);
    end;
  end;
end;

