unit testsNumber;

interface

uses TestFrameWork;

type
    TTestNumber = class(TTestCase)
    private

    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testCreateDestroy();
        procedure testAssignBitmap();
    end;

implementation

uses
  number, numberImpl, Graphics;

{ TTestNumber }

procedure TTestNumber.SetUp;
begin
  inherited;

end;

procedure TTestNumber.TearDown;
begin
  inherited;

end;

procedure TTestNumber.testAssignBitmap;
var
    number : INumber;
begin
    number := TNumber.create();
    number.bitmap := TBitmap.create();

    CheckNotNull(number.bitmap);
    number := nil;

    CheckNull(number);
end;

procedure TTestNumber.testCreateDestroy;
var
    number : INumber;
begin
    number := TNumber.create();
    
    CheckNotNull(number);

    number := nil;
    CheckNull(number);
end;

initialization
    TestFramework.RegisterTest(TTestNumber.Suite);

end.
