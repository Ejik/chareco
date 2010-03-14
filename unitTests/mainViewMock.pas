unit mainViewMock;

interface

uses
    Graphics, mainView, Forms;

type

    TMainViewMock = class(TInterfacedObject, IMainView)
    private
        IWorkspace : IGUIWorkspace;
    public
        constructor create();
        function getStatusBar(): IGUIStatusBar;
        function getWorkspace(): IGUIWorkspace;
        function getObject() : TForm;
    end;


implementation

uses
  guiWorkspaceMock;

{ TMainViewMock }

constructor TMainViewMock.create;
begin
    IWorkspace := TGUIWorkspaceMock.create();
end;

function TMainViewMock.getStatusBar: IGUIStatusBar;
begin

end;

function TMainViewMock.getObject: TForm;
begin
    
end;

function TMainViewMock.getWorkspace: IGUIWorkspace;
begin
    result := IWorkspace;    
end;


end.

 