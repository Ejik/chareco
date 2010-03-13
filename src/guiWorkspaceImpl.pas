unit guiWorkspaceImpl;

interface

uses
    mainView, Graphics, ExtCtrls, Forms, Controls;

type
    TGUIWorkspace = class(TInterfacedObject, IGUIWorkspace)
    private
        fWorkspace: TImage;
    public
        constructor create(image: TImage);

        function getCursor(): TCursor;

        procedure setCursor(cursor: TCursor);
        procedure setWorkspace(bitmap: TBitmap);
    end;

implementation

{ TGUIWorkspace }

constructor TGUIWorkspace.create(image: TImage);
begin
    fWorkspace := image;
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

