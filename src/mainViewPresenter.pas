{*------------------------------------------------------------------------------
  Интрейфейс презентера   
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit mainViewPresenter;

interface

uses
    mainView;

type
    IMainViewPresenter = interface
        ['{8F1ACF43-138A-4F38-B8D3-C22748A1B6D1}']
        procedure bindView(const mainView: IMainView);
        procedure generateNumber();
        procedure clearLayout();
        procedure executeRecognition(boolWholeNumber: boolean = false);
        procedure openFile();
        procedure saveFile();
        procedure openHelp();
        procedure showAboutBox();
        procedure setViewOnlyMode(boolValue: boolean);
        procedure setAutoLayoutMode(boolValue: boolean);
        procedure workSpaceImageMouseMove(x, y: integer);
        procedure workSpaceImageMouseDown(x, y: integer);
    end;


implementation

end.

 