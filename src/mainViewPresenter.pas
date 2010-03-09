unit mainViewPresenter;

interface

uses
 mainView;

type
    ImainViewPresenter = interface
        ['{8F1ACF43-138A-4F38-B8D3-C22748A1B6D1}']
        procedure bindView(const mainView : IMainView);
        procedure generateNumber();
        procedure openFile();
        procedure saveFile();
        procedure exit;
    end;


implementation

end.

 