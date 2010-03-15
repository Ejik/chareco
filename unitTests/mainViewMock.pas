unit mainViewMock;

interface

uses
    Graphics, mainView, Forms;

type

    TMainViewMock = class(TInterfacedObject, IMainView)
    private
        IWorkspace : IGUIWorkspace;
        IStatusBar : IGUIStatusBar;
    public
        constructor create();
        function getStatusBar(): IGUIStatusBar;
        function getWorkspace(): IGUIWorkspace;
        function getObject() : TForm;
    end;


implementation

uses
  guiWorkspaceMock, guiStatusBarMock;

{ TMainViewMock }

constructor TMainViewMock.create;
begin
    IWorkspace := TGUIWorkspaceMock.create();
    IStatusBar := TGUIStatusBarMock.create();
end;

function TMainViewMock.getStatusBar: IGUIStatusBar;
begin
    result := IStatusBar;
end;

function TMainViewMock.getObject: TForm;
begin
    
end;

function TMainViewMock.getWorkspace: IGUIWorkspace;
begin
    result := IWorkspace;    
end;


end.

 