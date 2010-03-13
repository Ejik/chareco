unit guiStatusBarImpl;

interface

uses
  mainView, Controls, ComCtrls;

type
    TGUIStatusBar = class (TInterfacedObject, IGUIStatusBar)
    private
        fStatusBar : TStatusBar;
    public
        constructor create(customStatusBar : TStatusBar);
        procedure setStatus(const msg: string; timeout: integer);
    end;

implementation

{ TGUIStatusBar }

constructor TGUIStatusBar.create(customStatusBar: TStatusBar);
begin
    fStatusBar := customStatusBar;
end;

procedure TGUIStatusBar.setStatus(const msg: string; timeout: integer);
begin

end;

end.
