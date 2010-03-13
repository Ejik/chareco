unit guiStatusBarImpl;

interface

uses
    mainView, Controls, ComCtrls;

type
    TGUIStatusBar = class(TInterfacedObject, IGUIStatusBar)
    private
        fStatusBar: TStatusBar;
        procedure delay(ms: longint);
    public
        constructor create(customStatusBar: TStatusBar);
        procedure setStatus(const msg: string; timeout: integer);
    end;

implementation

uses
  Windows, Forms;

{ TGUIStatusBar }

constructor TGUIStatusBar.create(customStatusBar: TStatusBar);
begin
    fStatusBar := customStatusBar;
end;

procedure TGUIStatusBar.delay(ms: Integer);
var
    TheTime: LongInt;
begin
    TheTime := getTickCount() + ms;
    while GetTickCount < TheTime do
        Application.ProcessMessages;
end;


procedure TGUIStatusBar.setStatus(const msg: string; timeout: integer);
begin
    fStatusBar.SimpleText := msg;
    delay(timeout);
    fStatusBar.SimpleText := '';
end;

end.

