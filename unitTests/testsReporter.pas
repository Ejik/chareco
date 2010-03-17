unit testsReporter;

interface

uses TestFramework;

type
    TTestRecognizerBase = class(TTestCase)
    private
   
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testCreateTwoInstaceViaDIContainer();

    end;
    { TTestRecognitionService }

implementation

uses
  reporter, reporterImpl, EBDependencyInjection;


procedure TTestRecognizerBase.SetUp;
begin
    inherited;

end;

procedure TTestRecognizerBase.TearDown;
begin
    inherited;

end;


procedure TTestRecognizerBase.testCreateTwoInstaceViaDIContainer;
var
    repo1, repo2: IReporter;

begin
    repo1 := Emballo.Get(IReporter) as IReporter;
    repo2 := Emballo.Get(IReporter) as IReporter;
    CheckSame(repo1, repo2, 'Тест должен быть провален, т.к. интерфейс IReporter зарегистрирован не как singleton');

end;

initialization
    TestFramework.RegisterTest(TTestRecognizerBase.Suite);
end.

