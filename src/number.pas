{*------------------------------------------------------------------------------
  Интерфейс бизнес-объекта "автомобильный номер"
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit number;

interface

uses
    Graphics, Classes;

type
    INumber = interface
        ['{808B1DF1-6064-47F7-A28B-1B2E3B6F4A6E}']
        function getBitmap(): TBitmap;
        function getHeight(): integer;
        function getName(): string;
        function getWidth(): integer;

        procedure setBitmap(value: TBitmap);
        procedure setHeight(iValue: integer);
        procedure setName(const strValue: string);
        procedure setWidth(iValue: integer);

        property bitmap: TBitmap read getBitmap write setBitmap;
        property name: string read getName write setName;
        property height: integer read getHeight write setHeight;
        property width: integer read getWidth write setWidth;
    end;


implementation

end.

