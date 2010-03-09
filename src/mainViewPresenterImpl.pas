unit mainViewPresenterImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewPresenter, mainView;
type
    TMainViewPresenter = class(TInjectable, IMainViewPresenter)
    private
        fMainView : IMainView;
    public
        constructor create(const mainView : IMainView); overload;
        procedure bindView(const mainView: IMainView);
        procedure generateNumber();
        procedure openFile();
        procedure saveFile();
        procedure exit;
    end;

implementation

{ TMainViewPresenterImpl }

procedure TMainViewPresenter.bindView(const mainView: IMainView);
begin
    fMainView := mainView;
end;

constructor TMainViewPresenter.create(const mainView: IMainView);
begin
    fMainView := mainView;
end;

procedure TMainViewPresenter.exit;
begin

end;

procedure TMainViewPresenter.generateNumber;
begin

end;

procedure TMainViewPresenter.openFile;
begin

end;

procedure TMainViewPresenter.saveFile;
begin

end;

end.

