{*------------------------------------------------------------------------------
  Интерфейс сервиса для распознавания изображения  
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit recognitionService;

interface

uses
    Graphics, mainViewModel, Classes;

type
    IRecognitionService = interface
        ['{0EEDC417-9021-4B77-BBC4-EC5C0E487C45}']
        function getReport(): TStringList;
        procedure initialize(model: IMainViewModel; boolWholeNumber: boolean = false; iSectionNumber: integer = 0);
        procedure unregister();
    end;

implementation

end.

 