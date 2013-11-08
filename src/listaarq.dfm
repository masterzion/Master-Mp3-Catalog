object FormListaArq: TFormListaArq
  Left = 185
  Top = 199
  BorderStyle = bsDialog
  Caption = 'Procurando arquivos...'
  ClientHeight = 137
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LabelDir: TLabel
    Left = 0
    Top = 16
    Width = 383
    Height = 13
    Align = alTop
    Transparent = True
    WordWrap = True
  end
  object LabelArq: TLabel
    Left = 0
    Top = 45
    Width = 383
    Height = 13
    Align = alTop
    Transparent = True
    WordWrap = True
  end
  object LabelArqs: TLabel
    Left = 0
    Top = 0
    Width = 383
    Height = 16
    Align = alTop
    Caption = 'Diret'#243'rios:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LabelDirs: TLabel
    Left = 0
    Top = 29
    Width = 383
    Height = 16
    Align = alTop
    Caption = 'Arquivos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object btnCancelar: TSpeedButton
    Left = 112
    Top = 106
    Width = 129
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
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 112
    Top = 40
  end
end
