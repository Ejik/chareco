unit mainView;

interface

uses
    Graphics, Forms;

type
    IGUIBaseInterface = interface
        ['{D64BB2DD-2F13-46CC-8B77-9BE6C8D1BBF9}']
    end;

    IGUIStatusBar = interface(IGUIBaseInterface)
        ['{77294803-AF91-4FD1-9035-B38F08A4641E}']
        procedure setStatus(const msg: string; timeout: integer);
    end;

    IGUIWorkspace = interface(IGUIBaseInterface)
        ['{0E9C98BC-FD12-401D-890A-43F729F53218}']
        procedure setWorkspace(bitmap: TBitmap);
    end;

    IMainView = interface
        ['{5D732046-6966-4000-98AB-BDC7CB5D0B07}']
        function getView() : TForm;
        function getStatusBar() : IGUIStatusBar;
        function getWorkspace() : IGUIWorkspace;
    end;

implementation

end.

