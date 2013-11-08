//-----------------------------------------------------------------------------
// TID3v2
// version: 2003-05-24
//-----------------------------------------------------------------------------
// this class provides methods for reading, writing and removing ID3v2 tags
//-----------------------------------------------------------------------------

unit ID3v2;

{$ifdef FPC}
  // switch FreePascal compiler to ObjFpc mode
  {$mode ObjFpc}
{$endif}

interface

uses Classes, Contnrs, SysUtils, Math ;

type
//-----------------------------------------------------------------------------
 TID3v2 = class;
 TID3v2FrameList = class;
 TID3v2CustomFrame = class;
 TID3v2Frame = class;
 TID3v2TextFrame = class;
 TID3v2UrlFrame = class;
 TID3v2xXXXFrame = class;


//-----------------------------------------------------------------------------
  TID3v2Header = record
    ID: array[0..2] of Char;
    VerMajor: Byte;
    VerMinor: Byte;
    Flags: Byte;
    Size: Longword;
  end;


//-----------------------------------------------------------------------------
  TID3v2 = class(TComponent)
  private
    FFrames: TID3v2FrameList;
    FPadding: Integer;
    FVerMajor: Byte;
    FVerMinor: Byte;
    FExperimental: Boolean;
    FFooter: Boolean; // v2.4.x only
    function LoadHeaderFromStream(InStream: TStream): TID3v2Header;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromStream(InStream: TStream);
    procedure LoadFromFile(const FileName: String);
    procedure SaveToStream(OutStream : TStream);
      overload;
    procedure SaveToStream(OutStream : TStream; FrameList: TStrings);
      overload;
    procedure SaveToFile(FileName: String);
      overload;
    procedure SaveToFile(FileName: String;  FrameList: TStrings);
      overload;
    procedure RemoveFromStream(AStream : TStream);
    procedure RemoveFromFile(FileName: String);
    function GetTagSize(InStream: TStream): Integer; overload;
    function GetTagSize(FileName: String): Integer; overload;
    property Frames: TID3v2FrameList read FFrames;
  published
    property Padding: Integer read FPadding write FPadding
      stored true default 512;
    property VerMajor: byte read FVerMajor write FVerMajor
      stored true default 3;
    property VerMinor: byte read FVerMinor write FVerMinor
      stored true default 0;
    property Experimental: Boolean read FExperimental write FExperimental;
    property Footer: Boolean read FFooter write FFooter default false;
  end;


//-----------------------------------------------------------------------------
  TID3v2FrameList = class(TObjectList)
  private
    FParent: TID3v2;
    function GetItem(Index: Integer): TID3v2CustomFrame;
    function GetFrame(ID: String): TID3v2CustomFrame;
    procedure SetItem(Index: Integer; Value: TID3v2CustomFrame);
    procedure SetFrame(ID: String; Value: TID3v2CustomFrame);
  protected
  public
    property Items[Index: Integer]: TID3v2CustomFrame read GetItem write SetItem;
    property Frames[ID: String]: TID3v2CustomFrame read GetFrame write SetFrame;
    property Parent: TID3v2 read FParent;
    procedure SaveToStream(OutStream : TStream);
      overload;
    procedure SaveToStream(OutStream : TStream; FrameList: TStrings);
      overload;
    function LoadFromStream(InStream: TStream): boolean;
    function Add(AFrame: TID3v2CustomFrame): Integer;
    procedure UpdateOrAdd(AFrame: TID3v2CustomFrame);
    procedure Delete(ID: String); overload;
    procedure Delete(Index: Integer); overload;
    procedure Sort;
  end;


//-----------------------------------------------------------------------------
  TID3v2CustomFrame = class (TObject)
  private
    FParent: TID3v2FrameList;
    FID: String;
  protected
    procedure GetData(InStream: TStream); virtual; abstract;
    procedure SetData(OutStream: TStream); virtual; abstract;
  public
    property ID: String read FID write FID;
    property Parent: TID3v2FrameList read FParent;// write FParent;
    constructor Create(aID: string);
    procedure LoadFromStream(InStream: TStream);
    procedure SaveToStream(OutStream: TStream);
  end;


//-----------------------------------------------------------------------------
  TID3v2Frame = class (TID3v2CustomFrame)
  private
    FData: AnsiString;
  protected
    procedure GetData(InStream: TStream); override;
    procedure SetData(OutStream: TStream); override;
  public
    property Data: AnsiString read FData write FData;
  end;


//-----------------------------------------------------------------------------
  // class for Txxx (text) frames
  TID3v2TextFrame = class (TID3v2CustomFrame)
  private
    FText: String;
  protected
    procedure GetData(InStream: TStream); override;
    procedure SetData(OutStream: TStream); override;
  public
    property Text: String read FText write FText;
  end;


//-----------------------------------------------------------------------------
  // class for TXXX and WXXX frames
  TID3v2xXXXFrame = class (TID3v2CustomFrame)
  protected
    procedure GetData(InStream: TStream); override;
    procedure SetData(OutStream: TStream); override;
  public
    Description: String;
    Value: String;
  end;


//-----------------------------------------------------------------------------
  // class for Wxxx (URL) frames
  TID3v2UrlFrame = class (TID3v2CustomFrame)
  protected
    procedure GetData(InStream: TStream); override;
    procedure SetData(OutStream: TStream); override;
  public
    Url: String;
  end;



procedure Register;


implementation

{$I include\methods.inc}
{$I include\tid3v2.inc}
{$I include\tid3v2customframe.inc}
{$I include\tid3v2framelist.inc}


//-----------------------------------------------------------------------------
procedure Register;
begin
  RegisterComponents('ID3', [TID3v2]);
end;

end.

