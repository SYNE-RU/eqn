object Form1: TForm1
  Left = 699
  Height = 280
  Top = 357
  Width = 522
  Caption = 'EXFiP QuickNotes'
  ClientHeight = 260
  ClientWidth = 522
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Menu = MainMenu1
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  LCLVersion = '1.6.4.0'
  object ComboBox1: TComboBox
    Left = 0
    Height = 21
    Top = 0
    Width = 522
    Align = alTop
    ItemHeight = 13
    MaxLength = 50
    OnKeyPress = ComboBox1KeyPress
    OnSelect = ComboBox1Select
    TabOrder = 0
    Text = 'EXFiPQuickNotes'
  end
  object Memo1: TMemo
    Left = 0
    Height = 239
    Top = 21
    Width = 522
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    left = 376
    top = 168
    object N1: TMenuItem
      Caption = 'Файл'
      object N2: TMenuItem
        Caption = 'Создать новый документ'
        ShortCut = 16462
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = 'Удалить текущий документ'
        ShortCut = 16430
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = 'Выйти без сохранения'
        ShortCut = 49220
        OnClick = N4Click
      end
      object N6: TMenuItem
        Caption = 'Выйти'
        ShortCut = 16452
        OnClick = N6Click
      end
    end
    object N7: TMenuItem
      Caption = 'Настройки'
      object N11: TMenuItem
        Caption = 'Шрифт'
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = 'Задавать вопрос перед сохранением'
        RadioItem = True
        OnClick = N12Click
      end
    end
    object N8: TMenuItem
      Caption = 'О программе...'
      object N10: TMenuItem
        Caption = 'О программе...'
        OnClick = N10Click
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    MinFontSize = 0
    MaxFontSize = 0
    left = 232
    top = 168
  end
end
