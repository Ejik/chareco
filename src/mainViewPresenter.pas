unit mainViewPresenter;

interface

uses
    mainView;

type
    IMainViewPresenter = interface
        ['{8F1ACF43-138A-4F38-B8D3-C22748A1B6D1}']
        procedure bindView(const mainView: IMainView);
        procedure generateNumber();
        procedure exit;
        procedure openFile();
        procedure saveFile();
        procedure setViewOnlyMode(boolValue: boolean);
        procedure workSpaceImageMouseMove(x, y: integer);
    end;


implementation

end.

 