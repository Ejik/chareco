unit guiWorkspaceMock;

interface

uses
    mainView, Graphics, Forms, Controls, WinTypes;

type
    TGUIWorkspaceMock = class(TInterfacedObject, IGUIWorkspace)

        function getClientArea() : TRect;
        function getCursor(): TCursor;
        function getWorkspaceBitmap() : Graphics.TBitmap;

        procedure setCursor(cursor: TCursor);
        procedure setWorkspaceBitmap(bitmap: Graphics.TBitmap);
    end;

implementation

{ TGUIWorkspaceMock }

function TGUIWorkspaceMock.getClientArea: TRect;
begin

end;

function TGUIWorkspaceMock.getCursor: TCursor;
begin

end;

function TGUIWorkspaceMock.getWorkspaceBitmap: Graphics.TBitmap;
begin

end;

procedure TGUIWorkspaceMock.setCursor(cursor: TCursor);
begin

end;

procedure TGUIWorkspaceMock.setWorkspaceBitmap(bitmap: Graphics.TBitmap);
begin

end;

end.

