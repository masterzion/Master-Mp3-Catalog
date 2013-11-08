object FormInfo: TFormInfo
  Left = 303
  Top = 119
  BorderStyle = bsDialog
  Caption = 'Info de'
  ClientHeight = 201
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 160
    Width = 309
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 120
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 309
    Height = 160
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Info'
      object Label1: TLabel
        Tag = 38
        Left = 8
        Top = 48
        Width = 32
        Height = 13
        Caption = 'Artista:'
      end
      object Bevel1: TBevel
        Left = 8
        Top = 40
        Width = 289
        Height = 2
      end
      object Label2: TLabel
        Tag = 39
        Left = 8
        Top = 64
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object Label3: TLabel
        Tag = 40
        Left = 8
        Top = 80
        Width = 32
        Height = 13
        Caption = 'Album:'
      end
      object Label4: TLabel
        Tag = 41
        Left = 8
        Top = 96
        Width = 22
        Height = 13
        Caption = 'Ano:'
      end
      object Image1: TImage
        Left = 8
        Top = 0
        Width = 25
        Height = 33
        Center = True
        Picture.Data = {
          07544269746D6170F6000000424DF60000000000000076000000280000001000
          000010000000010004000000000080000000120B0000120B0000100000001000
          0000000000000000BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0
          C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00DDDDDDDDDDDDDDDDDDD80008DDDDDDDDDD8000008DDDDDDDDD8000000DDD
          DDDDDDD800080DDDDDDDDDDDDDDD0DD0DDDDDDDDDDDD0DDD0DDDDDDDDDDD0DDD
          0DDDDDDDDDDD0DDD0DDDDDDDDDDD0DDD0DDDDDDDDDDD0DD08DDDDDDDDDDD0000
          DDDDDDDDDDDD000DDDDDDDDDDDDD00DDDDDDDDDDDDDD08DDDDDDDDDDDDDD0DDD
          DDDD}
        Transparent = True
      end
      object Label5: TLabel
        Tag = 42
        Left = 8
        Top = 112
        Width = 56
        Height = 13
        Caption = 'Coment'#225'rio:'
      end
      object Label7: TLabel
        Tag = 45
        Left = 44
        Top = 2
        Width = 39
        Height = 13
        Caption = 'Arquivo:'
      end
      object LabelArtista: TLabel
        Left = 72
        Top = 48
        Width = 3
        Height = 13
      end
      object LabelNome: TLabel
        Tag = 1
        Left = 72
        Top = 64
        Width = 3
        Height = 13
      end
      object LabelAlbum: TLabel
        Left = 72
        Top = 80
        Width = 3
        Height = 13
      end
      object LabelAno: TLabel
        Left = 72
        Top = 96
        Width = 3
        Height = 13
      end
      object LabelComentario: TLabel
        Left = 72
        Top = 112
        Width = 3
        Height = 13
      end
      object LabelArquivo: TLabel
        Left = 47
        Top = 23
        Width = 3
        Height = 13
      end
    end
  end
end
