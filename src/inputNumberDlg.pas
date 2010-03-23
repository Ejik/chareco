{*------------------------------------------------------------------------------
  Диалог для ввода номера  
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit inputNumberDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
    Buttons, Mask;

type
    TfmInputNumDlg = class(TForm)
        Label1: TLabel;
        OKBtn: TButton;
        CancelBtn: TButton;
        MaskEdit: TMaskEdit;
        Button1: TButton;
    procedure Button1Click(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
    end;

var
    fmInputNumDlg: TfmInputNumDlg;

implementation


{$R *.dfm}

procedure TfmInputNumDlg.Button1Click(Sender: TObject);
begin
    HtmlHelp(GetDesktopWindow, 'chareco help.chm', HH_HELP_CONTEXT, 5);

end;

end.

