unit mainViewPresenterImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewPresenter, mainView,
    userInputService, mainViewModel, imageGeneratorService;
type
    TMainViewPresenter = class(TInjectable, IMainViewPresenter)
    private
        fMainView: IMainView;
        fMainViewModel: IMainViewModel;
        fUserInputService: IUserInputService;
        fImageGeneratorService: IImageGeneratorService;
        procedure setMainViewOnlyMode();
        procedure setMainViewAndSetupLayoutMode();
    public
        constructor create(const mainView: IMainView;
            const model: IMainViewModel;
            const userInputService: IUserInputService;
            const ImageGeneratorService: IImageGeneratorService); overload;
        destructor destroy(); override;
        procedure bindView(const mainView: IMainView);
        procedure generateNumber();
        procedure openFile();
        procedure saveFile();
        procedure setViewOnlyMode(boolValue: boolean);
        procedure exit;
    end;

implementation

uses SysUtils, Dialogs, Controls;

{ TMainViewPresenterImpl }

{*------------------------------------------------------------------------------
  ����� ��� ���������� presenter � mainview
  @param mainView   ParameterDescription
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.bindView(const mainView: IMainView);
begin
    fMainView := mainView;
end;

{*------------------------------------------------------------------------------
    ����������
  @param mainView   ������� ����
  @param model   ������ ������ �������� ����
  @param userInputService   ������ ��� ����� ������
  @param ImageGeneratorService   ������ ��� ��������� ������
  @return
------------------------------------------------------------------------------*}

constructor TMainViewPresenter.create(const mainView: IMainView;
    const model: IMainViewModel;
    const userInputService: IUserInputService;
    const ImageGeneratorService: IImageGeneratorService);
begin
    fMainView := mainView;
    fUserInputService := userInputService;
    fMainViewModel := model;
    fImageGeneratorService := ImageGeneratorService;
end;

destructor TMainViewPresenter.destroy;
begin
    inherited;
end;

procedure TMainViewPresenter.exit;
begin

end;

{*------------------------------------------------------------------------------
    ����� ��������� ������
  @return
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.generateNumber;
var
    s: wideString;
begin
    s := fUserInputService.inputNumber();
    if (s <> '') then
    begin
        fMainViewModel.currentNumber := s;
        fMainViewModel.currentNumberBitmap := fImageGeneratorService.generate(fMainViewModel.currentNumber);
        fMainView.getWorkspace().setWorkspace(fMainViewModel.currentNumberBitmap);
    end;
end;

{*------------------------------------------------------------------------------
    ����� �������� ����������� ������ �� �����
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.openFile;
var
    openDialog: TOpenDialog;
begin
    openDialog := TOpenDialog.Create(fMainView.getObject);
    openDialog.InitialDir := getCurrentDir();
    openDialog.Options := [ofFileMustExist];
    openDialog.Filter := '����� �����������|*.bmp';
    openDialog.FilterIndex := 1;

    if (openDialog.execute()) then
    begin
        fMainViewModel.currentNumberBitmap.LoadFromFile(openDialog.FileName);
        fMainViewModel.currentNumber := '';
        fMainView.getWorkspace().setWorkspace(fMainViewModel.currentNumberBitmap);
        fMainView.getStatusBar().setStatus('����������� �������', 2000);
    end;

    freeAndNil(openDialog);
end;

{*------------------------------------------------------------------------------
    ����� ���������� ����������� ������ � ����
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.saveFile;
var
    saveFileDlg: TSaveDialog;
begin
    saveFileDlg := TSaveDialog.Create(fMainView.getObject);
    saveFileDlg.Title := '���������� ������';
    saveFileDlg.InitialDir := getCurrentDir();
    saveFileDlg.Filter := '����� �����������|*.bmp';
    saveFileDlg.DefaultExt := 'bmp';
    saveFileDlg.FilterIndex := 1;
    saveFileDlg.FileName := fMainViewModel.currentNumber;

    if (saveFileDlg.Execute()) then
    begin
        fMainViewModel.currentNumberBitmap.SaveToFile(saveFileDlg.FileName);
        fMainView.getStatusBar().setStatus('����������� ���������', 2000);
    end;
    FreeAndNil(saveFileDlg);
end;

procedure TMainViewPresenter.setMainViewAndSetupLayoutMode;
var
    ws: IGUIWorkspace;
    cursor: TCursor;
begin
    ws := fMainView.getWorkspace();
    ws.setCursor(crCross);

end;

procedure TMainViewPresenter.setMainViewOnlyMode;
var
    ws: IGUIWorkspace;
    cursor: TCursor;
begin
    ws := fMainView.getWorkspace();
    ws.setCursor(crDefault);
end;

procedure TMainViewPresenter.setViewOnlyMode(boolValue: boolean);
begin
    fMainViewModel.viewOnlyMode := boolValue;
    case fMainViewModel.viewOnlyMode of
        false: setMainViewAndSetupLayoutMode();
    else
        setMainViewOnlyMode();
    end;
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IMainViewPresenter, TMainViewPresenter);
end.

