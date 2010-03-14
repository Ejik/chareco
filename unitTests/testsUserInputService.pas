unit testsUserInputService;

interface

uses TestFrameWork;

type
    TTestUserInputService = class(TTestCase)
    private

    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testNumbers();
    end;

implementation

uses
  userInputServiceImpl, SysUtils;

{ TTestUserInputService }

procedure TTestUserInputService.SetUp;
begin
  inherited;

end;

procedure TTestUserInputService.TearDown;
begin
  inherited;

end;

procedure TTestUserInputService.testNumbers;
var
    userInputService: TUserInputService;
begin
    userInputService := TUserInputService.create();

    CheckTrue(userInputService.checkNumber('x777xx'));

    CheckFalse(userInputService.checkNumber('l777lk'));

    CheckFalse(userInputService.checkNumber('l777lkl'));

    freeAndNil( userInputService);
end;


initialization
    TestFramework.RegisterTest(TTestUserInputService.Suite);

end.

 