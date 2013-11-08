unit exportHTML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, OleCtrls, SHDocVw, Buttons, ShellAPI,
  CheckLst;

type
  IntArray = Array of integer;

  TFormExportHTML = class(TForm)
    PageControl: TPageControl;
    TabSheetEdita: TTabSheet;
    TabSheetPreview: TTabSheet;
    LabelCorFonte: TLabel;
    LabelCorFundo: TLabel;
    WebBrowser: TWebBrowser;
    SaveDialog1: TSaveDialog;
    SpeedButonExport: TSpeedButton;
    SpeedClose: TSpeedButton;
    ComboCorFonte: TColorBox;
    ComboCorFundo: TColorBox;
    PanelTitulo: TPanel;
    LabelTitulo: TLabel;
    EditTitulo: TEdit;
    chkCabecalho: TCheckBox;
    ComboCorTitulo: TColorBox;
    LabelCabCorFundo: TLabel;
    ComboCorFonteTitulo: TColorBox;
    LabelCabCorFonte: TLabel;
    PanelLista: TPanel;
    Panel3: TPanel;
    CheckListBox: TCheckListBox;
    CheckBox: TCheckBox;
    Panel1: TPanel;
    procedure CheckListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure EditTituloKeyPress(Sender: TObject; var Key: Char);
    procedure CheckListBoxClickCheck(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure chkCabecalhoClick(Sender: TObject);
    procedure CheckListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CheckListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure CheckListBoxStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure SpeedCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControlChange(Sender: TObject);
    procedure SpeedButonExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ListaHTML : TStringList;
    nItemAtual : Integer;
    bActivateCheck : Boolean;
    procedure GeraConteudo;
  public
    { Public declarations }
  end;

var
  FormExportHTML: TFormExportHTML;

implementation
uses principal;
{$R *.dfm}


procedure TFormExportHTML.FormCreate(Sender: TObject);
var
  n : Integer;
begin
  ListaHTML := TStringList.Create;
  bActivateCheck := False;

  CheckListBox.Items.Clear;
  for n := 0 to FormPrincipal.ListView1.Columns.Count-1 do begin
   CheckListBox.Items.Add(FormPrincipal.ListView1.Columns[n].Caption);
   CheckListBox.Checked[CheckListBox.Items.Count-1] := True;
  end;

  if FormPrincipal.Guia1.ActivePageIndex = 0 then begin
     if (FormPrincipal.TreeView1.Selected.Text <> '*') then EditTitulo.Text := FormPrincipal.TreeView1.Selected.Text;
  end
  else
     EditTitulo.Text := FormPrincipal.RadioGroup1.Items[FormPrincipal.RadioGroup1.ItemIndex] + ': '  + FormPrincipal.Busca.Text;

  bActivateCheck := True;
end;

procedure TFormExportHTML.SpeedButonExportClick(Sender: TObject);
var
 sArquivo:String;
begin
  if not SaveDialog1.Execute then exit;
  GeraConteudo;

  sArquivo := FormPrincipal.ForcaExtencao(SaveDialog1.FileName,'html');
  ListaHTML.SaveToFile(sArquivo);

  ShellExecute(GetDesktopWindow, 'open', pchar(sArquivo), pchar('"'+sArquivo+'"') , nil, sw_ShowNormal);
end;


procedure TFormExportHTML.PageControlChange(Sender: TObject);
var
  sTemp:String;
begin
  if ( PageControl.ActivePage = TabSheetEdita ) then exit;
  sTemp := FormPrincipal.Caminho+'temp.html';
  GeraConteudo;
  ListaHTML.SaveToFile(sTemp);
  WebBrowser.Navigate(sTemp);
end;

procedure TFormExportHTML.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeleteFile(FormPrincipal.Caminho+'temp.html');
  ListaHTML.Destroy;
end;

procedure TFormExportHTML.SpeedCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormExportHTML.GeraConteudo;

  function Getlayout:String;
  var
      LayoutFile : TStringList;
      sArquivo : String;
  begin
    LayoutFile := TStringList.Create;
    sArquivo := FormPrincipal.Caminho+'layout.html';

    if FileExists(sArquivo) then
      LayoutFile.LoadFromFile(sArquivo)
    else begin
      LayoutFile.Text := '<html>';

      LayoutFile.Add('<head>');
      LayoutFile.Add('<link rel="stylesheet" href="null">');
      LayoutFile.Add('<style TYPE="text/css">');
      LayoutFile.Add('<!--BODY { background: <MMC_BG_COLOR>; }');
      LayoutFile.Add('.para1 { margin-top: -42px; margin-left: 145px; margin-right: 10px; font-family: "font2, Arial"; font-size: 30px; line-height: 35px; text-align: left; color: <MMC_FONT_COLOR>; }');
      LayoutFile.Add('.para2 { margin-top: -15px; margin-left: 15px; margin-right: 50px; font-family: "font1, Arial Black"; font-size: 50px; line-height: 90px; text-align: left; color: <MMC_FONT_COLOR>; }');
      LayoutFile.Add('--></style>');
      LayoutFile.Add('<title>  <MMC_TITLE> </title>');
      LayoutFile.Add('</head>');
      LayoutFile.Add('<body BGCOLOR=<MMC_BG_COLOR> topmargin="0" leftmargin="0" text=<MMC_FONT_COLOR> >');
      LayoutFile.Add('<div align="center">');
      LayoutFile.Add('  <div CLASS="para2" align="center">');
      LayoutFile.Add('     <p>Master MP3 Catalog</p>');
      LayoutFile.Add('  </div>');
      LayoutFile.Add('  <div CLASS="para1" align="center">');
      LayoutFile.Add('     <p> <MMC_TITLE> </p>');
      LayoutFile.Add('  </div>');
      LayoutFile.Add('</div>');
      LayoutFile.Add('<hr align="left" width="90%" noshade size="1" color="Black">');
      LayoutFile.Add('');
      LayoutFile.Add('<MMC_TABLE>');
      LayoutFile.Add('');
      LayoutFile.Add('<hr align="left" width="90%" noshade size="1" color="Black">');
      LayoutFile.Add(' Total: <MMC_TOTAL>');
      LayoutFile.Add('</body>');
      LayoutFile.Add('</html>');

      LayoutFile.SaveToFile(sArquivo);
    end;
    Result := LayoutFile.Text;
    LayoutFile.Destroy;
  end;

  function RetornaColunas(Lista : TListItem;Colunas: IntArray):string;
  var
    n : Integer;
    sTemp : String;
  begin
    for n := 0 to Length(Colunas)-1 do
      if Colunas[n] = -1 then
        sTemp := sTemp +'<td>'+Lista.Caption+'</td>'
      else
        sTemp := sTemp +'<td>'+Lista.SubItems[ Colunas[n] ]+'</td>';

    Result := sTemp;
  end;

  procedure RetornaIDColunas(var Rsultado: IntArray; var Titulo : string);
  var
    n1, n2, npos : Integer;
    ListaChecados : TStringList;
    sCorFonteTitulo, sCorTitulo : String;
  begin
    sCorTitulo := ComboCorTitulo.ColorNames[ComboCorTitulo.ItemIndex];
    delete(sCorTitulo,1,2);

    sCorFonteTitulo := ComboCorFonteTitulo.ColorNames[ComboCorFonteTitulo.ItemIndex];
    delete(sCorFonteTitulo,1,2);


    // Zera Valores
    ListaChecados := TStringList.Create;
    n2 := 0;
    npos := 0;

    //Determina o tamanho do array e cria o titulo da tabela
    Titulo := '<TR bgcolor='+sCorTitulo+'>';
    for n1 := 0 to CheckListBox.Items.Count-1 do
      if CheckListBox.checked[n1] then begin
         n2 := n2 +1;
         ListaChecados.Add(CheckListBox.Items[n1]);
         Titulo := Titulo + '<TD><B><font color='+sCorFonteTitulo+'>'+CheckListBox.Items[n1]+'</font></B></TD>';
      end;
    SetLength(Rsultado, n2);
    Titulo := Titulo + '</TR>';


    // Verifica ordem e adiciona os id no array
    for n1 := 0 to ListaChecados.Count-1 do begin
      for n2 := 0 to FormPrincipal.ListView1.Columns.Count-1 do begin
        if ListaChecados.Strings[n1] = FormPrincipal.ListView1.Columns[n2].Caption then begin
           Rsultado[npos] := n2-1;
           npos := npos +1
        end;
      end;
    end;

     ListaChecados.Destroy;
  end;

var
  nTotalItems, n: Integer;
  sTituloTabela, sLayout, sfntColor, sfunColor: string;
  ListaTabela :TStringList;
  ArrayCol : IntArray;

begin


  sfntColor := ComboCorFonte.ColorNames[ComboCorFonte.ItemIndex];
  delete(sfntColor,1,2);

  sfunColor := ComboCorFundo.ColorNames[ComboCorFundo.ItemIndex];
  delete(sfunColor,1,2);

  sLayout := GetLayout;



  ListaTabela := TStringList.Create;
  ListaTabela.Add('<!-- Generate by Master MP3 Catalog -->');
  ListaTabela.Add('<TABLE width="90%" border="0" cellspacing="0">');


  RetornaIDColunas(ArrayCol, sTituloTabela);

  if chkCabecalho.Checked then ListaTabela.Add(sTituloTabela);

  if FormPrincipal.Guia1.ActivePageIndex = 0 then begin
      nTotalItems := FormPrincipal.ListView1.Items.Count;
      for n := 0 to nTotalItems - 1 do begin
          ListaTabela.Add('<TR>');
          ListaTabela.Add(RetornaColunas(FormPrincipal.ListView1.Items.Item[n], ArrayCol )   );
          ListaTabela.Add('</TR>');
      end;
  end
  else begin
      nTotalItems := FormPrincipal.ListView3.Items.Count;
      for n := 0 to nTotalItems - 1 do begin
          ListaTabela.Add('<TR>');
          ListaTabela.Add(RetornaColunas(FormPrincipal.ListView3.Items.Item[n], ArrayCol )   );
          ListaTabela.Add('</TR>');
      end;
  end;

  ListaTabela.Add('</table>');


  sLayout := StringReplace(sLayout, '<MMC_TITLE>'     , EditTitulo.Text,  [rfReplaceAll,rfIgnoreCase]);
  sLayout := StringReplace(sLayout, '<MMC_BG_COLOR>'  ,  sfunColor , [rfReplaceAll,rfIgnoreCase] );
  sLayout := StringReplace(sLayout, '<MMC_FONT_COLOR>',  sfntColor  , [rfReplaceAll,rfIgnoreCase] );
  sLayout := StringReplace(sLayout, '<MMC_TOTAL>',  IntToStr(nTotalItems)  , [rfReplaceAll,rfIgnoreCase] );

  sLayout := StringReplace(sLayout, '<MMC_TABLE>',  ListaTabela.Text  , [rfReplaceAll,rfIgnoreCase] );





  ListaHTML.Text := sLayout;


  ListaTabela.Destroy;


end;

procedure TFormExportHTML.CheckListBoxStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
 nItemAtual := CheckListBox.ItemIndex;
end;

procedure TFormExportHTML.CheckListBoxDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TFormExportHTML.CheckListBoxDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  n, nTemp : Integer;
  ponto :TPoint;
  bTemp, bItemAtual : Boolean;
  sItemAtual : String;
begin
  if nItemAtual = -1 then exit;

  ponto.X := X;
  ponto.Y := Y;

  nTemp := CheckListBox.ItemAtPos(ponto, bTemp);
  if nTemp = -1 then exit;

  bItemAtual := CheckListBox.Checked[nItemAtual];
  sItemAtual := CheckListBox.Items[nItemAtual];


  if nItemAtual > nTemp then begin
    for n := nItemAtual downto nTemp+1 do begin
      CheckListBox.Checked[n] := CheckListBox.Checked[n-1];
      CheckListBox.Items[n] := CheckListBox.Items[n-1];
    end;
    CheckListBox.Checked[nTemp] := bItemAtual;
    CheckListBox.Items[nTemp] := sItemAtual;

  end
  else begin
    for n := nItemAtual to nTemp-1 do begin
      CheckListBox.Checked[n] := CheckListBox.Checked[n+1];
      CheckListBox.Items[n] := CheckListBox.Items[n+1];
    end;
    CheckListBox.Checked[nTemp] := bItemAtual;
    CheckListBox.Items[nTemp] := sItemAtual;
  end;


end;

procedure TFormExportHTML.chkCabecalhoClick(Sender: TObject);
begin
  ComboCorTitulo.visible := chkCabecalho.Checked;
  ComboCorFonteTitulo.visible := chkCabecalho.Checked;
  LabelCabCorFundo.visible := chkCabecalho.Checked;
  LabelCabCorFonte.visible := chkCabecalho.Checked;
end;

procedure TFormExportHTML.CheckBoxClick(Sender: TObject);
var
  n : Integer;
begin
  if bActivateCheck then
     for n := 0 to CheckListBox.Items.Count-1 do CheckListBox.Checked[n] := CheckBox.Checked;
end;

procedure TFormExportHTML.CheckListBoxClickCheck(Sender: TObject);
var
  n : integer;
  bChecked, bUnchecked : Boolean;
begin
    bChecked := False;
    bUnchecked := False;

    bActivateCheck := False;

    for n := 0 to CheckListBox.Items.Count-1 do
        if CheckListBox.Checked[n] then
           bChecked := True
        else
           bUnchecked  := True;

    if bChecked and bUnchecked then CheckBox.State := cbGrayed;
    if bChecked and (not bUnchecked) then CheckBox.Checked := True;
    if (not bChecked) and bUnchecked then CheckBox.Checked := False;

   bActivateCheck := True;
end;

procedure TFormExportHTML.EditTituloKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then SpeedButonExport.Click;
end;

procedure TFormExportHTML.CheckListBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) then SpeedButonExport.Click;
end;

end.
