unit mainViewImpl;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, mainView, mainViewPresenter, Menus,
    EBDIRegistry, EBDependencyInjection;
type
    TForm1 = class(TForm, IMainView)
        MainMenu1: TMainMenu;
        N1: TMenuItem;
        N2: TMenuItem;
        N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
        procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    private
    { Private declarations }
        presenter: ImainViewPresenter;
    public
    { Public declarations }

    end;

var
    Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.N3Click(Sender: TObject);
begin
    presenter.generateNumber();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    InjectDependencies(self);
    presenter.bindView(self);
end;

procedure TForm1.N4Click(Sender: TObject);
begin
    presenter.openFile();
end;

procedure TForm1.N5Click(Sender: TObject);
begin
    presenter.saveFile();
end;

procedure TForm1.N6Click(Sender: TObject);
begin
    presenter.exit();
end;

end.

