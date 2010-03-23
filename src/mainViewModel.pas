{*------------------------------------------------------------------------------
  Интерфейс модели приложения 
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit mainViewModel;

interface

uses
    Graphics, number;

type
    IMainViewModel = interface
        ['{2E9B820D-1C02-4D44-8043-636EBE86FF15}']

        function getAutoLayoutMode() : boolean;
        function getCurrentNumberName(): string;
        function getCurrentNumberBitmap(): TBitmap;
        function getCurrentNumberBitmapWithLayout(): TBitmap;
        function getIdentifiedNumber(): string;
        function getLayoutPoint(index : integer) : integer;
        function getLayoutStep() : integer;
        function getViewOnlyMode(): boolean;

        procedure setAutoLayoutMode(boolValue : boolean);
        procedure setCurrentNumberName(const strNumber: string);
        procedure setCurrentNumberBitmap(bitmap: TBitmap);
        procedure setCurrentNumberBitmapWithLayout(bitmap: TBitmap);
        procedure setIdentifiedNumber(const strNumber: string);
        procedure setLayoutPoint(index: integer; iValue: integer);
        procedure setLayoutStep(iValue: integer);
        procedure setViewOnlyMode(boolValue: boolean);

        property autoLayoutMode: boolean read getAutoLayoutMode write setAutoLayoutMode;
        property currentNumberName: string read getCurrentNumberName write setCurrentNumberName;
        property currentNumberBitmap: TBitmap read getCurrentNumberBitmap write setCurrentNumberBitmap;
        property currentNumberBitmapWithLayout: TBitmap read getCurrentNumberBitmapWithLayout write setCurrentNumberBitmapWithLayout;
        property identifiedNumber: string read getIdentifiedNumber write setIdentifiedNumber;
        property viewOnlyMode: boolean read getViewOnlyMode write setViewOnlyMode;
        property layoutPoint[index : integer] : integer read getLayoutPoint write setLayoutPoint;
        property layoutStep : integer read getLayoutStep write setLayoutStep;
    end;

implementation

end.

