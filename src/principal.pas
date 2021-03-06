unit principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, ActnList, ImgList, ExtCtrls, Buttons,
  StdCtrls, volume, StdActns, ActnMan, CustomizeDlg, ActnCtrls,
  ActnMenus, IniFiles, opcoes, ShellAPI;

type
  TIDTAGv1 = array [0..136] of char;
  TFormPrincipal = class(TForm)
    Ajuda: TActionList;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    ImageList1: TImageList;
    Guia1: TPageControl;
    StatusBar1: TStatusBar;
    TabVolume: TTabSheet;
    ActionExportarHTML: TAction;
    Editar1: TMenuItem;
    Preferencias1: TMenuItem;
    Sair1: TMenuItem;
    Importar1: TMenuItem;
    Salvar1: TMenuItem;
    N1: TMenuItem;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    ListView1: TListView;
    TreeView1: TTreeView;
    Ajuda1: TMenuItem;
    picosdeajuda1: TMenuItem;
    Sobre1: TMenuItem;
    N2: TMenuItem;
    TabLocalizar: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    RadioGroup1: TRadioGroup;
    Busca: TLabeledEdit;
    Panel7: TPanel;
    btnLocalizar: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Tocar1: TMenuItem;
    PopupMenu2: TPopupMenu;
    ActionVolume: TAction;
    AdicionarVolume1: TMenuItem;
    ActionSalvar: TAction;
    ActionPreferencias: TAction;
    ActionSobre: TAction;
    ActionExcluir: TAction;
    ActionFechar: TAction;
    ActionAtualiza: TAction;
    ProgressBar1: TProgressBar;
    Atualizar1: TMenuItem;
    ListView3: TListView;
    Excluir1: TMenuItem;
    Excluir2: TMenuItem;
    N4: TMenuItem;
    Adicionar1: TMenuItem;
    Atualizar2: TMenuItem;
    N3: TMenuItem;
    ActionTocar: TAction;
    ActionExportar: TAction;
    Exportar1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ActionInfo: TAction;
    Info1: TMenuItem;
    N5: TMenuItem;
    ActrionAjuda: THelpContents;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    Importar2: TMenuItem;
    ActionImportar: TAction;
    ChangeDrive: TAction;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    procedure TreeView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ActionVolumeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionFecharExecute(Sender: TObject);
    procedure ActionSobreExecute(Sender: TObject);
    procedure ActionSalvarExecute(Sender: TObject);
    procedure ActionAtualizaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure btnLocalizarClick(Sender: TObject);
    procedure BuscaKeyPress(Sender: TObject; var Key: Char);
    procedure Guia1Change(Sender: TObject);
    procedure ActionExcluirExecute(Sender: TObject);
    procedure ActionPreferenciasExecute(Sender: TObject);
    procedure ActionExportarExecute(Sender: TObject);
    procedure ActionInfoExecute(Sender: TObject);
    procedure ActionTocarExecute(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ActionExportarHTMLExecute(Sender: TObject);
    procedure TreeView1StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure TreeView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ChangeDriveExecute(Sender: TObject);
  private
    nVolumeAtual, ColumnToSort, nDesabilitaExcluir : Integer;
    FormVolume: TFormVolume;
    AbriuLingua, AtualizandoArvore, carregando : Boolean;
    Idioma : String;
    dbAlterado : Boolean;
    procedure LerDB;
    procedure SalvaDB;
    procedure ChangeTreeView(Filtro:String);
    { Private declarations }
  public
    PlayList, ListaOk : Boolean;
    Lingua, Volumes, Lista: TStringList;
    Caminho, Separador, Parametros, Musica, Player, Volume, Drive : String;
    sDrive : Char;
    function ForcaExtencao(const Arquivo,Ext:String):String;
    procedure LerLingua;
    procedure AtualizaArvore;
    procedure Status(Texto:Integer);
    procedure AtualizaOpcoes(otpForm:TFormOpcoes);
    procedure GetVol(Name, Vol:String);
    function SelectedLanguage:String;
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation
uses sobre, splash, listaarq, info, exportHTML, drive;
{$R *.dfm}

{
*******************************************************************************
                         Procedimentos de Tradu��o e status
*******************************************************************************
 }

function TFormPrincipal.SelectedLanguage:String;
begin
   Result := Idioma;
end;

procedure TFormPrincipal.Status(Texto:Integer);
begin
 if AbriuLingua then
   case Texto of
     3: begin
         if Guia1.ActivePageIndex = 0 then
           StatusBar1.Panels[1].Text := Lingua.strings[Texto]+inttostr(ListView1.Items.Count)
         else
           StatusBar1.Panels[1].Text := Lingua.strings[Texto]+inttostr(ListView3.Items.Count);
        end;
     -1:begin
         StatusBar1.Panels[1].Text := '';
        end;
   else
       if Carregando then begin
        FormSplash.Label1.Caption :=Lingua.strings[Texto];
        FormSplash.Repaint;
       end
       else begin
        StatusBar1.Panels[1].Text := Lingua.strings[Texto];
        FormPrincipal.Repaint;
       end;
   end;

end;

procedure TFormPrincipal.LerLingua;
var
  n : Integer;
  Arquivo : String;
  Ini : TIniFile;
begin
 Ini        := TIniFile.Create(Caminho+'mmc.ini');
 Idioma     := Ini.ReadString('Opcoes', 'Lingua', 'default');
 Arquivo    := caminho+'lang\'+Idioma+'.txt';
 AbriuLingua := FileExists(Arquivo);

 if not AbriuLingua then exit;
 Lingua.LoadFromFile(Arquivo);
 Status(36);

 Player     := Ini.ReadString('Opcoes', 'Player', '');
 PlayList   := Ini.ReadBool('Opcoes', 'PlayList', False);
 Parametros := Ini.ReadString('Opcoes', 'Parametros', '');
 Separador  := Ini.ReadString('Opcoes', 'Separador', '-');

 ActionTocar.Enabled := (Player <> '');
 if PlayList then
   if not ActionTocar.Enabled then
     PlayList := False;


 Ini.Destroy;

 for n := 0 to Self.ComponentCount-1 do begin
    if (Self.Components[n] is TAction) then
       with (Self.Components[n] as TAction) do  begin
          Caption := Lingua.Strings[TAG];
          Hint := Lingua.Strings[TAG+1];
       end;

 end;

 Arquivo1.Caption           := Lingua.Strings[7];
 Editar1.Caption            := Lingua.Strings[8];
 Ajuda1.Caption             := Lingua.Strings[9];
 TabLocalizar.Caption       := Lingua.Strings[31];
 TabVolume.Caption          := Lingua.Strings[35];
 btnLocalizar.Caption       := Lingua.Strings[31];
 Busca.EditLabel.Caption    := Lingua.Strings[37];

 TreeView1.Hint             := Lingua.Strings[67];

 RadioGroup1.Items.Clear;
 for n := 39 to 46 do begin
   ListView1.Columns[n-39].Caption := Lingua.Strings[n-1];
   ListView3.Columns[n-39].Caption := Lingua.Strings[n-1];
   RadioGroup1.Items.Add(Lingua.Strings[n-1]);
 end;

 with RadioGroup1 do begin
   Items.Add(Lingua.Strings[46]);
   RadioGroup1.ItemIndex := 0;
 end;

 with SaveDialog1 do begin
  Title := Lingua.Strings[57]+'...';
  Filter := Lingua.Strings[58];
 end;

 Status(-1);
end;

procedure TFormPrincipal.AtualizaOpcoes(otpForm:TFormOpcoes);
begin
 with otpForm do begin
   Caption := Lingua.Strings[47];
   btnSalvar.Caption        := Lingua.Strings[48];
   btnFechar.Caption        := Lingua.Strings[34];
   TabSheet1.Caption        := Lingua.Strings[49];
   TabSheet2.Caption        := Lingua.Strings[50];
   TabSheet3.Caption        := Lingua.Strings[62];

   LabelPasta.Caption       := Lingua.Strings[63];
   EditSeparador.Text       := Separador;
   LabelDelimitador.Caption := Lingua.Strings[64];


   LabeledEdit1.EditLabel.Caption := Lingua.Strings[51]+':';
   LabeledEdit1.Text := Player;

   LabeledEdit2.EditLabel.Caption := Lingua.Strings[55]+':';
   LabeledEdit2.Text := Parametros;

   if not FileExists(caminho+'pastas.txt') then
      MemoPastas.Lines.SaveToFile(caminho+'pastas.txt');

   MemoPastas.Lines.LoadFromFile(caminho+'pastas.txt');

   CheckBox1.Checked := PlayList;

   with OpenDialog1 do begin
      InitialDir := ExtractFilePath(Player);
      Title  := Lingua.Strings[51]+'...';
      Filter := Lingua.Strings[52];
   end;
   CheckBox1.Caption := Lingua.Strings[59];
 end;
end;


{
*******************************************************************************
               Procedimentos de Leitura e grava��o de Arquivos
*******************************************************************************
 }


procedure TFormPrincipal.LerDB;
var
 Arquivo : String;
begin
  Arquivo := Caminho+'\data\db.txt';
  if not FileExists(Arquivo) then exit;
  Lista.LoadFromFile(Arquivo);

  Arquivo := Caminho+'\data\vol.txt';
  if not FileExists(Arquivo) then exit;
  Volumes.LoadFromFile(Arquivo);
end;


procedure TFormPrincipal.SalvaDB;
      procedure ObtemOrdemVolumes;
      var
        N : Integer;
      begin
        Volumes.Clear;
        for N := TreeView1.Items.Count-1 downto 1 do Volumes.Add(TreeView1.Items[N].Text);
      end;
begin
  Lista.SaveToFile(Caminho+'\data\db.txt');
  ObtemOrdemVolumes;
  Volumes.SaveToFile(Caminho+'\data\vol.txt');
end;


{
*******************************************************************************
                        Procedimentos de Atualiza��o
*******************************************************************************
 }

procedure TFormPrincipal.btnLocalizarClick(Sender: TObject);
    procedure FiltraMusica(Filtro:String; Tipo:Integer);
    var
     n : Integer;
     sTemp, sTempArquivo, strCompara : String;

    begin
       ListView3.Clear;
       ListView3.Items.BeginUpdate;

       with ProgressBar1 do begin
         Position := n;
         Visible := True;
         Max := Lista.Count-1;
       end;

       for n := 0 to Lista.Count-1 do begin
          Application.ProcessMessages;

          if ProgressBar1.Visible = false then
            ProgressBar1.Visible := True;

          ProgressBar1.Position := n;
          sTemp := Lista.Strings[n];
          sTempArquivo := Trim(copy(sTemp, 156, length(sTemp)-155));
          case tipo of
            0: strCompara := copy(sTemp, 32, 30);
            1: strCompara := copy(sTemp, 2, 30);
            2: strCompara := copy(sTemp, 62, 30);
            3: strCompara := copy(sTemp, 92, 4);
            4: strCompara := copy(sTemp, 96, 29);
            5: strCompara := copy(sTemp, 126, 30);
            6: strCompara := ExtractFilePath(sTempArquivo);
            7: strCompara := ExtractFileName(sTempArquivo);
            8: strCompara := sTemp;
          end;
          if (pos(uppercase(Filtro), uppercase(Trim(strCompara)) ) <> 0) then begin
             With ListView3.Items.Add do begin
                 //Dados da Tag
                 Caption :=  Trim(copy(sTemp, 32, 30));
                 ImageIndex := 26;
                 SubItems.Add(Trim(copy(sTemp, 2, 30)));
                 SubItems.Add(Trim(copy(sTemp, 62, 30)));
                 SubItems.Add(Trim(copy(sTemp, 92, 4)));
                 SubItems.Add(Trim(copy(sTemp, 96, 29)));
                 SubItems.Add(Trim(copy(sTemp, 126, 30)));

                 // Dados do Arquivo
                 SubItems.Add(ExtractFilePath(sTempArquivo));
                 SubItems.Add(ExtractFileName(sTempArquivo));
             end;
          end;
       end;
       ListView3.Items.EndUpdate;
       ListView3.SortType := stText;
       ProgressBar1.Visible := False;
       FormPrincipal.Repaint;
       Status(-1);
    end;

begin
   ActionExcluir.Enabled := False;
   nDesabilitaExcluir := nDesabilitaExcluir+1;
   FiltraMusica(Busca.Text,RadioGroup1.ItemIndex);
   nDesabilitaExcluir := nDesabilitaExcluir-1;
   Status(3);
   ActionExcluir.Enabled := (nDesabilitaExcluir = 0) and (Guia1.ActivePage = TabVolume);
end;





procedure TFormPrincipal.ChangeTreeView(Filtro:String);
    procedure FiltraMusica(Filtro:String);
    var
     n : Integer;
     sVolume, sTemp, sTempArquivo : String;

    begin
       Status(2);
       ListView1.Clear;
       ListView1.Items.BeginUpdate;

       if carregando then
         FormSplash.ProgressBar1.Max := Lista.Count-1
       else
         with ProgressBar1 do begin
           Position := n;
           Visible := True;
           Max := Lista.Count-1;
         end;

       for n := 0 to Lista.Count-1 do begin
          Application.ProcessMessages;
          if carregando then
            FormSplash.ProgressBar1.Position := n
          else begin
            if ProgressBar1.Visible = false then
              ProgressBar1.Visible := True;
              ProgressBar1.Position := n;
          end;
          sTemp := Lista.Strings[n];
          sVolume := Trim(copy(sTemp, 126, 30));
          if sVolume = '' then
            ShowMessage('Erro!!!!'+#13+'O item baixo est� sem o nome do Volume!'+#13+copy(Lista.Strings[n], 0, 150));

          if ((filtro = '*') or (uppercase(sVolume) = uppercase(Trim(Filtro)))) then begin
             With ListView1.Items.Add do begin
                 //Dados da Tag
                 Caption :=  Trim(copy(sTemp, 32, 30));
                 ImageIndex := 26;
                 SubItems.Add(trim(copy(sTemp, 2, 30)));
                 SubItems.Add(Trim(copy(sTemp, 62, 30)));
                 SubItems.Add(Trim(copy(sTemp, 92, 4)));
                 SubItems.Add(Trim(copy(sTemp, 96, 29)));
                 SubItems.Add(sVolume);

                 // Dados do Arquivo
                 sTempArquivo := Trim(copy(sTemp, 156, length(sTemp)-155));
                 SubItems.Add(ExtractFilePath(sTempArquivo));
                 SubItems.Add(ExtractFileName(sTempArquivo));
             end;
          end;
       end;
       ListView1.Items.EndUpdate;
       ListView1.SortType := stText;
       Status(3);
       ProgressBar1.Visible := False;
       FormPrincipal.Repaint;
    end;

begin
   if (AtualizandoArvore or (Lista.Count = 0)) then exit;
   ActionExcluir.Enabled := False;
   TreeView1.Enabled := False;
   nDesabilitaExcluir := nDesabilitaExcluir+1;
   FiltraMusica(Filtro);
   nDesabilitaExcluir := nDesabilitaExcluir-1;
   TreeView1.Enabled := True;
   ActionExcluir.Enabled := (nDesabilitaExcluir = 0) and (Guia1.ActivePage = TabVolume);
end;


procedure TFormPrincipal.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  ChangeTreeView(Node.Text);
end;



procedure TFormPrincipal.ActionAtualizaExecute(Sender: TObject);
begin
 Status(1);
 Lerdb;
 if (Lista.Count = 0) then exit;
 Status(2);
 AtualizaArvore;
 if (TreeView1.Items.Count > 1) then
   TreeView1.Items[1].Selected := True
 else
   TreeView1.Items.GetFirstNode.Selected := True;
end;



procedure TFormPrincipal.AtualizaArvore;
var
 n2: Integer;
begin
   AtualizandoArvore := True;
   TreeView1.Items.Clear;
   Status(4);

   for n2 := 0 to Volumes.Count-1 do
     with TreeView1.Items.AddChildFirst(nil,Volumes.Strings[n2]) do begin
       ImageIndex := 28;
       SelectedIndex := 28;
     end;

     with TreeView1.Items.AddChildFirst(nil,'*') do begin
       ImageIndex := 28;
       SelectedIndex := 28;
     end;
    AtualizandoArvore := False;
end;


{
*******************************************************************************
                    Procedimentos de Varredura de Arquivos
*******************************************************************************
 }


procedure TFormPrincipal.GetVol(Name, Vol:String);
begin
  // Fecha o dialogo de Drive
  FormVolume.Close;

  // Prepara o Ambiente
  //  Drive := copy(Name, 0 , length(Name)-1 ) ;
   Drive := Name;
  Volume := Vol;
end;


procedure TFormPrincipal.ActionVolumeExecute(Sender: TObject);
var
    FormListaArq: TFormListaArq;
begin
  FormVolume := TFormVolume.Create(self);
  with FormVolume do begin
     if AbriuLingua then begin
       Caption := Lingua.Strings[15];
       LabelUnit.Caption := Lingua.Strings[28];
       LabelCD.Caption := Lingua.Strings[29];
       btnCancelar.Caption := Lingua.Strings[30];
       btnProcurar.Caption := Lingua.Strings[31];
     end;
     ShowModal;
  end;
  if not ListaOk then exit;
  Volumes.Add(Volume);

  // Abre Janela de status
  FormListaArq := TFormListaArq.Create(self);
  with FormListaArq do begin
    Caption := Lingua.Strings[0];
    btnCancelar.Caption := Lingua.Strings[30];
    LabelDirs.Caption := Lingua.Strings[32];
    LabelArqs.Caption := Lingua.Strings[33];
  end;
  Status(0);

  FormListaArq.ShowModal;

  //Finaliza Ambiente
  Status(2);
  TreeView1.Enabled := False;
  AtualizaArvore;
  TreeView1.Enabled := True;

 if (TreeView1.Items.Count > 1) then
   TreeView1.Items[1].Selected := True
 else
   TreeView1.Items.GetFirstNode.Selected := True;

 dbAlterado := True;

end;

procedure TFormPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if dbAlterado then
    if not MessageDlg(Lingua.Strings[76], mtConfirmation, [mbYes, mbNo],0) = IDYes then ActionSalvar.Execute;

 Application.Terminate;
end;

procedure TFormPrincipal.ActionFecharExecute(Sender: TObject);
begin
  Close;
end;

{
*******************************************************************************
                   Procedimentos de Abertura de Dialogos
*******************************************************************************
 }

procedure TFormPrincipal.ActionPreferenciasExecute(Sender: TObject);
var
 FormOpcoes : TFormOpcoes;
begin
 FormOpcoes := TFormOpcoes.Create(self);
 if AbriuLingua then AtualizaOpcoes(FormOpcoes);
 FormOpcoes.PageControl1.ActivePageIndex := 0;
 FormOpcoes.ShowModal;
end;


procedure TFormPrincipal.ActionInfoExecute(Sender: TObject);
var
 n: Integer;
begin
 FormInfo := TFormInfo.Create(self);
 if AbriuLingua then begin
     for n := 0 to FormInfo.ComponentCount-1 do
       if (FormInfo.Components[n] is TLabel) then
         if ( (FormInfo.Components[n] as TLabel).Tag <> 0 ) then
             (FormInfo.Components[n] as TLabel).Caption := Lingua.Strings[(FormInfo.Components[n] as TLabel).Tag]+':';

      if Guia1.ActivePageIndex = 0 then
         FormInfo.PegaLista(ListView1.Selected)
      else
         FormInfo.PegaLista(ListView3.Selected);

      FormInfo.Caption := Lingua.Strings[61];
   end;
  FormInfo.ShowModal;
end;



procedure TFormPrincipal.ActionSobreExecute(Sender: TObject);
var
 FormSobre : TFormSobre;
begin
 FormSobre := TFormSobre.Create(self);
 FormSobre.Caption := Lingua.Strings[23];
 FormSobre.btnFechar.Caption := Lingua.Strings[34];
 FormSobre.Hide;
 FormSobre.ShowModal;
end;



{
*******************************************************************************
                Procedimentos de Inicializa��o e Finaliza��o
*******************************************************************************
 }



procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
 Application.CreateForm(TFormSplash,Formsplash);
 FormSplash.Show;
 FormSplash.Repaint;
 Caminho := ExtractFilePath(Application.ExeName);
 Lingua := TStringList.Create;
 Carregando := True;
 LerLingua;
 Guia1.ActivePageIndex := 0;
 with ProgressBar1 do begin
   Parent := StatusBar1;
   Width := 99;
   Top := 3;
   Left := 0;
   Height := 15;
   Visible := False;
 end;
 Lista := TStringList.Create;
 Volumes := TStringList.Create;
 Volumes.Sorted := False;
 FormSplash.ProgressBar1.Visible := True;
 FormSplash.Repaint;
 ActionAtualiza.OnExecute(Self);
 FormSplash.ProgressBar1.Visible := False;
 FormSplash.Repaint;
 Carregando := False;
 FormSplash.Free;

  dbAlterado := False;
end;

{
*******************************************************************************
                     Procedimentos de manipula��o dos dados
*******************************************************************************
 }

function TFormPrincipal.ForcaExtencao(const Arquivo,Ext:String):String;
var
  sExt:String;
begin
  sExt := '.'+Ext;

  if Uppercase( ExtractFileExt(Arquivo) ) <> Uppercase(sExt) then
    Result := Arquivo+sExt
  else
    Result := Arquivo;
end;

procedure TFormPrincipal.ActionExcluirExecute(Sender: TObject);
var
 n : Integer;
begin
   if (TreeView1.Selected = nil) or (TreeView1.Selected.Text = '*') then exit;
   if not MessageDlg(Lingua.Strings[5] +' "'+TreeView1.Selected.Text+'"?', mtConfirmation, [mbYes, mbNo],0) = IDYes then exit;

   Status(6);
   for n := Lista.Count-1 downto 0 do
     if (Trim(copy(Lista.Strings[n], 126, 30)) = TreeView1.Selected.Text) then
       Lista.Delete(n);


   for n := Volumes.Count-1 downto 0 do
     if (Volumes.Strings[n] = TreeView1.Selected.Text) then
       Volumes.Delete(n);

   TreeView1.Selected.Delete;
   dbAlterado := True;
end;


procedure TFormPrincipal.ActionExportarExecute(Sender: TObject);
var
 ListaTemp : TStringList;
 n : Integer;
 sArquivo, sTemp:String;

begin
  if not SaveDialog1.Execute then exit;
  ListaTemp := TStringList.Create;
  ListaTemp.Add('#EXTM3U');

  if Guia1.ActivePageIndex = 0 then begin
    if (ListView1.Selected <> nil) then
      for n := 0 to ListView1.Items.Count-1 do begin
        sTemp :=ListView1.Items.Item[n].SubItems[5]+ListView1.Items.Item[n].SubItems[6];
        if (trim(sTemp) <> '') then begin
          ListaTemp.Add('#EXTINF:0 '+ListView1.Items.Item[n].Caption+' - '+ListView1.Items.Item[n].SubItems[0]);
          ListaTemp.Add(sTemp);
        end;
      end;
  end
  else begin
    if (ListView3.Selected <> nil) then
      for n := 0 to ListView3.Items.Count-1 do begin
        sTemp := ListView3.Items.Item[n].SubItems[5]+ListView3.Items.Item[n].SubItems[6];
        if (trim(sTemp) <> '') then begin
          ListaTemp.Add('#EXTINF:0 '+ListView3.Items.Item[n].Caption+' - '+ListView3.Items.Item[n].SubItems[0]);
          ListaTemp.Add(sTemp);
        end;
      end;
  end;

  sArquivo := ForcaExtencao(SaveDialog1.FileName, 'm3u');
  ListaTemp.SaveToFile(sArquivo);
  ListaTemp.Destroy;
  if PlayList then ShellExecute(GetDesktopWindow, 'open', pchar(Player), pchar('"'+sArquivo+'"') , nil, sw_ShowNormal);

end;


procedure TFormPrincipal.ActionTocarExecute(Sender: TObject);
var
 sTemp : String;
 n: Integer;
begin
  if Guia1.ActivePage = TabVolume then begin
    if (ListView1.Selected <> nil) then Musica := ListView1.Selected.SubItems[5]+ListView1.Selected.SubItems[6]
  end
  else begin
    if (ListView3.Selected <> nil) then Musica := ListView3.Selected.SubItems[5]+ListView3.Selected.SubItems[6];
  end;

  sTemp :=Parametros;
  n := pos('%s', sTemp);

  while (n <> 0) do begin
    sTemp := copy(sTemp, 0,n-1)+'"'+Musica+'"'+copy(sTemp, n+2,length(Stemp)-n-1);
    n := pos('%s', sTemp);
  end;

  ShellExecute(GetDesktopWindow, 'open', pchar(Player), pchar(sTemp) , nil, sw_ShowNormal);
end;


procedure TFormPrincipal.ListView1DblClick(Sender: TObject);
begin
 if ActionTocar.Enabled then
  ActionTocar.Execute;
end;

procedure TFormPrincipal.BuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btnLocalizar.Click;
end;

procedure TFormPrincipal.Guia1Change(Sender: TObject);
begin
   ActionAtualiza.Enabled :=  (Guia1.ActivePage = TabVolume);
   
   if Guia1.ActivePage = TabVolume then
        ActionExcluir.Enabled  := (nDesabilitaExcluir = 0) and (Guia1.ActivePage = TabVolume)
   else
        ActionExcluir.Enabled := False;

   Status(3);
end;


procedure TFormPrincipal.ActionSalvarExecute(Sender: TObject);
begin
 SalvaDB;
end;

procedure TFormPrincipal.ActionExportarHTMLExecute(Sender: TObject);
var
   FormExportHTML: TFormExportHTML;
begin
 FormExportHTML := TFormExportHTML.Create(self);


  with FormExportHTML do begin
     PageControl.ActivePage := TabSheetEdita;
     if AbriuLingua then begin
       Caption                  := Lingua.Strings[65];
       CheckListBox.Hint        := Lingua.Strings[67];

       TabSheetEdita.Caption    := Lingua.Strings[68];
       TabSheetPreview.Caption  := Lingua.Strings[69];
       LabelTitulo.Caption      := Lingua.Strings[70];

       LabelCorFonte.Caption    := Lingua.Strings[71];
       LabelCabCorFonte.Caption := Lingua.Strings[71];

       LabelCabCorFundo.Caption := Lingua.Strings[72];
       LabelCorFundo.Caption    := Lingua.Strings[72];

       chkCabecalho.Caption     := Lingua.Strings[73];

       SpeedButonExport.Caption := Lingua.Strings[74];
       SaveDialog1.Title        := Lingua.Strings[75];

       EditTitulo.Text          := Lingua.Strings[77];

       SpeedClose.Caption       := Lingua.Strings[34];
     end;
     ShowModal;
  end;



end;

procedure TFormPrincipal.TreeView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
 nVolumeAtual := TreeView1.Selected.Index;
 if (TreeView1.Items[TreeView1.Selected.Index].Text <> '*' ) then
   TreeView1.BeginDrag(True);
end;

procedure TFormPrincipal.TreeView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  sTemp : String;
  N : Integer;
  Node1, Node2 : TTreeNode;

begin

  if   nVolumeAtual = 0 then exit;

  Node1 := TreeView1.Items[nVolumeAtual];
  Node2 := TreeView1.GetNodeAt(X,Y);

  if Node2 = nil then exit;

  if (Node1.Text = '*') or (Node2.Text = '*') then exit;


  if Node2.Index < Node1.Index then begin
    sTemp := Node1.Text;
    for N := Node1.Index downto Node2.Index do TreeView1.Items[n].Text := TreeView1.Items[n-1].Text;
    Node2.Text := sTemp;
  end
  else begin
    sTemp := Node1.Text;
    for N :=  Node1.Index to Node2.Index do TreeView1.Items[n].Text := TreeView1.Items[n+1].Text;
    Node2.Text := sTemp;
  end;

  nVolumeAtual := 0;
  Node2.Selected := True;

  dbAlterado := True;
end;

procedure TFormPrincipal.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else begin
   ix := ColumnToSort - 1;
   Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
  end;

end;


procedure TFormPrincipal.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

procedure TFormPrincipal.TreeView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if (nVolumeAtual <> 0) then Accept:= True;
end;

procedure TFormPrincipal.ChangeDriveExecute(Sender: TObject);

  function RetornaDrive(Volume:String):String;
  var
    sTemp : String;
    n : integer;
  begin
    Result := '';
    if Volume = '*' then exit;
    for n := 0 to Lista.Count -1 do begin
      sTemp := Lista.Strings[156];
      if (trim(copy(Lista.Strings[n], 126, 30))  = Volume) then begin
        sTemp := Lista.Strings[n];
        Result :=  '   '+sTemp[156]+':';
        exit;
      end;
    end;
  end;


var
  n:integer;
  sTemp, Volume : string;
  bSingleVolume : Boolean;
begin
  sDrive := '0';

  frmDrive := TfrmDrive.Create(Self);
  Volume := TreeView1.Selected.Text;
  frmDrive.LabelDrive.Caption := RetornaDrive(Volume);

  frmDrive.btnAltera.Caption := Lingua.Strings[78];
  frmDrive.btnCancelar.Caption := Lingua.Strings[79];
  frmDrive.LabelDrvTitulo.Caption := Lingua.Strings[83];
  frmDrive.LabelLocal.Caption := Lingua.Strings[84];
  bSingleVolume := not (Volume = '*');
  frmDrive.Panel2.Visible := bSingleVolume;
  if bSingleVolume then
    frmDrive.Caption := Lingua.Strings[80]
  else
    frmDrive.Caption := Lingua.Strings[82];


  frmDrive.LabelDrive.Caption := RetornaDrive(TreeView1.Selected.Text);
  frmDrive.ShowModal;

  if (sDrive = '0') then exit;
  Lista.BeginUpdate;
  if not bSingleVolume then begin
    for n := 0 to Lista.Count -1 do begin
       sTemp := Lista.Strings[n];
       sTemp[156] :=  sDrive;
       Lista.Strings[156] := sTemp;
    end;
  end
  else begin
    for n := 0 to Lista.Count -1 do begin
      sTemp := Lista.Strings[156];
      if (trim(  copy(Lista.Strings[n], 126, 30)  )  = Volume) then begin
        sTemp := Lista.Strings[n];
        sTemp[156] :=  sDrive;
        Lista.Strings[156] := sTemp;
      end;
    end;
  end;
  Lista.EndUpdate;
  ChangeTreeView(TreeView1.Selected.Text);
  btnLocalizar.Click;
end;

end.
