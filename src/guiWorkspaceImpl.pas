unit guiWorkspaceImpl;

interface

uses
    mainView, ExtCtrls, Forms, Controls, Wintypes, Graphics;

type
    TGUIWorkspace = class(TInterfacedObject, IGUIWorkspace)
    private
        fWorkspace: TImage;
    public
        constructor create(image: TImage);

        function getCursor(): TCursor;
        function getClientArea(): TRect;

        procedure setCursor(cursor: TCursor);
        procedure setWorkspace(bitmap: Graphics.TBitmap);
    end;

implementation

{ TGUIWorkspace }

constructor TGUIWorkspace.create(image: TImage);
begin
    fWorkspace := image;
end;

function TGUIWorkspace.getClientArea: TRect;
begin
    result := fWorkspace.ClientRect;
end;

function TGUIWorkspace.getCursor: TCursor;
begin
    result := fWorkspace.Cursor;
end;

procedure TGUIWorkspace.setCursor(cursor: TCursor);
begin
    fWorkspace.Cursor := cursor;
end;

procedure TGUIWorkspace.setWorkspace(bitmap: TBitmap);
begin
    fWorkspace.Picture.Graphic := bitmap;
end;

end.

