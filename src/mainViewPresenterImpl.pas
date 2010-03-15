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
        procedure setupLayout();
        procedure updateView();

    public
        constructor create(const mainView: IMainView;
            const model: IMainViewModel;
            const userInputService: IUserInputService;
            const ImageGeneratorService: IImageGeneratorService); overload;
        destructor destroy(); override;

        procedure bindView(const mainView: IMainView);
        procedure exit;
        procedure generateNumber();
        procedure clearLayout();
        procedure openFile();
        procedure saveFile();
        procedure setViewOnlyMode(boolValue: boolean);
        procedure setAutoLayoutMode(boolValue: boolean);
        procedure workSpaceImageMouseDown(x, y: integer);
        procedure workSpaceImageMouseMove(x, y: integer);
    end;

implementation

uses SysUtils, Dialogs, Controls, Graphics, number, systemConsts;

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
  ����� ������� ��������
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.clearLayout;
var
    i: integer;
begin
    fMainViewModel.layoutStep := 0;
    for i := 0 to NumberLength - 1 do
        fMainViewModel.layoutPoint[i] := 0;
    if (fMainViewModel.autoLayoutMode) then
    begin
        fMainViewModel.autoLayoutMode := true;
        updateView();
    end
    else
        fMainView.getWorkspace().setWorkspaceBitmap(fMainViewModel.currentNumberBitmap);
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
        fMainViewModel.currentNumberName := s;
        fMainViewModel.currentNumberBitmap := fImageGeneratorService.generate(s);
        fMainView.getWorkspace().setWorkspaceBitmap(fMainViewModel.currentNumberBitmap);
        updateView();
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
        fMainViewModel.currentNumberName := '';
        fMainView.getWorkspace().setWorkspaceBitmap(fMainViewModel.currentNumberBitmap);
        fMainView.getStatusBar().setStatus('����������� �������', 2000);
        updateView();
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
    saveFileDlg.FileName := fMainViewModel.currentNumberName;

    if (saveFileDlg.Execute()) then
    begin
        fMainViewModel.currentNumberBitmap.SaveToFile(saveFileDlg.FileName);
        fMainView.getStatusBar().setStatus('����������� ���������', 2000);
    end;
    FreeAndNil(saveFileDlg);
end;

{*------------------------------------------------------------------------------
    ����� ��������� ������ ��������
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.setAutoLayoutMode(boolValue: boolean);
var
    i : integer;
begin
    fMainViewModel.autoLayoutMode := boolValue;
    updateView();
end;

procedure TMainViewPresenter.setMainViewAndSetupLayoutMode;
var
    ws: IGUIWorkspace;
    cursor: TCursor;
begin
    ws := fMainView.getWorkspace();
    ws.setCursor(crCross);
end;

{*------------------------------------------------------------------------------
    ����� ��������� ������ ������ ���������
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.setMainViewOnlyMode;
var
    ws: IGUIWorkspace;
    sb: IGUIStatusBar;
    cursor: TCursor;
begin
    ws := fMainView.getWorkspace();
    ws.setCursor(crDefault);

    sb := fMainView.getStatusBar();
    sb.setStatus('');
end;

{*------------------------------------------------------------------------------
  ����� ��������� ������ ������ �������� ��� �������� � ��������
  @param boolValue   ParameterDescription
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.setupLayout;
var
    i : integer;
begin
     // ����������� ��������
    for i := 0 to NumberLength - 1 do
    begin
        if (fMainViewModel.layoutPoint[i] > 0) then
        begin
            fMainViewModel.currentNumberBitmapWithLayout.Canvas.Pen.Style := psDot;
            fMainViewModel.currentNumberBitmapWithLayout.Canvas.MoveTo(fMainViewModel.layoutPoint[i], 0);
            fMainViewModel.currentNumberBitmapWithLayout.Canvas.LineTo(fMainViewModel.layoutPoint[i], numberHeight);
        end;
    end;
end;

{*------------------------------------------------------------------------------
  ����� ��������� ������ ������ ���������                                                                              
  @param boolValue   ParameterDescription
  @return ResultDescription  
------------------------------------------------------------------------------*}
procedure TMainViewPresenter.setViewOnlyMode(boolValue: boolean);
begin
    fMainViewModel.viewOnlyMode := boolValue;
    case fMainViewModel.viewOnlyMode of
        false: setMainViewAndSetupLayoutMode();
    else
        setMainViewOnlyMode();
    end;
end;

{*------------------------------------------------------------------------------
  ����� ���������� ����������
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.updateView;
begin
    fMainViewModel.currentNumberBitmapWithLayout.Assign(fMainViewModel.currentNumberBitmap);
    setupLayout();
    fMainView.getWorkspace.setWorkspaceBitmap(fMainViewModel.currentNumberBitmapWithLayout);
end;


{*------------------------------------------------------------------------------
  ����� ����������� ����������� ��� ����������� ���� ��� ������� ��������
  @param x   ParameterDescription
  @param y   ParameterDescription
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.workSpaceImageMouseDown(x, y: integer);
var
    ws: IGUIWorkspace;
    statusBar: IGUIStatusBar;
    i: integer;
    w, h: integer;
    left0, top0: integer;
    buffer: TBitmap;
begin
    if (not fMainViewModel.viewOnlyMode) then
    begin
        ws := fMainView.getWorkspace();
        w := ws.getClientArea().Right; //bmp.Width := 312;
        h := ws.getClientArea().Bottom; //bmp.Height := 90;
        left0 := w div 2 - numberWidth div 2;
        top0 := h div 2 - numberHeight div 2;
        if (x >= left0) and (y >= top0) and
            (x <= left0 + numberWidth) and (y <= top0 + numberHeight) then
        begin
          if (fMainViewModel.layoutStep < NumberLength - 1) then
            begin
                fMainViewModel.layoutPoint[fMainViewModel.layoutStep] := x - left0;
                fMainViewModel.layoutStep := fMainViewModel.layoutStep + 1;
            end;
        end;
    end;
end;

procedure TMainViewPresenter.workSpaceImageMouseMove(x, y: integer);
var
    ws: IGUIWorkspace;
    statusBar: IGUIStatusBar;
    i: integer;
    w, h: integer;
    left0, top0: integer;
    buffer: TBitmap;
begin
    if (not fMainViewModel.viewOnlyMode) then
    begin
        ws := fMainView.getWorkspace();
        w := ws.getClientArea().Right; //bmp.Width := 312;
        h := ws.getClientArea().Bottom; //bmp.Height := 90;
        left0 := w div 2 - numberWidth div 2;
        top0 := h div 2 - numberHeight div 2;

        // ��������� �����������. ����� �� ����� ����� ������
        updateView();

        buffer := TBitmap.create();
        buffer.Assign(fMainViewModel.currentNumberBitmapWithLayout);

        // ����������� ��������
        setupLayout();

        // ���� ������ � �������� �������, �� ����������� � ���
        if (x >= left0) and (y >= top0) and
            (x <= left0 + numberWidth) and (y <= top0 + numberHeight) then
        begin
            buffer.Canvas.Pen.Style := psDot;
            buffer.Canvas.MoveTo(x - left0, 0);
            buffer.Canvas.LineTo(x - left0, numberHeight);

            statusBar := fMainView.getStatusBar();
            statusBar.setStatus('x:' + intToStr(x - left0), 0,false);
            //statusBar.setStatus('x:' + intToStr(x) + '  y:' + intToStr(y));
        end;

        ws.setWorkspaceBitmap(buffer);
        fMainViewModel.currentNumberBitmapWithLayout := buffer;
    end;
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IMainViewPresenter, TMainViewPresenter);
end.

