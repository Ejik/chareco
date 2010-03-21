unit testsUserInputService;

interface

uses TestFrameWork, imageRepository;

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

    CheckTrue(userInputService.checkNumber('X777XX177'));

    CheckFalse(userInputService.checkNumber('L777LK'));

    CheckFalse(userInputService.checkNumber('L777LKL178'));

    freeAndNil( userInputService);
end;


initialization
    TestFramework.RegisterTest(TTestUserInputService.Suite);

end.

 