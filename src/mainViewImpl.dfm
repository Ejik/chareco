object Form1: TForm1
  Left = 192
  Top = 175
  Width = 1142
  Height = 656
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 155
    Top = 100
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N4: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        OnClick = N5Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N6: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N6Click
      end
    end
    object N2: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      object N3: TMenuItem
        Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1084#1077#1088
        OnClick = N3Click
      end
    end
  end
end
