unit guiThreadImpl;

interface

uses
    Classes, mainView, ComCtrls, Controls, Windows, Forms;

type
    TGUIThread = class(TThread)
    private
    { Private declarations }
        fStatusBar: TStatusBar;
        fTimeOut: Longint;
        fMessage: string;

        procedure updateStatusBar();
        procedure delay(ms: longint);

    protected
        procedure Execute; override;

    public
        constructor Create(CreateSuspended: Boolean; const msg: string; timeout: integer);
        procedure bindStatusBar(control: TStatusBar);
    end;

implementation


{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TGUIThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TGUIThread }

procedure TGUIThread.bindStatusBar(control: TStatusBar);
begin
    fStatusBar := control;
end;

constructor TGUIThread.Create(CreateSuspended: Boolean;
    const msg: string; timeout: integer);
begin
    inherited Create(CreateSuspended);
    fMessage := msg;
    fTimeOut := timeout;
end;

procedure TGUIThread.delay(ms: Integer);
var
    TheTime: LongInt;
begin
    TheTime := getTickCount() + ms;
    while GetTickCount < TheTime do
        Application.ProcessMessages;

end;

procedure TGUIThread.Execute;
begin
  { Place thread code here }
    Synchronize(updateStatusBar);
end;

procedure TGUIThread.updateStatusBar;
begin
    fStatusBar.SimpleText := fMessage;
    if (fTimeOut > 0) then
    begin
        delay(fTimeOut);
        fStatusBar.SimpleText := '';
    end;
end;

end.

