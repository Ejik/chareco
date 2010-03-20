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
    private
    { Private declarations }
    public
    { Public declarations }
    end;

var
    fmInputNumDlg: TfmInputNumDlg;

implementation

{$R *.dfm}

end.

