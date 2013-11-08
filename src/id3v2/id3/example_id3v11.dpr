//-----------------------------------------------------------------------------
// ID3v11 example
// version: 2003-05-24
//-----------------------------------------------------------------------------
// this program is example how to read ID3v1.1 tag info from file
//-----------------------------------------------------------------------------

{$ifdef FPC}
  // switch FreePascal compiler to ObjFpc mode
  {$Mode ObjFpc}
{$else}
  // console application for Delphi
  {$AppType Console}
{$endif}

uses id3v11;

var
  i: TID3v11;
  FileName: String;

begin
  FileName:='example_id3v11.tag';
  i:=TID3v11.create(nil);
  i.LoadFromFile(FileName);

  WriteLn('ID3v1.1 tag from "'+FileName+'"');
  WriteLn('--------------------');
  WriteLn('Title:   ' , i.Title);
  WriteLn('Artist:  ', i.Artist);
  WriteLn('Album:   ', i.Album);
  WriteLn('Comment: ', i.Comment);
  WriteLn('Year:    ', i.Year);
  Write(  'Genre:   ');
  if (i.Genre<Length(ID3v11Genres)) then
    WriteLn(ID3v11Genres[i.Genre])
  else
    WriteLn('unknown genre');
  WriteLn('Track:   ', i.Track);
  WriteLn('Press Enter to continue...');
  ReadLn;

  i.free;
end.
