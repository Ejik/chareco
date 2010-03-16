unit numberImpl;

interface

uses
    number, Graphics, EBInjectable;

type
    TNumber = class(TInterfacedObject, INumber)
    private
        fBitmap: TBitmap;
        fHeight: integer;
        fName: string;
        fWidth: integer;

    public
        constructor create(); 
        destructor destroy(); override;

        function getBitmap(): TBitmap;
        function getHeight(): integer;
        function getName(): string;
        function getWidth(): integer;

        procedure setBitmap(value: TBitmap);
        procedure setHeight(iValue: integer);
        procedure setName(const strValue: string);
        procedure setWidth(iValue: integer);

    published
        property bitmap: TBitmap read getBitmap write setBitmap;
        property height: integer read getHeight write setHeight;
        property name: string read getName write setName;
        property width: integer read getWidth write setWidth;


    end;

implementation

uses
  SysUtils, EBDependencyInjection, EBDIRegistry, systemConsts;

{ TNumber }

constructor TNumber.create;
begin
    InjectDependencies(self);
    fHeight := NumberHeight;
    fWidth := NumberWidth;
end;

destructor TNumber.destroy;
begin
    freeAndNil(fBitmap);
    inherited;
end;

function TNumber.getBitmap: TBitmap;
begin
    if (fBitmap = nil) then
    begin
        fBitmap := TBitmap.create;
        fBitmap.PixelFormat := pf8bit;
    end;

    result := fBitmap;
end;

function TNumber.getHeight: integer;
begin
    result := fHeight;
end;


function TNumber.getName: string;
begin
    result := fName;
end;

function TNumber.getWidth: integer;
begin
    result := fWidth;
end;

procedure TNumber.setBitmap(value: TBitmap);
begin
    if (fBitmap <> nil) then
        freeAndNil(fBitmap);
    fBitmap := value;
end;

procedure TNumber.setHeight(iValue: integer);
begin
    fHeight := iValue;
end;

procedure TNumber.setName(const strValue: string);
begin
    fName := strValue;
end;

procedure TNumber.setWidth(iValue: integer);
begin
    fWidth := iValue;
end;

initialization
    GetDIRegistry.RegisterFactory(INumber, TNumber, @TNumber.create);
end.

