//-----------------------------------------------------------------------------
// TSimple_ID3v2
// version: 2003-05-24
//-----------------------------------------------------------------------------
// this component is example of TID3v2 usage 
//-----------------------------------------------------------------------------


unit simple_ID3v2;

{$ifdef FPC}
  // switch FreePascal compiler to ObjFpc mode
  {$mode ObjFpc}
{$endif}

interface

uses Classes, id3v2;

type
//-----------------------------------------------------------------------------
  TTagVersion = (tvID3v23, tvID3v24);

//-----------------------------------------------------------------------------
  TSimpleID3v2 = class (TComponent)
  private
    FArtist: String;
    FAlbum: String;
    FTitle: String;
    FGenre: String;
    FYear: String;
    FTrack: String;
    FVersion: TTagVersion;
  protected
  public
    procedure SaveToFile(FileName: String);
    procedure LoadFromFile(FileName: String);
  published
    property Artist: String read FArtist write FArtist;
    property Title: String read FTitle write FTitle;
    property Album: String read FAlbum write FAlbum;
    property Genre: String read FGenre write FGenre;
    property Year: String read FYear write FYear;
    property Track: String read FTrack write FTrack;
    property Version: TTagVersion read FVersion write FVersion;
  end;
  
implementation


//-----------------------------------------------------------------------------
procedure TSimpleID3v2.LoadFromFile(FileName: String);
var
 i: TID3v2;
 t:TID3v2TextFrame;
 
begin
  i:=TID3v2.Create(nil);
  Title:='';
  Artist:='';
  Album:='';
  Genre:='';
  Year:='';
  Track:='';
  
  i.LoadFromFile(FileName);

  if (i.VerMajor=3) then
    Version:=tvID3v23
  else if (i.VerMajor=4) then
    Version:=tvID3v24;
  
  t:=TID3v2TextFrame(i.Frames.Frames['TIT2']);
  if Assigned(t) then
    Title:=t.Text;

  t:=TID3v2TextFrame(i.Frames.Frames['TPE1']);
  if Assigned(t) then
    Artist:=t.Text;
    
  t:=TID3v2TextFrame(i.Frames.Frames['TALB']);
  if Assigned(t) then
    Album:=t.Text;
    
  t:=TID3v2TextFrame(i.Frames.Frames['TCON']);
  if Assigned(t) then
    Genre:=t.Text;

  if i.VerMajor=3 then
    t:=TID3v2TextFrame(i.Frames.Frames['TYER'])
  else
    t:=TID3v2TextFrame(i.Frames.Frames['TDRL']);
  if Assigned(t) then
    Year:=t.Text;

  t:=TID3v2TextFrame(i.Frames.Frames['TRCK']);
  if Assigned(t) then
    Track:=t.Text;

  i.Free;
end;


//-----------------------------------------------------------------------------
procedure TSimpleID3v2.SaveToFile(FileName: String);
var
  i: TID3v2;
  t: TID3v2TextFrame;
 
begin
  i:=TID3v2.Create(nil);

  if (Version=tvID3v23) then
    i.VerMajor:=3
  else if (Version=tvID3v24) then
    i.VerMajor:=4;

  t:=TID3v2TextFrame.Create('TIT2');
  t.Text:=Title;
  i.Frames.UpdateOrAdd(t);
  
  t:=TID3v2TextFrame.Create('TPE1');
  t.Text:=Artist;
  i.Frames.UpdateOrAdd(t);

  t:=TID3v2TextFrame.Create('TALB');
  t.Text:=Album;
  i.Frames.UpdateOrAdd(t);

  t:=TID3v2TextFrame.Create('TCON');
  t.Text:=Genre;
  i.Frames.UpdateOrAdd(t);

  t:=TID3v2TextFrame.Create('TYER');
  t.Text:=Year;
  i.Frames.UpdateOrAdd(t);

  t:=TID3v2TextFrame.Create('TRCK');
  if (Version=tvID3v24) then t.ID:='TDRL';
  t.Text:=Track;
  i.Frames.UpdateOrAdd(t);

  i.VerMinor:=0;
  i.Experimental:=false;
  i.Padding:=512;
  i.SaveToFile(FileName);
  i.Free;
end;

end.

