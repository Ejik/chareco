unit TestsMainView;

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
    end;


implementation

uses
    SysUtils, mainViewPresenter, mainViewPresenterImpl, mainViewMock, mainView;

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
    presenter : ImainViewPresenter;
    mockView : IMainView;
begin
    mockView := TMainViewMock.create();
    presenter := TMainViewPresenter.create();
    presenter.bindView(mockView);
    CheckNotNull(presenter);
end;

procedure TTestMainViewPresenter.testCreate;
var
    presenter : ImainViewPresenter;
begin
    presenter := TMainViewPresenter.create();
    CheckNotNull(presenter);
end;

initialization
    TestFramework.RegisterTest(TTestMainViewPresenter.Suite);
end.

