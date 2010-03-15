unit numberMock;

interface

uses
    number, Graphics;

type
    TNumberMock = class(TInterfacedObject, INumber)
    private
        fName: string;
        fBitmap: TBitmap;

    public
        destructor destroy(); override;
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

uses
  SysUtils;

{ TNumberMock }

destructor TNumberMock.destroy;
begin
    freeAndNil(fBitmap);
    inherited;
end;

function TNumberMock.getBitmap: TBitmap;
begin
    result := fBitmap;
end;

function TNumberMock.getHeight: integer;
begin

end;

function TNumberMock.getName: string;
begin
    result := fname;
end;

function TNumberMock.getWidth: integer;
begin

end;

procedure TNumberMock.setBitmap(value: TBitmap);
begin
    fBitmap := value;
end;

procedure TNumberMock.setHeight(iValue: integer);
begin

end;

procedure TNumberMock.setName(const strValue: string);
begin
    fName := strValue;
end;

procedure TNumberMock.setWidth(iValue: integer);
begin

end;

end.

