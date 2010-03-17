unit aboutViewImpl;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
    Buttons, ExtCtrls, jpeg, aboutView;

type
    TAboutBox = class(TForm)
        OKButton: TButton;
        Comments: TLabel;
        ProgramIcon: TImage;
        ProductName: TLabel;
    private
    { Private declarations }
    public
    { Public declarations }
    end;

    TAboutView = class(TInterfacedObject, IAboutView)
    private
        fView: TAboutBox;
    public
        constructor create();
        destructor destroy(); override;
        procedure show();
    end;

var
    AboutBox: TAboutBox;

implementation

uses
  EBDIRegistry;

{$R *.dfm}

{ TAboutView }

constructor TAboutView.create;
begin
    fView := TAboutBox.Create(nil);
end;

destructor TAboutView.destroy;
begin
    freeAndNil(fView);
    inherited;
end;

procedure TAboutView.show;
begin
    fView.ShowModal();
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IAboutView, TAboutView, @TAboutView.Create);

end.

