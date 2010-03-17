object OKBottomDlg: TOKBottomDlg
  Left = 586
  Top = 346
  BorderStyle = bsDialog
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1072#1085#1072#1083#1080#1079#1072
  ClientHeight = 214
  ClientWidth = 313
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 297
    Height = 161
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 114
    Top = 180
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 15
    Top = 15
    Width = 281
    Height = 146
    Align = alCustom
    ImeName = 'Russian'
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
