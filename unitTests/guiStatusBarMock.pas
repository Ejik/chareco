unit guiStatusBarMock;

interface

uses
  mainView;

type
    TGUIStatusBarMock = class (TInterfacedObject, IGUIStatusBar)
        procedure setStatus(const msg: string; timeout: integer = 0);
    end;

implementation

{ TGUIStatusBarMock }

procedure TGUIStatusBarMock.setStatus(const msg: string; timeout: integer);
begin

end;

end.
 