unit testsRecognizerBase;

interface

uses TestFramework;

type
    TTestRecognizerBase = class(TTestCase)
    private
   
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testCalculateArea();
        
    end;
    { TTestRecognitionService }

implementation

uses
  imageRepository, imageRepositoryImpl, Graphics, SysUtils, recognizerBaseImpl;
    
procedure TTestRecognizerBase.SetUp;
begin
    inherited;

end;

procedure TTestRecognizerBase.TearDown;
begin
    inherited;

end;

procedure TTestRecognizerBase.testCalculateArea;
var
    bitmap : TBitmap;
    repo : IImageRepository;
    recognizerBase : TRecognizerBase;
    area : integer;
begin
    repo := TImageRepository.create();
    repo.initialize();
    bitmap := repo.getImage('a');
    CheckNotNull(bitmap);

    recognizerBase := TRecognizerBase.create();
    area := recognizerBase.calculateArea(bitmap);
    Check(area > 0);

    freeAndNil(bitmap);
    freeAndNil(recognizerBase);
end;


initialization
    TestFramework.RegisterTest(TTestRecognizerBase.Suite);
end.

