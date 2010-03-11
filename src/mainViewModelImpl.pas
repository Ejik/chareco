unit mainViewModelImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewModel, Graphics;

type
    TMainViewModel = class(TInjectable, IMainViewModel)
    private
        fCurrentNumber : string;
        fCurrentNumberBitmap : TBitmap;
        fIdentifiedNumber : string;
    public
        destructor destroy();
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

uses SysUtils;

{ TMainViewModel }


destructor TMainViewModel.destroy;
begin
    FreeAndNil(fCurrentNumberBitmap);
end;

function TMainViewModel.getCurrentNumber: string;
begin
    result := fCurrentNumber;
end;

function TMainViewModel.getCurrentNumberBitmap: TBitmap;
begin
    result := fCurrentNumberBitmap;
end;

function TMainViewModel.getIdentifiedNumber: string;
begin
    result := fIdentifiedNumber;
end;

procedure TMainViewModel.setCurrentNumber(const strNumber: string);
begin
    fCurrentNumber := strNumber;
end;

procedure TMainViewModel.setCurrentNumberBitmap(bitmap: TBitmap);
begin
    fCurrentNumberBitmap := bitmap;
end;

procedure TMainViewModel.setIdentifiedNumber(const strNumber: string);
begin
    fIdentifiedNumber := strNumber;
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(ImainViewModel, TMainViewModel);
end.

