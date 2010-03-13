unit guiWorkspaceMock;

interface

uses
    mainView, Graphics, Forms, Controls;

type
    TGUIWorkspaceMock = class(TInterfacedObject, IGUIWorkspace)

        function getCursor(): TCursor;

        procedure setCursor(cursor: TCursor);
        procedure setWorkspace(bitmap: TBitmap);
    end;

implementation

{ TGUIWorkspaceMock }

function TGUIWorkspaceMock.getCursor: TCursor;
begin

end;

procedure TGUIWorkspaceMock.setCursor(cursor: TCursor);
begin

end;

procedure TGUIWorkspaceMock.setWorkspace(bitmap: TBitmap);
begin

end;

end.

