unit mainViewModel;

interface

uses
    Graphics;
    
type
    IMainViewModel = interface
        ['{2E9B820D-1C02-4D44-8043-636EBE86FF15}']
        function getCurrentNumber(): string;
        function getCurrentNumberBitmap(): TBitmap;
        function getIdentifiedNumber(): string;
        procedure setCurrentNumber(const strNumber: string);
        procedure setCurrentNumberBitmap(bitmap: TBitmap);
        procedure setIdentifiedNumber(const strNumber: string);

        property currentNumber: string read getCurrentNumber write setCurrentNumber;
        property currentNumberBitmap: TBitmap read getCurrentNumberBitmap write setCurrentNumberBitmap;
        property identifiedNumber: string read getIdentifiedNumber write setIdentifiedNumber;
    end;

implementation

end.

