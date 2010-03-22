object fmInputNumDlg: TfmInputNumDlg
  Left = 479
  Top = 248
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1074#1074#1086#1076#1072' '#1085#1086#1084#1077#1088#1072
  ClientHeight = 106
  ClientWidth = 312
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 80
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088':'
  end
  object OKBtn: TButton
    Left = 70
    Top = 74
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 150
    Top = 74
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object MaskEdit: TMaskEdit
    Left = 10
    Top = 30
    Width = 293
    Height = 21
    EditMask = '>L 000 LL 000;1;_'
    ImeName = 'Russian'
    MaxLength = 12
    TabOrder = 2
    Text = 'X 777 AA 177'
  end
  object Button1: TButton
    Left = 230
    Top = 74
    Width = 75
    Height = 25
    HelpContext = 6
    Cancel = True
    Caption = #1055#1086#1084#1086#1097#1100
    ModalResult = 2
    TabOrder = 3
    OnClick = Button1Click
  end
end
