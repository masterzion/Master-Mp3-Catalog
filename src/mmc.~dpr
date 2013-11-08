program mmc;

uses
  Forms,
  principal in 'principal.pas' {FormPrincipal},
  volume in 'volume.pas' {FormVolume},
  sobre in 'sobre.pas' {FormSobre},
  splash in 'splash.pas' {FormSplash},
  listaarq in 'listaarq.pas' {FormListaArq},
  opcoes in 'opcoes.pas' {FormOpcoes},
  info in 'info.pas' {FormInfo},
  exportHTML in 'exportHTML.pas' {FormExportHTML},
  drive in 'drive.pas' {frmDrive};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Master MP3 Catalog';
  Application.HelpFile := 'mmc.hlp';
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TfrmDrive, frmDrive);
  Application.Run;
end.
