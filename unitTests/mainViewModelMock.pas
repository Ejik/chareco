unit mainViewModelMock;

interface

uses
    mainViewModel, Graphics;

type
    TMainViewModelMock = class(TInterfacedObject, IMainViewModel)
    private
        fCurrentNumber: string;
        fCurrentNumberBitmap: TBitmap;
        fIdentifiedNumber: string;
        fViewOnlyMode : boolean;
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
        property viewOnlyMode: boolean read getViewOnlyMode write setViewOnlyMode;
    end;

implementation

uses
    SysUtils;

{ TMainViewModelMock }


destructor TMainViewModelMock.destroy;
begin
    FreeAndNil(fCurrentNumberBitmap);
    inherited;
end;

function TMainViewModelMock.getCurrentNumber: string;
begin
    result := fCurrentNumber;
end;

function TMainViewModelMock.getCurrentNumberBitmap: TBitmap;
begin
    result := fCurrentNumberBitmap;
end;

function TMainViewModelMock.getIdentifiedNumber: string;
begin

end;

function TMainViewModelMock.getViewOnlyMode: boolean;
begin
    result := fViewOnlyMode;
end;

procedure TMainViewModelMock.setCurrentNumber(const strNumber: string);
begin
    fCurrentNumber := strNumber;
end;

procedure TMainViewModelMock.setCurrentNumberBitmap(bitmap: TBitmap);
begin
    fCurrentNumberBitmap := bitmap;
end;

procedure TMainViewModelMock.setIdentifiedNumber(const strNumber: string);
begin

end;

procedure TMainViewModelMock.setViewOnlyMode(boolValue: boolean);
begin
    fViewOnlyMode := boolValue;
end;

end.

