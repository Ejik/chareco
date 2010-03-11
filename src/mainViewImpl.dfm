object Form1: TForm1
  Left = 469
  Top = 269
  Width = 600
  Height = 398
  Caption = #1056#1072#1089#1087#1086#1079#1085#1072#1074#1072#1085#1080#1077' '#1089#1080#1084#1074#1086#1083#1086#1074
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
  object workspaceImage: TImage
    Left = 0
    Top = 0
    Width = 584
    Height = 321
    Align = alClient
    Center = True
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 321
    Width = 584
    Height = 19
    Panels = <>
  end
  object MainMenu1: TMainMenu
    Left = 25
    Top = 15
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
