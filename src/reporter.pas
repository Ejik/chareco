{*------------------------------------------------------------------------------
  Интерфейс сервиса для формирования набора итоговых данных  
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit reporter;

interface

uses
    Classes;

type
    IReporter = interface
        ['{924C0996-90B0-4A97-A8B4-11BCD04D7961}']
        procedure initReport(data: TStringList);
        function getMaxMatch(): string;
        function getMidMatch(): string;
        function getMinMatch(): string;
        function getMaxMatchSymbol() : string;
        function getMaxMatchPercent() : integer;
    end;

implementation

end.

