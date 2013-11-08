//-----------------------------------------------------------------------------
// methods used by TID3v2 and other classes
// version: 2003-05-24
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
function GetSSLongword(const l: Longword): Longword;
// get sync-safe longword
begin
  Result:=
     ((l shr 24 )and $7F)+
    (((l shr 16 )and $7F)*$80)+
    (((l shr  8 )and $7F)*$4000)+
    (( l         and $7F)*$200000);
end;


// ----------------------------------------------------------------------------
function SetSSLongword(const l: Longword): Longword;
// set sync-safe longword
begin
 Result:=
     (l        and $7F)*$1000000+
    ((l shr  7)and $7F)*$10000+
    ((l shr 14)and $7F)*$100+
    ((l shr 21)and $7F);
end;


// ----------------------------------------------------------------------------
function NeedUnSync(InStream: TStream): Boolean;
// is unsynchronization of InStream really needed?
var
  i: Integer;
  Buffer: array[0..1] of Byte;

begin
  Result:=false;
  Buffer[0]:=0;
  Buffer[1]:=0;
  InStream.Seek(0, soFromBeginning);

  if InStream.Size>1 then
    InStream.Read(Buffer[1 mod 2], 1);

  i:=2;
  while (i<InStream.Size) and (not(Result)) do begin
    InStream.Read(Buffer[i mod 2], 1);
    if (Buffer[(i-1) mod 2]=$FF) and ((Buffer[i mod 2] and $E0)=$E0) then
      Result:=true;
    inc(i);
  end;
end;


// ----------------------------------------------------------------------------
procedure UnSynchronize(AStream: TStream);
// UnSynchronization of AStream
const
  zero: Byte=0; 

var
  i: Integer;
  ms: TMemoryStream;
  Buffer: array[0..1] of Byte;

begin
  ms:=TMemoryStream.Create;
  AStream.Seek(0, soFromBeginning);

  if AStream.Size>1 then begin
    AStream.ReadBuffer(Buffer[1 mod 2], 1);
    ms.WriteBuffer(Buffer[1 mod 2], 1);
  end;

  i:=2;
  while (i<=AStream.Size) do begin
    AStream.ReadBuffer(Buffer[i mod 2], 1);

    if (Buffer[(i-1) mod 2]=$FF) and
       (((Buffer[i mod 2] and $E0)=$E0) or ((Buffer[i mod 2]=$00))) then begin
      ms.WriteBuffer(zero, 1);
    end;

    ms.WriteBuffer(Buffer[i mod 2], 1);
    inc(i);
  end;

  AStream.Size:=0;
  AStream.Seek(0, soFromBeginning);
  AStream.CopyFrom(ms, 0);
  ms.Free;
end;


// ----------------------------------------------------------------------------
procedure Synchronize(AStream: TStream);
// Synchronization of AStream
var
  i: Integer;
  ms: TMemoryStream;
  Buffer: array[0..1] of Byte;

begin
  ms:=TMemoryStream.Create;
  AStream.Seek(0, soFromBeginning);

  if AStream.Size>1 then begin
    AStream.ReadBuffer(Buffer[1 mod 2], 1);
    ms.WriteBuffer(Buffer[1 mod 2], 1);
  end;

  i:=2;
  while (i<=AStream.Size) do begin
    AStream.Read(Buffer[i mod 2], 1);
    if not((Buffer[(i-1) mod 2]=$FF) and (Buffer[i mod 2]=$00)) then
      ms.WriteBuffer(Buffer[i mod 2], 1);
    inc(i);
  end;

  AStream.CopyFrom(ms, 0);
  AStream.Seek(0, soFromBeginning);
  ms.Free;
end;


//------------------------------------------------------------------------------
function CompareFrames(Item1, Item2: Pointer): Integer;
// compare function for frame sorting
begin
  Result:=CompareText(TID3v2CustomFrame(Item1).ID, TID3v2CustomFrame(Item2).ID);
end;


//------------------------------------------------------------------------------
function ID3v2Trim(s: String): String;
// improved Trim function
var
 i: Integer;
 
begin
  Result:='';
  for i:=1 to Length(s) do
    if not(s[i] in [#0..#9,#11,#12,#14..#31,#255]) then 
      Result:=Result+s[i];
end;
