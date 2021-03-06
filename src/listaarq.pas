unit listaarq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ID3v2;

type
  TFormListaArq = class(TForm)
    Timer1: TTimer;
    LabelDir: TLabel;
    LabelArq: TLabel;
    LabelArqs: TLabel;
    LabelDirs: TLabel;
    btnCancelar: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ContinuaLista : Boolean;
     procedure IniciarBusca;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormListaArq: TFormListaArq;

implementation

uses principal, simple_id3v2;

{$R *.dfm}

procedure TFormListaArq.FormActivate(Sender: TObject);
begin
   ContinuaLista := True;
   IniciarBusca;
   Timer1.Enabled := True;
end;

procedure TFormListaArq.IniciarBusca;

    procedure LerTag(const Arquivo, Volume:String; Tamanho:Integer);

        function InvalidChar(Carac:Char):Boolean;
        begin
          Result := (Carac = #0) or (Carac = #13) or (Carac = #10);
        end;



       function LimpaCaracteresInvalidos(const Texto:string):String;
       var
         N :Integer;
         CharTemp :Char;
       begin
         if (Texto = '') then begin
           Result := '';
           exit;
         end;


         for N := 1 to Length(Texto) do begin
              charTemp := Texto[n];
              if InvalidChar(charTemp) then
                Result := Result+' '
              else
                Result := Result+charTemp;
         end;
       end;

       function PreparaTexto(const Texto : String; const Tamanho:Integer) :String;
       var
         N:Integer;
         sTexto : String;
       begin
         sTexto := Copy(   LimpaCaracteresInvalidos(  trim(Texto) )  ,1,Tamanho);
         for N := Length(sTexto) to Tamanho-1 do sTexto := sTexto+' ';
         Result := sTexto;
       end;


    var
     MFile: file;
     Tag: TIDTAGv1;
     nTemp, NumRead, n : Integer;
     sTempSaida, sTemp, DirTemp, ArqTemp : String;
     idTag : char;
     Diretorios : TStringList;
     DirComum : Boolean;
     ID3v2: TSimpleID3v2;
     bTagv2 :Boolean;
   begin
     ID3v2 := TSimpleID3v2.Create(self);
     bTagv2 := True;

     if 'C:\backup-cdrw\The Forest.mp3' = Arquivo then
       sleep(0);

     try
       ID3v2.LoadFromFile(Arquivo);
     except
       bTagv2 := False;
     end;


     // ********** TAG Ver 2 **********
     if bTagv2 and (ID3v2.Artist <> '') then begin
       sTempSaida := PreparaTexto(ID3v2.Title,30);
       sTempSaida := sTempSaida + PreparaTexto(ID3v2.Artist,30);
       sTempSaida := sTempSaida + PreparaTexto(ID3v2.Album,30);
       sTempSaida := sTempSaida + PreparaTexto(ID3v2.Year,4);
//       sTempSaida := sTempSaida + PreparaTexto(ID3v2.Genre,4);
//       sTempSaida := sTempSaida + PreparaTexto(ID3v2.Comment,30);
       sTempSaida := sTempSaida + PreparaTexto(Volume,30);
       ID3v2.Free;

       idTag := '2';
      end
      else begin
          ID3v2.Free;

          // ********** TAG Ver 1 **********
          AssignFile(MFile, Arquivo);
          try
          Reset(MFile, 1);
          Seek(MFile, Tamanho-128);
          BlockRead(MFile, Tag, SizeOf(Tag), NumRead);
          CloseFile(MFile);
          except
          end;
          if (copy(uppercase(Tag),0,3) = 'TAG') and (  not (trim(copy(TAG,4,30)) = '')    ) then begin
            for n := 3 to 126 do begin
              if InvalidChar(Tag[n]) then
                sTempSaida := sTempSaida+' '
              else
                sTempSaida := sTempSaida+Tag[n];
            end;
            sTempSaida[124] := ' ';
            idTag := '1';
          end
          else begin
            // ********** Por Arquivo **********
             for n := 0 to 136 do Tag[n] := #0;

             //Pega nome do ultimo diretorio
             sTemp := ExtractFilePath(Arquivo);
             sTemp := copy(sTemp, 0, length(sTemp)-1);
             n := length(sTemp);
             while not (sTemp[n] = '\') do n := n-1;
             DirTemp := copy(sTemp, n+1, length(sTemp));


             // Faz verifica��o se pasta  est� na lista das que
             // contem varias musicas de bandas diferentes

             DirComum := False;
             sTemp := FormPrincipal.Caminho+'pastas.txt';
             if FileExists(sTemp) then begin
               Diretorios := TStringList.Create;
               Diretorios.LoadFromFile(sTemp);
               for n := 0 to Diretorios.Count-1 do
                  if (uppercase(DirTemp) = Diretorios.Strings[n]) then
                    DirComum := True;
             end;

             //Essa cont�m v�rias musicas de bandas diferentes
             if DirComum then begin

               //Pega nome do arquivo
               sTemp := extractFileName(Arquivo);
               sTemp := copy(sTemp, 0, length(sTemp)-4);
               nTemp :=pos(FormPrincipal.Separador, sTemp);
               DirTemp := Trim(copy(sTemp, 0, nTemp-1));

               ArqTemp := Trim(copy(sTemp, nTemp+1, length(sTemp)-nTemp));

               for n := 1 to 30 do begin
                 if n-1 < length(ArqTemp) then
                   sTempSaida := sTempSaida+ArqTemp[n]
                 else
                   sTempSaida := sTempSaida+' ';
               end;

               for n := 1 to 30 do begin
                 if n-1 < length(DirTemp) then
                   sTempSaida := sTempSaida+DirTemp[n]
                 else
                   sTempSaida := sTempSaida+' ';
               end;
               idTag := 'O';
               sTempSaida := sTempSaida+'                                                                ';
             end

             //A pasta � o nome da banda
             else begin
               //Pega nome do arquivo
               sTemp := extractFileName(Arquivo);
               sTemp := copy(sTemp, 0, length(sTemp)-4);
               for n := 1 to 30 do begin
                 if n-1 < length(sTemp) then
                   sTempSaida := sTempSaida+sTemp[n]
                 else
                   sTempSaida := sTempSaida+' ';
               end;

               for n := 1 to 30 do begin
                 if n-1 < length(DirTemp) then
                   sTempSaida := sTempSaida+DirTemp[n]
                 else
                   sTempSaida := sTempSaida+' ';
               end;
               idTag := 'P';
               sTempSaida := sTempSaida+'                                                                ';
             end;
          end;
          sTempSaida := sTempSaida+PreparaTexto(LimpaCaracteresInvalidos(  Volume ) ,30) ;




{           for n := 1 to 30 do begin
             if n <= length(Volume) then begin
                charTemp := Volume[n];
                if Volume[n] = #0 then
                  sTempSaida := sTempSaida+' '
                else
                  sTempSaida := sTempSaida+charTemp;
             end
             else begin
                sTempSaida := sTempSaida+' ';
             end;

           end;}
      end;
       FormPrincipal.Lista.Add(idTag+sTempSaida+Arquivo);
    end;

    procedure ListaDir(Diretorio, Volume:String);
    var
      SR: TSearchRec;
      sTemp: String;
      nTemp : Integer;

    begin
      if DirectoryExists(Diretorio) then
        try
          if FindFirst(Diretorio+'\*.*', faAnyFile, sr) = 0 then begin
           repeat
              case sr.Attr of
                 faDirectory:
                    if (Sr.Name <> '.') and (Sr.Name <> '..') then begin
                      sTemp := concat(Diretorio,'\',Sr.Name);
                      LabelDir.Caption := sTemp;
                      ListaDir(sTemp, Volume);
                    end;
               else
                  sTemp := concat(Diretorio,'\',Sr.Name);
                  LabelArq.Caption := sTemp;
                  nTemp := Length(sTemp);
                  if uppercase(copy(sTemp, nTemp-3,nTemp)) = '.MP3' then LerTag(sTemp, Volume,SR.Size);
               end;
             Application.ProcessMessages;
           until FindNext(sr) <> 0;
          end;
        finally
           FindClose(sr);
        end;
    end;




begin
  FormPrincipal.Lista.BeginUpdate;
  ListaDir(FormPrincipal.Drive { 'E:\Program File' }, FormPrincipal.Volume);
  FormPrincipal.Lista.EndUpdate;
end;


procedure TFormListaArq.btnCancelarClick(Sender: TObject);
begin
  ContinuaLista := False;
end;

procedure TFormListaArq.Timer1Timer(Sender: TObject);
begin
  Visible := False;
  Close;

end;

procedure TFormListaArq.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

end.
