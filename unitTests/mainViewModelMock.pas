unit mainViewModelMock;

interface

uses
    mainViewModel, Graphics, number;

type
    TMainViewModelMock = class(TInterfacedObject, IMainViewModel)
    private
        fCurrentNumber: INumber;
        fCurrentNumberBitmapWithLayout: TBitmap;
        fIdentifiedNumber: string;
        fViewOnlyMode: boolean;
        fLayoutPoints: array[0..4] of integer;

    public
        constructor create(number: INumber); overload;
        destructor destroy(); override;

        function getAutoLayoutMode(): boolean;
        function getCurrentNumberName(): string;
        function getCurrentNumberBitmap(): TBitmap;
        function getCurrentNumberBitmapWithLayout(): TBitmap;
        function getIdentifiedNumber(): string;
        function getlayoutPoint(index: integer): integer;
        function getLayoutStep(): integer;
        function getViewOnlyMode(): boolean;

        procedure setAutoLayoutMode(boolValue: boolean);
        procedure setCurrentNumberName(const strNumber: string);
        procedure setCurrentNumberBitmap(bitmap: TBitmap);
        procedure setCurrentNumberBitmapWithLayout(bitmap: TBitmap);
        procedure setIdentifiedNumber(const strNumber: string);
        procedure setlayoutPoint(index: integer; value: integer);
        procedure setLayoutStep(iValue: integer);
        procedure setViewOnlyMode(boolValue: boolean);

        property autoLayoutMode: boolean read getAutoLayoutMode write setAutoLayoutMode;
        property currentNumberName: string read getCurrentNumberName write setCurrentNumberName;
        property currentNumberBitmap: TBitmap read getCurrentNumberBitmap write setCurrentNumberBitmap;
        property identifiedNumber: string read getIdentifiedNumber write setIdentifiedNumber;
        property viewOnlyMode: boolean read getViewOnlyMode write setViewOnlyMode;
        property layoutStep: integer read getLayoutStep write setLayoutStep;
    end;

implementation

uses
    SysUtils;

{ TMainViewModelMock }


destructor TMainViewModelMock.destroy;
begin
    freeAndNil(fCurrentNumberBitmapWithLayout);
    inherited;
end;

function TMainViewModelMock.getCurrentNumberName: string;
begin
    result := fCurrentNumber.name;
end;

function TMainViewModelMock.getCurrentNumberBitmap: TBitmap;
begin
    result := fCurrentNumber.bitmap;
end;

function TMainViewModelMock.getIdentifiedNumber: string;
begin

end;

function TMainViewModelMock.getViewOnlyMode: boolean;
begin
    result := fViewOnlyMode;
end;

procedure TMainViewModelMock.setCurrentNumberName(const strNumber: string);
begin
    fCurrentNumber.name := strNumber;
end;

procedure TMainViewModelMock.setCurrentNumberBitmap(bitmap: TBitmap);
begin
    fCurrentNumber.bitmap := bitmap;
end;

procedure TMainViewModelMock.setIdentifiedNumber(const strNumber: string);
begin

end;

procedure TMainViewModelMock.setViewOnlyMode(boolValue: boolean);
begin
    fViewOnlyMode := boolValue;
end;

function TMainViewModelMock.getCurrentNumberBitmapWithLayout: TBitmap;
begin
    if (fCurrentNumberBitmapWithLayout = nil) then
        fCurrentNumberBitmapWithLayout := TBitmap.create;
    result := fCurrentNumberBitmapWithLayout;
end;

function TMainViewModelMock.getlayoutPoint(index: integer): integer;
begin
    result := fLayoutPoints[index];
end;

procedure TMainViewModelMock.setCurrentNumberBitmapWithLayout(
    bitmap: TBitmap);
begin

end;

procedure TMainViewModelMock.setlayoutPoint(index, value: integer);
begin

end;

constructor TMainViewModelMock.create(number: INumber);
var
    i: integer;
begin
    fCurrentNumber := number;
    for i := 0 to 4 do
        fLayoutPoints[i] := 0;
end;

function TMainViewModelMock.getAutoLayoutMode: boolean;
begin

end;

procedure TMainViewModelMock.setAutoLayoutMode(boolValue: boolean);
begin

end;

function TMainViewModelMock.getLayoutStep: integer;
begin

end;

procedure TMainViewModelMock.setLayoutStep(iValue: integer);
begin

end;

end.

