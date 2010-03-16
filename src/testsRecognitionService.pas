unit testsRecognitionService;

interface

uses TestFramework;

type
    TTestRecognitionService = class(TTestCase)
    private

    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testMethodA();
    end;
    { TTestRecognitionService }

implementation
    
procedure TTestRecognitionService.SetUp;
begin
    inherited;

end;

procedure TTestRecognitionService.TearDown;
begin
    inherited;

end;

procedure TTestRecognitionService.testMethodA;
begin

    

end;

initialization
    TestFramework.RegisterTest(TTestRecognitionService.Suite);
end.

