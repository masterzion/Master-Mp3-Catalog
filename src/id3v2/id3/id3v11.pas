//-----------------------------------------------------------------------------
// TID3v11
// version: 2003-05-24
//-----------------------------------------------------------------------------
// this class provides methods for reading, writing and removing ID3 v1.1 tags
//
// genre names are stored in ID3v11Genres
// to avoid array index overflow don't forget to check if Genre<>255 (no genre)
//-----------------------------------------------------------------------------

{$ifdef FPC}
  {$mode ObjFpc}
{$endif}

unit ID3v11;

INTERFACE

uses Classes, SysUtils, Math;

const
 ID3v11Genres : array[0..147] of String=(
  'Blues',
  'Classic Rock',
  'Country',
  'Dance',
  'Disco',
  'Funk',
  'Grunge',
  'Hip-Hop',
  'Jazz',
  'Metal',
  'New age',
  'Oldies',
  'Other',
  'Pop',
  'R&B',
  'Rap',
  'Reggae',
  'Rock',
  'Techno',
  'Industrial',
  'Alternative',
  'Ska',
  'Death metal',
  'Pranks',
  'Soundtrack',
  'Euro-Techno',
  'Ambient',
  'Trip-Hop',
  'Vocal',
  'Jazz+Funk',
  'Fusion',
  'Trance',
  'Classical',
  'Instrumental',
  'Acid',
  'House',
  'Game',
  'Sound Clip',
  'Gospel',
  'Noise',
  'Alt. Rock',
  'Bass',
  'Soul',
  'Punk',
  'Space',
  'Meditative',
  'Instrumental Pop',
  'Instrumental Rock',
  'Ethnic',
  'Gothic',
  'Darkwave',
  'Techno-Industrial',
  'Electronic',
  'Pop-folk',
  'Eurodance',
  'Dream',
  'Southern Rock',
  'Comedy',
  'Cult',
  'Gangsta Rap',
  'Top 40',
  'Christian Rap',
  'Pop/Funk',
  'Jungle',
  'Native American',
  'Cabaret',
  'New Wave',
  'Psychadelic',
  'Rave',
  'Showtunes',
  'Trailer',
  'Lo-Fi',
  'Tribal',
  'Acid Punk',
  'Acid Jazz',
  'Polka',
  'Retro',
  'Musical',
  'Rock & Roll',
  'Hard Rock',
  'Folk',
  'Folk/Rock',
  'National Folk',
  'Swing',
  'Fast-Fusion',
  'Bebop',
  'Latin',
  'Revival',
  'Celtic',
  'Bluegrass',
  'Avantgarde',
  'Gothic Rock',
  'Progressive Rock',
  'Psychedelic Rock',
  'Symphonic Rock',
  'Slow Rock',
  'Big Band',
  'Chorus',
  'Easy Listening',
  'Acoustic',
  'Humour',
  'Speech',
  'Chanson',
  'Opera',
  'Chamber Music',
  'Sonata',
  'Symphony',
  'Booty Bass',
  'Primus',
  'Porn Groove',
  'Satire',
  'Slow Jam',
  'Club',
  'Tango',
  'Samba',
  'Folklore',
  'Ballad',
  'Power Ballad',
  'Rhytmic Soul',
  'Freestyle',
  'Duet',
  'Punk Rock',
  'Drum Solo',
  'A Capella',
  'Euro-House',
  'Dance Hall',
  'Goa',
  'Drum & Bass',
  'Club-House',
  'Hardcore',
  'Terror',
  'Indie',
  'BritPop',
  'Negerpunk',
  'Polsk Punk',
  'Beat',
  'Christian Gangsta Rap',
  'Heavy Metal',
  'Black Metal',
  'Crossover',
  'Contemporary Christian',
  'Cristian Rock',
  'Merengue',
  'Salsa',
  'Thrash Metal',
  'Anime',
  'JPop',
  'Synthpop'
 );

type
  TID3v11 = class(TComponent)
  private
    FTitle: String;
    FArtist: String;
    FAlbum: String;
    FComment: String;
    FYear: String;
    FTrack: Byte;
    FGenre: Byte;
  public
    procedure Clear;
    function LoadFromStream(InStream: TStream): Boolean;
    function LoadFromFile(FileName: String): Boolean;
    procedure SaveToStream(OutStream: TStream);
    procedure SaveToFile(FileName: String);
    procedure RemoveFromStream(AStream: TStream);
    procedure RemoveFromFile(FileName: String);
  published
    property Title: String read FTitle write FTitle;
    property Artist: String read FArtist write FArtist;
    property Album: String read FAlbum write FAlbum;
    property Comment: String read FComment write FComment;
    property Year: String read FYear write FYear;
    property Track: Byte read FTrack write FTrack;
    property Genre: Byte read FGenre write FGenre;
  end;


//-----------------------------------------------------------------------------
IMPLEMENTATION

{$I include\tid3v11.inc}

end.

