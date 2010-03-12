unit TestsMainViewPresenter;

interface

uses
    TestFrameWork, imageGeneratorService, mainView, userInputService, mainViewModel,
    MBC.Classes;
type
    TTestMainViewPresenter = class(TTestCase)
    private
        log: TLog;
        mockView: IMainView;
        mockModel: IMainViewModel;
        mockUserInputService: IUserInputService;
        mockImageGeneratorService: IImageGeneratorService;

    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testCreateDestroy;
        procedure testBingView();
        procedure testGenerateNumber();
    end;


implementation

uses
    SysUtils, mainViewPresenter, mainViewPresenterImpl, mainViewMock,
    userInputServiceImpl, userInputServiceMock, mainViewModelMock,
    ImageGeneratorServiceImpl, imageGeneratorServiceMock;

{ TTestMainView }

procedure TTestMainViewPresenter.SetUp;
begin
    inherited;

    mockView := TMainViewMock.create();
    mockModel := TMainViewModelMock.create();
    mockUserInputService := TUserInputServiceMock.create();
    mockImageGeneratorService := TImageGeneratorServiceMock.create();
end;

procedure TTestMainViewPresenter.TearDown;
begin
    inherited;

    mockImageGeneratorService := nil;
    mockUserInputService := nil;
    mockModel := nil;
    mockView := nil;
end;

procedure TTestMainViewPresenter.testBingView;
var
    presenter: ImainViewPresenter;
begin
    presenter := TMainViewPresenter.create(mockView,
        mockModel,
        mockUserInputService,
        mockImageGeneratorService);

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
        mockImageGeneratorService);

    presenter.generateNumber();
    CheckEquals('a111aa', mockModel.currentNumber);
end;


initialization
    TestFramework.RegisterTest(TTestMainViewPresenter.Suite);
end.

