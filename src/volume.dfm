object FormVolume: TFormVolume
  Left = 288
  Top = 199
  BorderStyle = bsDialog
  Caption = 'Adicionar Volume...'
  ClientHeight = 153
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnProcurar: TSpeedButton
    Left = 128
    Top = 120
    Width = 105
    Height = 25
    Caption = 'Procurar'
    Enabled = False
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000120B0000120B00001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      D44DD00D00D00DDD4744D00D00D00DD47444DDDDDDDDDD47444DDDDDD0000474
      44DDDDD00777F8444DDDDD0877777F80DDDDDD07777777F0DDDDD07777777777
      0DDDD077777777770DDDD07FE77777770DDDD07FE77777770DDDDD0FFEE77770
      DDDDDD08FFF77780DDDDDDD00777700DDDDDDDDDD0000DDDDDDD}
    OnClick = btnProcurarClick
  end
  object btnCancelar: TSpeedButton
    Left = 8
    Top = 120
    Width = 105
    Height = 25
    Caption = 'Cancelar'
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777780000087777777701999991077777709999999990777709999999999
      907781999999999991870999FF999FF9990709999FF9FF999907099999FFF999
      9907099999FFF999990709999FF9FF9999078199FF999FF99187709999999999
      9077770999999999077777701999991077777777800000877777}
    OnClick = btnCancelarClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 238
    Height = 113
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 234
      Height = 55
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object LabelUnit: TLabel
        Left = 0
        Top = 0
        Width = 234
        Height = 16
        Align = alTop
        Caption = 'Selecione o diret'#243'rio:'
        Color = clBlue
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object SpeedButton1: TSpeedButton
        Left = 208
        Top = 18
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF007F0000007F000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF007F000000BFBFBF007F0000007F000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF007F000000BFBFBF007F0000007F0000007F000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF007F000000BFBFBF007F0000007F0000007F000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000007F00
          0000BFBFBF007F0000007F0000007F000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000BFBFBF00BFBFBF00BFBFBF00FFFFFF007F7F
          7F007F0000007F0000007F000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00FFFF
          FF007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000BFBFBF00FFFFFF00FFFF0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000BFBFBF00FFFFFF00FFFF0000BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF00BFBFBF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFF0000FFFF0000BFBFBF00BFBFBF00BFBF
          BF00BFBFBF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000007F7F7F00FFFFFF00FFFFFF00FFFFFF00BFBFBF00BFBFBF00BFBF
          BF007F7F7F0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000BFBFBF00BFBFBF00BFBFBF00BFBFBF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0000000000000000000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = SpeedButton1Click
      end
      object edtDir: TEdit
        Left = 5
        Top = 19
        Width = 204
        Height = 21
        Enabled = False
        MaxLength = 12
        TabOrder = 0
        OnChange = EditNomeChange
        OnKeyPress = EditNomeKeyPress
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 57
      Width = 234
      Height = 54
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object LabelCD: TLabel
        Left = 0
        Top = 0
        Width = 234
        Height = 16
        Align = alTop
        Caption = 'Nome do CD:'
        Color = clBlue
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object EditNome: TEdit
        Left = 8
        Top = 24
        Width = 217
        Height = 21
        MaxLength = 30
        TabOrder = 0
        OnChange = EditNomeChange
        OnKeyPress = EditNomeKeyPress
      end
    end
  end
end
