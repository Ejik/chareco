unit mainViewModelImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewModel, Graphics;

type
    TMainViewModel = class(TInjectable, IMainViewModel)
    private
        fCurrentNumber: string;
        fCurrentNumberBitmap: TBitmap;
        fIdentifiedNumber: string;
        fViewOnlyMode: boolean;

    public
        destructor destroy(); override;
        function getCurrentNumber(): string;
        function getCurrentNumberBitmap(): TBitmap;
        function getIdentifiedNumber(): string;
        function getViewOnlyMode(): boolean;

        procedure setCurrentNumber(const strNumber: string);
        procedure setCurrentNumberBitmap(bitmap: TBitmap);
        procedure setIdentifiedNumber(const strNumber: string);
        procedure setViewOnlyMode(boolValue: boolean);

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
    inherited;
end;

function TMainViewModel.getCurrentNumber: string;
begin
    result := fCurrentNumber;
end;

function TMainViewModel.getCurrentNumberBitmap: TBitmap;
begin
    if (fCurrentNumberBitmap = nil) then
        fCurrentNumberBitmap := TBitmap.create;

    result := fCurrentNumberBitmap;
end;

function TMainViewModel.getIdentifiedNumber: string;
begin
    result := fIdentifiedNumber;
end;

function TMainViewModel.getViewOnlyMode: boolean;
begin
    result := fViewOnlyMode;
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

procedure TMainViewModel.setViewOnlyMode(boolValue: boolean);
begin
    fViewOnlyMode := boolValue;
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(ImainViewModel, TMainViewModel);
end.

