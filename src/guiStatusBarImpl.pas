unit guiStatusBarImpl;

interface

uses
    mainView, Controls, ComCtrls;

type
    TGUIStatusBar = class(TInterfacedObject, IGUIStatusBar)
    private
        fStatusBar: TStatusBar;
        procedure delay(ms: Integer);
    public
        constructor create(customStatusBar: TStatusBar);
        procedure setStatus(const msg: string; timeout: integer = 0; threaded: boolean = true);
    end;

implementation

uses
    Windows, Forms, guiThreadImpl;

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

procedure TGUIStatusBar.setStatus(const msg: string; timeout: integer = 0; threaded: boolean = true);
var
    guiThread: TGUIThread;
begin
    if (threaded) then
    begin
        guiThread := TGUIThread.create(true, msg, timeout);
        guiThread.bindStatusBar(fStatusBar);
        guiThread.FreeOnTerminate := true;
        guiThread.Resume;
        Application.ProcessMessages;
    end
    else
    begin
        fStatusBar.SimpleText := msg;
        if (timeout > 0) then
        begin
            delay(timeout);
            fStatusBar.SimpleText := '';
        end;
    end;
end;

end.

