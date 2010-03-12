unit mainViewMock;

interface

uses
    Graphics, mainView;

type
    //IMainViewMock = interface
    //['{54C8BD95-C208-4E96-8EFE-1175842A6CB5}']
    //end;

    TMainViewMock = class(TInterfacedObject, IMainView)
        procedure setupWorkspace(bitmap : TBitmap);
    end;


implementation

{ TMainViewMock }

procedure TMainViewMock.setupWorkspace(bitmap: TBitmap);
begin
    
end;

end.
 