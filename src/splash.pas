unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, jpeg;

type
  TFormSplash = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

uses principal;

{$R *.dfm}

procedure TFormSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
