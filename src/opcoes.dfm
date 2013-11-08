object FormOpcoes: TFormOpcoes
  Left = 254
  Top = 215
  BorderStyle = bsSingle
  Caption = 'Op'#231#245'es'
  ClientHeight = 238
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 197
    Width = 310
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    object btnFechar: TSpeedButton
      Left = 216
      Top = 8
      Width = 73
      Height = 22
      Caption = 'Fechar'
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
      OnClick = btnFecharClick
    end
    object btnSalvar: TSpeedButton
      Left = 16
      Top = 8
      Width = 73
      Height = 22
      Caption = 'Salvar'
      Flat = True
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
        00001F7C1F7C1F7C86312B462B46082108210821E71CE71CE71C18631863E71C
        2B4600001F7C1F7C86312B462B464A29082108210821E71CE71C5A6B1863E71C
        2B4600001F7C1F7C863110632B464A294A29082108210821E71C5A6B5A6BE71C
        2B4600001F7C1F7C8631106310634A294A294A29082108210821E71CE71CE71C
        2B4600001F7C1F7C86311063106310632B462B462B462B462B462B462B462B46
        2B4600001F7C1F7C863133671063803180318031803180318031803180312B46
        2B4600001F7C1F7C863133672B46F97FF97FF97FF97FF37FF37FF37FF37F8031
        2B4600001F7C1F7C863133672B46FF7FF97FF97FF97FF97FF37FF37FF37F8031
        2B4600001F7C1F7C863133672B46FF7FFF7FF97FF97FF97FF97FF37FF37F8031
        2B4600001F7C1F7C863133672B46FF7FFF7FFF7FF97FF97FF97FF97FF37F8031
        2B4600001F7C1F7C8631F97F2B46FF7FFF7FFF7FFF7FF97FF97FF97FF97F8031
        803100001F7C1F7C8631F97F2B46FF7FFF7FFF7FFF7FFF7FF97FF97FF97F8031
        F97F00001F7C1F7C863186312B46863186318631863186318631863186318631
        863100001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      OnClick = btnSalvarClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 310
    Height = 197
    ActivePage = TabSheet3
    Align = alClient
    HotTrack = True
    Style = tsButtons
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Lingua'
      object RadioGroup1: TRadioGroup
        Left = 0
        Top = 0
        Width = 302
        Height = 166
        Align = alClient
        Columns = 2
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Player'
      ImageIndex = 1
      object SpeedButton4: TSpeedButton
        Left = 272
        Top = 16
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F0000000120B0000120B00001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777700007777777777777777777700007777700000000000007700007777
          8888888888880077000077778FB7B7B7B7B8007700007778FB7B7B7B7B708077
          00007778F7B7B7B7B78080770000778F7B7B7B7B7B0880770000778FFFFFFFFF
          F80780770000778888888888888B807700007778F7B7B7B7B7B7807700007778
          FB7B7B7FFFFF807700007778F7B7B7F888888777000077778FFFFF8777777777
          0000777778888877777777770000777777777777777777770000777777777777
          7777777700007777777777777777777700007777777777777777777700007777
          77777777777777770000}
        OnClick = SpeedButton4Click
      end
      object LabeledEdit1: TLabeledEdit
        Left = 8
        Top = 16
        Width = 265
        Height = 21
        EditLabel.Width = 44
        EditLabel.Height = 13
        EditLabel.Caption = 'Caminho:'
        TabOrder = 0
      end
      object LabeledEdit2: TLabeledEdit
        Left = 8
        Top = 64
        Width = 289
        Height = 21
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Parametros:'
        TabOrder = 1
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 104
        Width = 169
        Height = 17
        Caption = 'Abrir PlayList depois de salva'
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Pastas'
      ImageIndex = 2
      object LabelPasta: TLabel
        Left = 0
        Top = 0
        Width = 302
        Height = 13
        Align = alTop
        Caption = 'Coloque aqui as pastas que tenham mp3 de bandas diferentes:'
      end
      object MemoPastas: TMemo
        Left = 0
        Top = 13
        Width = 302
        Height = 116
        Align = alClient
        Lines.Strings = (
          'OTHERS'
          'OUTROS'
          'SOUND'
          'SOM'
          'SHARED'
          'COMPARTILHADA')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 129
        Width = 302
        Height = 37
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 1
        object LabelDelimitador: TLabel
          Left = 8
          Top = 8
          Width = 52
          Height = 13
          Caption = 'Delimitador'
        end
        object EditSeparador: TEdit
          Left = 176
          Top = 8
          Width = 105
          Height = 21
          TabOrder = 0
          Text = '-'
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.exe'
    Filter = 
      'Programas(*.exe;*.com;*.bat)|*.exe;*.com;*.bat|Todos os arquivos' +
      ' (*.*)|*.*'
    Left = 248
    Top = 88
  end
end
