unit mainViewModelImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewModel, Graphics,
    number, systemConsts;

type
    TMainViewModel = class(TInterfacedObject, IMainViewModel)
    private
        fAutoLayoutMode: boolean;
        fCurrentNumber: INumber;
        fCurrentLayoutStep: integer;
        fCurrentNumberBitmapWithLayout: TBitmap;
        fIdentifiedNumber: string;
        fViewOnlyMode: boolean;
        fLayoutPoints: array[0..NumberLength - 1] of integer;

    public
        constructor create();
        destructor destroy(); override;

        function getAutoLayoutMode(): boolean;
        function getCurrentNumberName(): string;
        function getCurrentNumberBitmap(): TBitmap;
        function getCurrentNumberBitmapWithLayout(): TBitmap;
        function getIdentifiedNumber(): string;
        function getLayoutPoint(index: integer): integer;
        function getLayoutStep(): integer;
        function getViewOnlyMode(): boolean;


        procedure setAutoLayoutMode(boolValue: boolean);
        procedure setCurrentNumberName(const strNumber: string);
        procedure setCurrentNumberBitmap(bitmap: TBitmap);
        procedure setCurrentNumberBitmapWithLayout(bitmap: TBitmap);
        procedure setIdentifiedNumber(const strNumber: string);
        procedure setLayoutPoint(index, value: integer);
        procedure setLayoutStep(iValue: integer);
        procedure setViewOnlyMode(boolValue: boolean);

        property autoLayoutMode: boolean read getAutoLayoutMode write setAutoLayoutMode;
        property currentNumberName: string read getCurrentNumberName write setCurrentNumberName;
        property currentNumberBitmap: TBitmap read getCurrentNumberBitmap write setCurrentNumberBitmap;
        property currentNumberBitmapWithLayout: TBitmap read getCurrentNumberBitmapWithLayout write setCurrentNumberBitmapWithLayout;
        property identifiedNumber: string read getIdentifiedNumber write setIdentifiedNumber;
        property layoutPoint[index: integer]: integer read getLayoutPoint write setLayoutPoint;
        property layoutStep: integer read getLayoutStep write setLayoutStep;
        property viewOnlyMode: boolean read getViewOnlyMode write setViewOnlyMode;
    end;
implementation

uses SysUtils, Variants;

{ TMainViewModel }


constructor TMainViewModel.create;
begin
    InjectDependencies(self);
    fViewOnlyMode := true;
    setAutoLayoutMode(true);
end;

destructor TMainViewModel.destroy;
begin
    freeAndNil(fCurrentNumberBitmapWithLayout);
    inherited;
end;

function TMainViewModel.getCurrentNumberName: string;
begin
    result := fCurrentNumber.name;
end;

function TMainViewModel.getCurrentNumberBitmap: TBitmap;
begin
    result := fCurrentNumber.bitmap;
end;

function TMainViewModel.getCurrentNumberBitmapWithLayout: TBitmap;
begin
    if (fCurrentNumberBitmapWithLayout = nil) then
        fCurrentNumberBitmapWithLayout := TBitmap.create;

    result := fCurrentNumberBitmapWithLayout;
end;

function TMainViewModel.getIdentifiedNumber: string;
begin
    result := fIdentifiedNumber;
end;

function TMainViewModel.getLayoutPoint(index: integer): integer;
begin
    result := fLayoutPoints[index];
end;

function TMainViewModel.getViewOnlyMode: boolean;
begin
    result := fViewOnlyMode;
end;

procedure TMainViewModel.setCurrentNumberName(const strNumber: string);
begin
    fCurrentNumber.name := strNumber;
end;

procedure TMainViewModel.setCurrentNumberBitmap(bitmap: TBitmap);
begin
    fCurrentNumber.bitmap := bitmap;
end;

procedure TMainViewModel.setCurrentNumberBitmapWithLayout(bitmap: TBitmap);
begin
    if (fCurrentNumberBitmapWithLayout <> nil) then
        freeAndNil(fCurrentNumberBitmapWithLayout);
    fCurrentNumberBitmapWithLayout := bitmap;
end;

procedure TMainViewModel.setIdentifiedNumber(const strNumber: string);
begin
    fIdentifiedNumber := strNumber;
end;

procedure TMainViewModel.setLayoutPoint(index, value: integer);
begin
    fLayoutPoints[index] := value;
end;

procedure TMainViewModel.setViewOnlyMode(boolValue: boolean);
begin
    fViewOnlyMode := boolValue;
end;

function TMainViewModel.getLayoutStep: integer;
begin
    result := fCurrentLayoutStep;
end;

procedure TMainViewModel.setLayoutStep(iValue: integer);
begin
    fCurrentLayoutStep := iValue;
end;

function TMainViewModel.getAutoLayoutMode: boolean;
begin
    result := fAutoLayoutMode;
end;

procedure TMainViewModel.setAutoLayoutMode(boolValue: boolean);
var
    i: integer;
begin
    fAutoLayoutMode := boolValue;
    if (fAutoLayoutMode) then
    begin
        for i := 0 to NumberLength - 1 do
            layoutPoint[i] := arrAutoLayout[i];
    end;
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(ImainViewModel, TMainViewModel, @TMainViewModel.create);
end.

