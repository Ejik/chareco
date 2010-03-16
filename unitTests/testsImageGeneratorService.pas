unit testsImageGeneratorService;

interface

uses TestFrameWork, imageRepository;

type
    TTestImageGeneratorService = class(TTestCase)
    private

        mockImgRepoMock: IImageRepository;
    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testGenerate();
    end;

implementation

uses
    SysUtils, imageRepositoryMock, imageGeneratorService, ImageGeneratorServiceImpl,
    Graphics;

{ TTestUserInputService }

procedure TTestImageGeneratorService.SetUp;
begin
    inherited;

    mockImgRepoMock := TImageRepositoryMock.create();
end;

procedure TTestImageGeneratorService.TearDown;
begin
    inherited;

end;


procedure TTestImageGeneratorService.testGenerate;
var
    generatorService: IImageGeneratorService;
    bmp : TBitmap;
begin
    generatorService := TImageGeneratorService.create(mockImgRepoMock);
    bmp := generatorService.generate('a777aa177');
    CheckNotNull(bmp);
    freeAndNil(bmp);
end;

initialization
    TestFramework.RegisterTest(TTestImageGeneratorService.Suite);

end.

