{*------------------------------------------------------------------------------
  Интерфейсы главного вида и элементов, расположенных на главном виде 
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit mainView;

interface

uses
    Forms, Controls, WinTypes, Graphics;
const
    kernel = 'kernel32.dll';

type
    IGUIBaseInterface = interface
        ['{D64BB2DD-2F13-46CC-8B77-9BE6C8D1BBF9}']
    end;

    IGUIStatusBar = interface(IGUIBaseInterface)
        ['{77294803-AF91-4FD1-9035-B38F08A4641E}']
        procedure setStatus(const msg: string; timeout: integer = 0; threaded: boolean = true);
    end;

    IGUIWorkspace = interface(IGUIBaseInterface)
        ['{0E9C98BC-FD12-401D-890A-43F729F53218}']

        function getCursor(): TCursor;
        function getClientArea() : TRect;
        function getWorkspaceBitmap() : Graphics.TBitmap;

        procedure setCursor(cursor: TCursor);
        procedure setWorkspaceBitmap(bitmap: Graphics.TBitmap);
    end;

    IMainView = interface
        ['{5D732046-6966-4000-98AB-BDC7CB5D0B07}']
        function getObject(): TForm;
        function getStatusBar(): IGUIStatusBar;
        function getWorkspace(): IGUIWorkspace;
    end;

implementation


end.

