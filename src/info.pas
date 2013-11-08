unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFormInfo = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Label7: TLabel;
    LabelArtista: TLabel;
    LabelNome: TLabel;
    LabelAlbum: TLabel;
    LabelAno: TLabel;
    LabelComentario: TLabel;
    LabelArquivo: TLabel;
    procedure PegaLista(Lista:TListItem);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInfo: TFormInfo;

implementation

{$R *.dfm}

procedure TFormInfo.PegaLista(Lista:TListItem);
begin
  LabelArtista.Caption := Lista.Caption;
  LabelNome.Caption := Lista.SubItems[0];
  LabelAlbum.Caption := Lista.SubItems[1];
  LabelAno.Caption := Lista.SubItems[2];
  LabelComentario.Caption := Lista.SubItems[3];
  TabSheet1.Caption := Lista.SubItems[4];
  LabelArquivo.Caption := Lista.SubItems[5]+Lista.SubItems[6];
end;

procedure TFormInfo.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TFormInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
