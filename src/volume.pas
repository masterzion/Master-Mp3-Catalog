unit volume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, FileCtrl, ExtCtrls;

type
  TFormVolume = class(TForm)
    btnProcurar: TSpeedButton;
    btnCancelar: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    LabelUnit: TLabel;
    Panel3: TPanel;
    LabelCD: TLabel;
    EditNome: TEdit;
    edtDir: TEdit;
    SpeedButton1: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnProcurarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure EditNomeChange(Sender: TObject);
    procedure EditNomeKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FormVolume: TFormVolume;

implementation
uses principal;

{$R *.dfm}

procedure TFormVolume.btnCancelarClick(Sender: TObject);
begin
FormPrincipal.ListaOk := False;
close;
end;

procedure TFormVolume.btnProcurarClick(Sender: TObject);
begin
  FormPrincipal.GetVol(edtDir.Text, uppercase(EditNome.Text));
  FormPrincipal.ListaOk := True;
  close;
end;

procedure TFormVolume.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TFormVolume.DriveComboBox1Change(Sender: TObject);
var
 nTemp : Integer;
begin
 nTemp := pos('[',edtDir.Text)+1;
 EditNome.Text := copy(edtDir.Text, nTemp, pos(']',edtDir.Text)-ntemp);
end;

procedure TFormVolume.EditNomeChange(Sender: TObject);
var
 Existe : Boolean;
 n : Integer;
begin
 Existe := False;
 for n := 0 to FormPrincipal.Volumes.Count-1 do
   if FormPrincipal.Volumes[n] = uppercase(EditNome.Text) then
       Existe := True;

 btnProcurar.Enabled := (not Existe) and (EditNome.Text <> '') and (edtDir.Text <> '');
end;

procedure TFormVolume.EditNomeKeyPress(Sender: TObject; var Key: Char);
begin
 if (key = #13) and (btnProcurar.Enabled) then btnProcurar.Click;
end;

procedure TFormVolume.SpeedButton1Click(Sender: TObject);

    // from FileCtrl
    function VolumeID(DriveChar: Char): string;
    var
      OldErrorMode: Integer;
      NotUsed, VolFlags: DWORD;
      Buf: array [0..MAX_PATH] of Char;
    begin
      OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
      try
        Buf[0] := #$00;
        if GetVolumeInformation(PChar(DriveChar + ':\'), Buf, DWORD(sizeof(Buf)),
          nil, NotUsed, VolFlags, nil, 0) then
          SetString(Result, Buf, StrLen(Buf))
        else Result := '';
        if DriveChar < 'a' then
          Result := AnsiUpperCaseFileName(Result)
        else
          Result := AnsiLowerCaseFileName(Result);
      finally
        SetErrorMode(OldErrorMode);
      end;
    end;

var
 sDir : string;
begin

  Self.Visible := False;

  SelectDirectory('', sDir, sDir);
  if (sDir <> '') then begin
    edtDir.Text := sDir;
    EditNome.Text := VolumeID(sDir[1]);
  end;

  Self.Visible := True;
end;

end.
