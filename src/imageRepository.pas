{*------------------------------------------------------------------------------
  Интерфейс сервиса для хранения изображений
  Распознавание символов
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit imageRepository;

interface

uses
  Graphics;

type
    IImageRepository = interface
        ['{F1A69272-FD1B-4E69-884E-79B84CBBDBEA}']
        function getImage(const strName: string) : TBitmap;
        function getImageNameByIndex(index : integer) : string;
        function getPatternsCount(): integer;
        procedure initialize();
    end;

implementation

end.

