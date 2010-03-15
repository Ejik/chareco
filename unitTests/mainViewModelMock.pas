unit mainViewModelMock;

interface

uses
    mainViewModel, Graphics, number;

type
    TMainViewModelMock = class(TInterfacedObject, IMainViewModel)
    private
        fCurrentNumber: INumber;
        fIdentifiedNumber: string;
        fViewOnlyMode: boolean;
    public
        constructor create(number : INumber); overload;
        destructor destroy(); override;
        function getCurrentNumberName(): string;
        function getCurrentNumberBitmap(): TBitmap;
        function getCurrentNumberBitmapWithLayout(): TBitmap;
        function getIdentifiedNumber(): string;
        function getlayoutPoint(index : integer) : integer;
        function getViewOnlyMode(): boolean;

        procedure setCurrentNumberName(const strNumber: string);
        procedure setCurrentNumberBitmap(bitmap: TBitmap);
        procedure setCurrentNumberBitmapWithLayout(bitmap: TBitmap);
        procedure setIdentifiedNumber(const strNumber: string);
        procedure setlayoutPoint(index : integer; value : integer);
        procedure setViewOnlyMode(boolValue: boolean);

        property currentNumberName: string read getCurrentNumberName write setCurrentNumberName;
        property currentNumberBitmap: TBitmap read getCurrentNumberBitmap write setCurrentNumberBitmap;
        property identifiedNumber: string read getIdentifiedNumber write setIdentifiedNumber;
        property viewOnlyMode: boolean read getViewOnlyMode write setViewOnlyMode;
    end;

implementation

uses
    SysUtils;

{ TMainViewModelMock }


destructor TMainViewModelMock.destroy;
begin
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

end;

function TMainViewModelMock.getlayoutPoint(index: integer): integer;
begin

end;

procedure TMainViewModelMock.setCurrentNumberBitmapWithLayout(
  bitmap: TBitmap);
begin

end;

procedure TMainViewModelMock.setlayoutPoint(index, value: integer);
begin

end;

constructor TMainViewModelMock.create(number: INumber);
begin
    fCurrentNumber := number;
end;

end.

