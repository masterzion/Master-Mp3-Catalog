//-----------------------------------------------------------------------------
// ID3v2 example
// version: 2003-05-24
//-----------------------------------------------------------------------------
// this program is example how to read ID3v2 tag
// info from file (using TSimpleID3v2)
//-----------------------------------------------------------------------------

{$ifdef FPC}
  // switch FreePascal compiler to ObjFpc mode
  {$mode ObjFpc}
{$else}
  // console application for Delphi
  {$AppType Console}
{$endif}

uses simple_id3v2;

var
  i: TSimpleID3v2;
  FileName: String;

begin
  FileName:='example_id3v2.tag';
  i:=TSimpleID3v2.create(nil);
  i.LoadFromFile(FileName);

  WriteLn('ID3v2 tag from "'+FileName+'"');
  WriteLn('--------------------');
  WriteLn('Title:   ' , i.Title);
  WriteLn('Artist:  ', i.Artist);
  WriteLn('Album:   ', i.Album);
  WriteLn('Year:    ', i.Year);
  WriteLn('Genre:   ', i.Genre);
  WriteLn('Track:   ', i.Track);
  WriteLn('Press Enter to continue...');
  ReadLn;

  i.free;
end.

