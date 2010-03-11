object fmInputNumDlg: TfmInputNumDlg
  Left = 473
  Top = 244
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075' '#1074#1074#1086#1076#1072' '#1085#1086#1084#1077#1088#1072
  ClientHeight = 92
  ClientWidth = 233
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
    Top = 59
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 150
    Top = 59
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object MaskEdit: TMaskEdit
    Left = 10
    Top = 30
    Width = 205
    Height = 21
    EditMask = 'L 000 LL;1;_'
    ImeName = 'Russian'
    MaxLength = 8
    TabOrder = 2
    Text = 'x 777 aa'
  end
end
