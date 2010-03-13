unit mainViewImpl;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, mainView, mainViewPresenter, Menus,
    EBDIRegistry, EBDependencyInjection, mainViewModel, ExtCtrls, ComCtrls;
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
    StatusBar: TStatusBar;
    workspaceImage: TImage;
    viewOnlyMenuItem: TMenuItem;
        procedure N3Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure N6Click(Sender: TObject);
    procedure viewOnlyMenuItemClick(Sender: TObject);
    private
    { Private declarations }
        presenter: IMainViewPresenter;
        model : IMainViewModel;

    protected

        IStatusBar : IGUIStatusBar;
        IWorkspace : IGUIWorkspace;

    public
    { Public declarations }
        function getView() : TForm;
        function getStatusBar() : IGUIStatusBar;
        function getWorkspace() : IGUIWorkspace;

    end;

var
    Form1: TForm1;

implementation

uses
  guiWorkspaceImpl, guiStatusBarImpl;


{$R *.dfm}

procedure TForm1.N3Click(Sender: TObject);
begin
    presenter.generateNumber();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    InjectDependencies(self);

    IWorkspace := TGUIWorkspace.create(workspaceImage);
    IStatusBar := TGUIStatusBar.create(StatusBar);

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
    close();
end;

function TForm1.getStatusBar: IGUIStatusBar;
begin
    result := IStatusBar;
end;

function TForm1.getWorkspace: IGUIWorkspace;
begin
    result := IWorkspace;
end;

function TForm1.getView: TForm;
begin
    result := self;
end;

procedure TForm1.viewOnlyMenuItemClick(Sender: TObject);
begin
    presenter.setViewOnlyMode(viewOnlyMenuItem.Checked);
end;

end.

