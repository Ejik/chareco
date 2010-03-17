unit testsRecognizerByArea;

interface

uses TestFramework, imageRepository, reporter, Graphics;

type
    TTestRecognizerByArea = class(TTestCase)
    private
        repo: IImageRepository;
        reporter: IReporter;
        bitmap: TBitmap;
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testRecogize();

    end;
    { TTestRecognitionService }

implementation

uses
    imageRepositoryImpl, SysUtils, recognizerBaseImpl,
    imageRepositoryMock, recognizer, recognizerByAreaImpl, reporterMock;

procedure TTestRecognizerByArea.SetUp;
begin
    inherited;
    repo := TImageRepositoryMock.create();
    reporter := TReporterMock.create();
    bitmap := TBitmap.create();
end;

procedure TTestRecognizerByArea.TearDown;
begin
    inherited;
    freeAndNil(bitmap);
end;

procedure TTestRecognizerByArea.testRecogize;
var
    recognizer: IRecognizerByArea;
    area: integer;
    resultReport : IReporter;
begin
    recognizer := TRecognizerByArea.create(repo, reporter);
    resultReport := recognizer.recognize(bitmap);
    CheckSame(reporter, resultReport);

    CheckTrue('100%' = resultReport.getMaxMatch());
end;


initialization
    TestFramework.RegisterTest(TTestRecognizerByArea.Suite);
end.

