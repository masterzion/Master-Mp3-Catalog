unit drive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ExtCtrls, Buttons;

type
  TfrmDrive = class(TForm)
    btnAltera: TSpeedButton;
    btnCancelar: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    LabelLocal: TLabel;
    LabelDrive: TLabel;
    DriveComboBox: TDriveComboBox;
    LabelDrvTitulo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlteraClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDrive: TfrmDrive;

implementation

uses principal;

{$R *.dfm}

procedure TfrmDrive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TfrmDrive.btnAlteraClick(Sender: TObject);
begin
  FormPrincipal.sDrive := DriveComboBox.Drive;
  Close;
end;

procedure TfrmDrive.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
