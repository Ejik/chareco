unit guiWorkspaceImpl;

interface

uses
    mainView, Graphics, ExtCtrls;

type
    TGUIWorkspace = class(TInterfacedObject, IGUIWorkspace)
    private
        fWorkspace : TImage;
    public
        constructor create(image : TImage);
        procedure setWorkspace(bitmap: TBitmap);
    end;

implementation

{ TGUIWorkspace }

constructor TGUIWorkspace.create(image: TImage);
begin
    fWorkspace := image;
end;

procedure TGUIWorkspace.setWorkspace(bitmap: TBitmap);
begin
    fWorkspace.Picture.Graphic := bitmap;
end;

end.

