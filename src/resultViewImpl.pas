unit resultViewImpl;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
    Buttons, ExtCtrls, resultView, EBInjectable;

type
    TOKBottomDlg = class(TForm)
        OKBtn: TButton;
        Bevel1: TBevel;
        Memo1: TMemo;
    private
    { Private declarations }
    public
    { Public declarations }
    end;

    TResultView = class(TInjectable, IResultView)
    private
        fView: TOKBottomDlg;
        fOwner : TCOmponent;
        fData : TStringList;
    public
        destructor destroy(); override;

        procedure bind(owner: TComponent; data: TStringList);
        procedure show();
    end;

var
    OKBottomDlg: TOKBottomDlg;

implementation

uses
  EBDIRegistry;

{$R *.dfm}

{ TResultView }

procedure TResultView.bind(owner: TComponent; data: TStringList);
begin
    fOwner := owner;
    fData := data;
end;

destructor TResultView.destroy;
begin
    freeAndNil(fView);
    inherited;
end;

procedure TResultView.show;
var
    i : integer;
begin
    fView := TOKBottomDlg.Create(fOwner);
    for i := 0 to fData.Count - 1 do
    begin
        fView.Memo1.Lines.Add(fData[i]);
    end;

    fView.ShowModal();
end;

initialization
    GetDIRegistry.RegisterFactory(IResultView, TResultView, @TResultView.Create);

end.

