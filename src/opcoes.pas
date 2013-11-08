unit opcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, FileCtrl, Buttons, IniFiles;

type
  TFormOpcoes = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnFechar: TSpeedButton;
    btnSalvar: TSpeedButton;
    LabeledEdit1: TLabeledEdit;
    SpeedButton4: TSpeedButton;
    OpenDialog1: TOpenDialog;
    LabeledEdit2: TLabeledEdit;
    CheckBox1: TCheckBox;
    TabSheet3: TTabSheet;
    LabelPasta: TLabel;
    MemoPastas: TMemo;
    Panel2: TPanel;
    EditSeparador: TEdit;
    LabelDelimitador: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOpcoes: TFormOpcoes;

implementation

uses principal;

{$R *.dfm}


procedure TFormOpcoes.btnFecharClick(Sender: TObject);
begin
 Close;
end;

procedure TFormOpcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TFormOpcoes.btnSalvarClick(Sender: TObject);
var
  Ini : TIniFile;
begin
 Ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'mmc.ini');
  case PageControl1.ActivePageIndex of
     0:  if (RadioGroup1.ItemIndex <> -1) then
            Ini.WriteString('Opcoes', 'Lingua', RadioGroup1.Items[RadioGroup1.ItemIndex]);

     1:   if (LabeledEdit1.Text <> '') then begin
            Ini.WriteString('Opcoes', 'Player', LabeledEdit1.Text);
            Ini.WriteString('Opcoes', 'Parametros', LabeledEdit2.Text);
            Ini.WriteBool('Opcoes', 'PlayList', CheckBox1.Checked);
          end;

     2:   if (LabeledEdit1.Text <> '') then begin
            Ini.WriteString('Opcoes', 'Separador', EditSeparador.Text);
            MemoPastas.Lines.SaveToFile(FormPrincipal.Caminho+'pastas.txt');
          end;
  end;
  Ini.Destroy;
  FormPrincipal.LerLingua;
  FormPrincipal.AtualizaOpcoes(Self);
end;

procedure TFormOpcoes.SpeedButton4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    LabeledEdit1.Text := OpenDialog1.FileName;
    if uppercase(ExtractFileName(OpenDialog1.FileName)) = 'WINAMP.EXE' then
      LabeledEdit2.Text := '%s'
  end;
end;


procedure TFormOpcoes.FormCreate(Sender: TObject);
var
      SR: TSearchRec;
      Arquivo, sTemp: String;
      n : Integer;
begin
      FormPrincipal.Lista.BeginUpdate;
      FindFirst(FormPrincipal.Caminho+'lang\*.txt', faAnyFile, SR);
      while not (Arquivo = SR.Name) do begin
        if (SR.Name <> '.') and (SR.Name <> '..') and (SR.Attr = faArchive and faReadOnly) or (SR.Attr in [1, 32, 33]) then begin
          sTemp := ExtractFileName(SR.Name);
          RadioGroup1.Items.Add(copy(sTemp, 0, length(sTemp)-4 ));
        end;
        Application.ProcessMessages;
        Arquivo:=SR.Name;
        FindNext(SR);
      end;
      FormPrincipal.Lista.EndUpdate;

        for n := 0 to RadioGroup1.Items.Count-1 do
           if  uppercase( RadioGroup1.Items[n] ) =  uppercase(FormPrincipal.SelectedLanguage) then
             RadioGroup1.ItemIndex := n;

end;

end.
