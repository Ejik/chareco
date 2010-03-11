unit TestsMainViewPresenter;

interface

uses
    TestFrameWork;
type
    TTestMainViewPresenter = class(TTestCase)
    private

    protected
        procedure SetUp; override;
        procedure TearDown; override;
    published
        procedure testCreate;
        procedure testBingView();
        procedure testInputNumber();
    end;


implementation

uses
    SysUtils, mainViewPresenter, mainViewPresenterImpl, mainViewMock, mainView,
    userInputService, userInputServiceImpl, userInputServiceMock;

{ TTestMainView }

procedure TTestMainViewPresenter.SetUp;
begin
    inherited;

end;

procedure TTestMainViewPresenter.TearDown;
begin
    inherited;

end;

procedure TTestMainViewPresenter.testBingView;
var
    presenter: ImainViewPresenter;
    mockUserInputService: IUserInputService;
    mockView: IMainView;
begin
     mockUserInputService := TUserInputService.create();
    mockView := TMainViewMock.create();
    presenter := TMainViewPresenter.create(mockView,
        mockUserInputService);
    presenter.bindView(mockView);
    CheckNotNull(presenter);
end;

procedure TTestMainViewPresenter.testCreate;
var
    presenter: ImainViewPresenter;
begin
    presenter := TMainViewPresenter.create();
    CheckNotNull(presenter);
end;

procedure TTestMainViewPresenter.testInputNumber;
var
    presenter: ImainViewPresenter;
    mockUserInputService: IUserInputService;
    mockView: IMainView;
begin
    mockUserInputService := TUserInputServiceMock.create();
    mockView := TMainViewMock.create();
    presenter := TMainViewPresenter.Create(mockView, mockUserInputService);

    presenter.generateNumber();

end;

initialization
    TestFramework.RegisterTest(TTestMainViewPresenter.Suite);
end.

