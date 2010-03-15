unit guiStatusBarMock;

interface

uses
  mainView;

type
    TGUIStatusBarMock = class (TInterfacedObject, IGUIStatusBar)
        procedure setStatus(const msg: string; timeout: integer = 0; threaded: boolean = true);
    end;

implementation

{ TGUIStatusBarMock }

procedure TGUIStatusBarMock.setStatus(const msg: string; timeout: integer = 0; threaded: boolean = true);
begin

end;

end.
 