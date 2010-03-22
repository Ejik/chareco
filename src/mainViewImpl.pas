unit mainViewImpl;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, mainView, mainViewPresenter, Menus,
    EBDIRegistry, EBDependencyInjection, mainViewModel, ExtCtrls, ComCtrls;
type
    TForm1 = class(TForm)
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
    N8: TMenuItem;
    N9: TMenuItem;
    autoLayoutMenuItem: TMenuItem;
    C1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N21: TMenuItem;
    Help1: TMenuItem;
        procedure N3Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure N4Click(Sender: TObject);
        procedure N5Click(Sender: TObject);
        procedure N6Click(Sender: TObject);
        procedure viewOnlyMenuItemClick(Sender: TObject);
    procedure workspaceImageMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure workspaceImageMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure N9Click(Sender: TObject);
    procedure autoLayoutMenuItemClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    private
    { Private declarations }
        presenter: IMainViewPresenter;
    public
    { Public declarations }
    end;

    TMainView = class(TInterfacedObject, IMainView)
    private
        fView: TForm1;
        { Private declarations }
    protected
        IStatusBar: IGUIStatusBar;
        IWorkspace: IGUIWorkspace;
    public
    { Public declarations }
        constructor create();
        destructor destroy(); override;
        function getObject(): TForm;
        function getStatusBar(): IGUIStatusBar;
        function getWorkspace(): IGUIWorkspace;
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
//    presenter.exit();
    close();
end;

procedure TForm1.viewOnlyMenuItemClick(Sender: TObject);
begin
    presenter.setViewOnlyMode(viewOnlyMenuItem.Checked);
end;


{ TMainView }

constructor TMainView.create;
begin
    fView := Form1;

    IWorkspace := TGUIWorkspace.create(fView.workspaceImage);
    IStatusBar := TGUIStatusBar.create(fView.StatusBar);

    InjectDependencies(self);
end;

destructor TMainView.destroy;
begin
    inherited;
end;

function TMainView.getStatusBar: IGUIStatusBar;
begin
    result := IStatusBar;
end;

function TMainView.getObject: TForm;
begin
    result := fView;
end;

function TMainView.getWorkspace: IGUIWorkspace;
begin
     result := IWorkspace;
end;

procedure TForm1.workspaceImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    presenter.workSpaceImageMouseMove(x, y);
end;

procedure TForm1.workspaceImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    presenter.workSpaceImageMouseDown(x, y);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
    presenter.clearLayout();
end;

procedure TForm1.autoLayoutMenuItemClick(Sender: TObject);
begin
    presenter.setAutoLayoutMode(autoLayoutMenuItem.Checked);
end;

procedure TForm1.N10Click(Sender: TObject);
begin
    presenter.showAboutBox();
end;

procedure TForm1.N12Click(Sender: TObject);
begin
    presenter.executeRecognition();
end;

procedure TForm1.N21Click(Sender: TObject);
begin
    presenter.executeRecognition(true);
end;

procedure TForm1.Help1Click(Sender: TObject);
begin
    presenter.openHelp();
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IMainView, TMainView, @TMainView.Create);

end.

