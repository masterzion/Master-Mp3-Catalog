object FormExportHTML: TFormExportHTML
  Left = 455
  Top = 315
  Width = 535
  Height = 378
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Exportar HTML'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 527
    Height = 344
    ActivePage = TabSheetEdita
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = PageControlChange
    object TabSheetEdita: TTabSheet
      Caption = 'Propriedades da p'#225'gina'
      object LabelCorFonte: TLabel
        Left = 241
        Top = 64
        Width = 71
        Height = 13
        Caption = 'Cor da fonte'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelCorFundo: TLabel
        Left = 241
        Top = 96
        Width = 74
        Height = 13
        Caption = 'Cor do fundo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpeedButonExport: TSpeedButton
        Left = 208
        Top = 272
        Width = 89
        Height = 33
        Caption = 'Exportar'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000FF00FF00FF00FF00FF00FF003060
          60005F8F8F005F8F8F004040400040404000404040003F3F3F003F3F3F003F3F
          3F00C0C0C000C0C0C0003F3F3F005F8F8F0000000000FF00FF00FF00FF003060
          60005F8F8F005F8F8F00505050004040400040404000404040003F3F3F003F3F
          3F00D0D0D000C0C0C0003F3F3F005F8F8F0000000000FF00FF00FF00FF003060
          600080C0C0005F8F8F0050505000505050004040400040404000404040003F3F
          3F00D0D0D000D0D0D0003F3F3F005F8F8F0000000000FF00FF00FF00FF003060
          600080C0C00080C0C00050505000505050005050500040404000404040004040
          40003F3F3F003F3F3F003F3F3F005F8F8F0000000000FF00FF00FF00FF003060
          600080C0C00080C0C00080C0C0005F8F8F005F8F8F005F8F8F005F8F8F005F8F
          8F005F8F8F005F8F8F005F8F8F005F8F8F0000000000FF00FF00FF00FF003060
          60009FCFCF0080C0C00000606000006060000060600000606000006060000060
          600000606000006060005F8F8F005F8F8F0000000000FF00FF00FF00FF003060
          60009FCFCF005F8F8F00CFFFFF00CFFFFF00CFFFFF00CFFFFF009FFFFF009FFF
          FF009FFFFF009FFFFF00006060005F8F8F0000000000FF00FF00FF00FF003060
          60009FCFCF005F8F8F00FFFFFF00CFFFFF00CFFFFF00CFFFFF00CFFFFF009FFF
          FF009FFFFF009FFFFF00006060005F8F8F0000000000FF00FF00FF00FF003060
          60009FCFCF005F8F8F00FFFFFF00FFFFFF00CFFFFF00CFFFFF00CFFFFF00CFFF
          FF009FFFFF009FFFFF00006060005F8F8F0000000000FF00FF00FF00FF003060
          60009FCFCF005F8F8F00FFFFFF00FFFFFF00FFFFFF00CFFFFF00CFFFFF00CFFF
          FF00CFFFFF009FFFFF00006060005F8F8F0000000000FF00FF00FF00FF003060
          6000CFFFFF005F8F8F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CFFFFF00CFFF
          FF00CFFFFF00CFFFFF00006060000060600000000000FF00FF00FF00FF003060
          6000CFFFFF005F8F8F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CFFF
          FF00CFFFFF00CFFFFF0000606000CFFFFF0000000000FF00FF00FF00FF003060
          6000306060005F8F8F0030606000306060003060600030606000306060003060
          60003060600030606000306060003060600000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = SpeedButonExportClick
      end
      object SpeedClose: TSpeedButton
        Left = 328
        Top = 272
        Width = 89
        Height = 33
        Caption = 'Fechar'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF0000FFFF00007F7F007F7F7F00000000000000000000000000000000000000
          00000000000000000000007F7F0000FFFF00FF00FF00FF00FF00FF00FF00FF00
          FF0000FFFF0000FFFF007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF000000000000000000007F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00007F7F0000FFFF007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF0000000000007F7F007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF0000000000007F7F0000000000FF00FF00FF00FF00FF00FF00FF00
          FF0000000000000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF000000000000FFFF00007F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00007F7F00000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF000000000000FFFF0000FFFF00FF00FF00FF00FF00FF00FF00FF00
          FF0000FFFF00007F7F007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF0000000000007F7F0000FFFF00FF00FF00FF00FF00FF00FF00FF00
          FF0000FFFF0000FFFF007F7F7F00BFBFBF007F7F7F007F7F7F007F7F7F007F7F
          7F00BFBFBF000000000000000000007F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00007F7F0000FFFF007F7F7F00BFBFBF007F7F7F007F7F7F007F7F7F007F7F
          7F00BFBFBF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF0000000000007F7F007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF0000000000007F7F0000000000FF00FF00FF00FF00FF00FF00FF00
          FF0000000000000000007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
          BF00BFBFBF000000000000FFFF00007F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00007F7F00000000007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
          7F007F7F7F007F7F7F0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF00FF00
          FF0000FFFF00007F7F000000000000000000007F7F0000FFFF0000FFFF00007F
          7F000000000000000000007F7F0000FFFF00FF00FF00FF00FF00FF00FF00FF00
          FF0000FFFF0000FFFF00007F7F000000000000000000007F7F0000FFFF0000FF
          FF00007F7F000000000000000000007F7F00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = SpeedCloseClick
      end
      object LabelCabCorFundo: TLabel
        Left = 265
        Top = 184
        Width = 74
        Height = 13
        Caption = 'Cor do fundo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelCabCorFonte: TLabel
        Left = 265
        Top = 152
        Width = 71
        Height = 13
        Caption = 'Cor da fonte'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ComboCorFonte: TColorBox
        Left = 201
        Top = 59
        Width = 37
        Height = 22
        Style = [cbStandardColors, cbExtendedColors]
        ItemHeight = 16
        TabOrder = 2
      end
      object ComboCorFundo: TColorBox
        Left = 201
        Top = 91
        Width = 37
        Height = 22
        DefaultColorColor = clSkyBlue
        NoneColorColor = clSkyBlue
        Selected = clSkyBlue
        Style = [cbStandardColors, cbExtendedColors]
        ItemHeight = 16
        TabOrder = 3
      end
      object PanelTitulo: TPanel
        Left = 0
        Top = 0
        Width = 519
        Height = 41
        Align = alTop
        TabOrder = 0
        object LabelTitulo: TLabel
          Left = 32
          Top = 13
          Width = 33
          Height = 13
          Caption = 'Titulo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object EditTitulo: TEdit
          Left = 72
          Top = 8
          Width = 441
          Height = 21
          TabOrder = 0
          OnKeyPress = EditTituloKeyPress
        end
      end
      object chkCabecalho: TCheckBox
        Left = 201
        Top = 128
        Width = 153
        Height = 17
        Caption = 'Adicionar cabe'#231'alho'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 4
        OnClick = chkCabecalhoClick
      end
      object ComboCorTitulo: TColorBox
        Left = 225
        Top = 179
        Width = 37
        Height = 22
        Style = [cbStandardColors, cbExtendedColors]
        ItemHeight = 16
        TabOrder = 6
      end
      object ComboCorFonteTitulo: TColorBox
        Left = 225
        Top = 147
        Width = 37
        Height = 22
        DefaultColorColor = clWhite
        NoneColorColor = clWhite
        Selected = clWhite
        Style = [cbStandardColors, cbExtendedColors]
        ItemHeight = 16
        TabOrder = 5
      end
      object PanelLista: TPanel
        Left = 0
        Top = 41
        Width = 177
        Height = 272
        Align = alLeft
        TabOrder = 1
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 175
          Height = 32
          Align = alTop
          TabOrder = 0
          object CheckBox: TCheckBox
            Left = 8
            Top = 8
            Width = 41
            Height = 17
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = CheckBoxClick
          end
        end
        object CheckListBox: TCheckListBox
          Left = 1
          Top = 33
          Width = 175
          Height = 238
          OnClickCheck = CheckListBoxClickCheck
          Align = alClient
          DragMode = dmAutomatic
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnDragDrop = CheckListBoxDragDrop
          OnDragOver = CheckListBoxDragOver
          OnKeyPress = CheckListBoxKeyPress
          OnStartDrag = CheckListBoxStartDrag
        end
      end
      object Panel1: TPanel
        Left = 190
        Top = 120
        Width = 222
        Height = 3
        TabOrder = 7
      end
    end
    object TabSheetPreview: TTabSheet
      Caption = 'Visualizar'
      ImageIndex = 1
      object WebBrowser: TWebBrowser
        Left = 0
        Top = 0
        Width = 546
        Height = 374
        Align = alClient
        TabOrder = 0
        ControlData = {
          4C0000006E380000A72600000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'HTML|*.html'
    Left = 428
    Top = 195
  end
end
