object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'EXFiP QuickNotes 2'
  ClientHeight = 280
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 0
    Top = 0
    Width = 522
    Height = 21
    Align = alTop
    MaxLength = 50
    TabOrder = 0
    Text = 'EXFiPQuickNotes2'
    OnChange = ComboBox1Change
    OnSelect = ComboBox1Select
  end
  object Memo1: TMemo
    Left = 0
    Top = 21
    Width = 522
    Height = 259
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 376
    Top = 168
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        ShortCut = 16462
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        ShortCut = 16430
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = #1042#1099#1081#1090#1080' '#1073#1077#1079' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
        ShortCut = 49220
        OnClick = N4Click
      end
      object N6: TMenuItem
        Caption = #1042#1099#1081#1090#1080
        ShortCut = 16452
        OnClick = N6Click
      end
    end
    object N7: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N11: TMenuItem
        Caption = #1064#1088#1080#1092#1090
        OnClick = N11Click
      end
      object N12: TMenuItem
        AutoCheck = True
        Caption = #1047#1072#1076#1072#1074#1072#1090#1100' '#1074#1086#1087#1088#1086#1089' '#1087#1077#1088#1077#1076' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077#1084
        RadioItem = True
      end
    end
    object N8: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      object N5: TMenuItem
        Caption = #1051#1080#1094#1077#1085#1079#1080#1086#1085#1085#1086#1077' '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1077
        OnClick = N5Click
      end
      object N9: TMenuItem
        Caption = #1054#1085#1083#1072#1081#1085' '#1089#1087#1088#1072#1074#1082#1072
        OnClick = N9Click
      end
      object N13: TMenuItem
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
        OnClick = N13Click
      end
      object N10: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = N10Click
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 232
    Top = 168
  end
end
