{*------------------------------------------------------------------------------
  Интерфейс сервиса для генерации изображения  
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit imageGeneratorService;

interface

uses
    Graphics;

type
    IImageGeneratorService = interface
    ['{175C2A3D-984A-451B-A12E-D4050EC54147}']
        function generate(const strNumber : string) : TBitmap;
    end;

implementation

end.
 