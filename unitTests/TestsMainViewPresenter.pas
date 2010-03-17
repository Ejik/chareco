unit TestsMainViewPresenter;

interface

uses
    TestFrameWork, imageGeneratorService, mainView, userInputService, mainViewModel,
    MBC.Classes, recognitionService;
type
    TTestMainViewPresenter = class(TTestCase)
    private
        log: TLog;
        mockView: IMainView;
        mockModel: IMainViewModel;
        mockUserInputService: IUserInputService;
        mockImageGeneratorService: IImageGeneratorService;
        mockRecognitionService: IRecognitionService;

    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testCreateDestroy;
        procedure testBingView();
        procedure testGenerateNumber();
        procedure testSetupViewModes();
    end;


implementation

uses
    SysUtils, mainViewPresenter, mainViewPresenterImpl, mainViewMock,
    userInputServiceImpl, userInputServiceMock, mainViewModelMock,
    ImageGeneratorServiceImpl, imageGeneratorServiceMock, numberMock,
      recognitionServiceMock;

{ TTestMainView }

procedure TTestMainViewPresenter.SetUp;
begin
    inherited;

    mockView := TMainViewMock.create();
    mockModel := TMainViewModelMock.create(TNumberMock.create);
    mockUserInputService := TUserInputServiceMock.create();
    mockImageGeneratorService := TImageGeneratorServiceMock.create();
    mockRecognitionService:= TRecognitionServiceMock.create();
end;

procedure TTestMainViewPresenter.TearDown;
begin
    inherited;
end;

procedure TTestMainViewPresenter.testBingView;
var
    presenter: ImainViewPresenter;
begin
    presenter := TMainViewPresenter.create(mockView,
        mockModel,
        mockUserInputService,
        mockImageGeneratorService,
        mockRecognitionService);

    presenter.bindView(mockView);
    CheckNotNull(presenter);
end;

procedure TTestMainViewPresenter.testCreateDestroy;
var
    presenter: ImainViewPresenter;
    mockView: IMainView;
    mockModel: IMainViewModel;
    mockUserInputService: IUserInputService;
    mockImageGeneratorService: IImageGeneratorService;
begin
    mockView := TMainViewMock.create();
    mockModel := TMainViewModelMock.create();
    mockUserInputService := TUserInputServiceMock.create();
    mockImageGeneratorService := TImageGeneratorServiceMock.create();
    presenter := TMainViewPresenter.create();
    CheckNotNull(presenter);

    presenter := nil;
    CheckNull(presenter);
end;

procedure TTestMainViewPresenter.testGenerateNumber;
var
    presenter: IMainViewPresenter;
begin
    presenter := TMainViewPresenter.Create(mockView,
        mockModel,
        mockUserInputService,
        mockImageGeneratorService,
        mockRecognitionService);

    presenter.generateNumber();
    CheckEquals('a111aa', mockModel.currentNumberName);
end;


procedure TTestMainViewPresenter.testSetupViewModes;
var
    presenter : IMainViewPresenter;
begin
    presenter := TMainViewPresenter.create(mockView,
        mockModel,
        mockUserInputService,
        mockImageGeneratorService,
        mockRecognitionService);

    presenter.setViewOnlyMode(true);

    CheckTrue(mockModel.viewOnlyMode);

    presenter.setViewOnlyMode(false);
    CheckFalse(mockModel.viewOnlyMode);
    
end;

initialization
    TestFramework.RegisterTest(TTestMainViewPresenter.Suite);
end.

