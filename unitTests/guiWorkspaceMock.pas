unit guiWorkspaceMock;

interface

uses
  mainView, Graphics;

type
    TGUIWorkspaceMock = class (TInterfacedObject, IGUIWorkspace)
        procedure setWorkspace(bitmap: TBitmap);
    end;

implementation

{ TGUIWorkspaceMock }

procedure TGUIWorkspaceMock.setWorkspace(bitmap: TBitmap);
begin

end;

end.
