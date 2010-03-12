unit mainViewPresenterImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewPresenter, mainView,
    userInputService, mainViewModel, imageGeneratorService;
type
    TMainViewPresenter = class(TInjectable, IMainViewPresenter)
    private
        fMainView : IMainView;
        fMainViewModel : IMainViewModel;
        fUserInputService : IUserInputService;
        fImageGeneratorService : IImageGeneratorService;

    public
        constructor create(const mainView : IMainView;
            const model : IMainViewModel;
            const userInputService : IUserInputService;
            const ImageGeneratorService : IImageGeneratorService ); overload;
        destructor destroy();
        procedure bindView(const mainView: IMainView);
        procedure generateNumber();
        procedure openFile();
        procedure saveFile();
        procedure exit;
    end;

implementation

uses SysUtils;

{ TMainViewPresenterImpl }

procedure TMainViewPresenter.bindView(const mainView: IMainView);
begin
    fMainView := mainView;
end;

constructor TMainViewPresenter.create(const mainView: IMainView;
    const model : IMainViewModel;
    const userInputService : IUserInputService;
    const ImageGeneratorService : IImageGeneratorService );
begin
    fMainView := mainView;
    fUserInputService := userInputService;
    fMainViewModel := model;
    fImageGeneratorService := ImageGeneratorService;
end;

destructor TMainViewPresenter.destroy;
begin

end;

procedure TMainViewPresenter.exit;
begin

end;

procedure TMainViewPresenter.generateNumber;
var
    s : wideString;
begin
    s := fUserInputService.inputNumber();
    if (s <> '') then
    begin
        fMainViewModel.currentNumber := StringReplace(s, ' ', '', [rfReplaceAll]);        
        fMainViewModel.currentNumberBitmap := fImageGeneratorService.generate(fMainViewModel.currentNumber);
        fMainView.setupWorkspace(fMainViewModel.currentNumberBitmap);
    end;
end;

procedure TMainViewPresenter.openFile;
begin

end;

procedure TMainViewPresenter.saveFile;
begin

end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IMainViewPresenter, TMainViewPresenter);
end.

