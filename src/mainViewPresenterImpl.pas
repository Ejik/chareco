{*------------------------------------------------------------------------------
  Реализация презентера   
  Распознавание символов 
  Курсовая работа по дисциплине "Технология программирования"
  @Author    Студент гр. ВС1-06 Горчакова М. М.
  @Version   2010.03.23   Горчакова М. М.	Initial revision                                       
-------------------------------------------------------------------------------}

unit mainViewPresenterImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, mainViewPresenter, mainView,
    userInputService, mainViewModel, imageGeneratorService,
{$IFDEF DELPHI_6_UP}
    D6OnHelpFix,
{$ENDIF}
    recognitionService, hh;


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
            const imageGeneratorService: IImageGeneratorService;
            const recognitionService: IRecognitionService); overload;
        destructor destroy(); override;

        procedure bindView(const mainView: IMainView);
        procedure executeRecognition(boolWholeNumber: boolean = false);
        procedure generateNumber();
        procedure clearLayout();
        procedure openFile();
        procedure saveFile();
        procedure openHelp();
        procedure showAboutBox();
        procedure setViewOnlyMode(boolValue: boolean);
        procedure setAutoLayoutMode(boolValue: boolean);
        procedure workSpaceImageMouseDown(x, y: integer);
        procedure workSpaceImageMouseMove(x, y: integer);
    end;

function getRecognitionService(): IRecognitionService; stdcall; external 'CORE';

implementation

uses SysUtils, Dialogs, Controls, Graphics, number, systemConsts, aboutView,
    Classes, resultView, MBC.Classes;

{ TMainViewPresenterImpl }

{*------------------------------------------------------------------------------
  Метод для связывания presenter и mainview
  @param mainView   ParameterDescription
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.bindView(const mainView: IMainView);
begin
    fMainView := mainView;
end;


{*------------------------------------------------------------------------------
  Метод очистки разметки
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
    Констуктор
  @param mainView   главное окно
  @param model   модель данных галвного вида
  @param userInputService   сервис для ввода номера
  @param ImageGeneratorService   сервис для генерации номера
  @return
------------------------------------------------------------------------------*}

constructor TMainViewPresenter.create(const mainView: IMainView;
    const model: IMainViewModel;
    const userInputService: IUserInputService;
    const imageGeneratorService: IImageGeneratorService;
    const recognitionService: IRecognitionService);
begin
    fMainView := mainView;
    fUserInputService := userInputService;
    fMainViewModel := model;
    fImageGeneratorService := imageGeneratorService;
end;

{*------------------------------------------------------------------------------
  Деструктор
  @return ResultDescription
 ------------------------------------------------------------------------------*}

destructor TMainViewPresenter.destroy;
begin
    //HtmlHelp(GetDesktopWindow, nil, HH_CLOSE_ALL, 0);
    inherited;
end;

{*------------------------------------------------------------------------------
  Метод распознавания изображения
  @param boolWholeNumber   Признак распознавания всего номера
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.executeRecognition(boolWholeNumber: boolean = false);
var
    reportBuilder: TStringList;
    strSecNumber: string;
    i: integer;
    resultView: IResultView;
    log: TLog;
    fRecognitionService: IRecognitionService;
begin
    if (fMainViewModel.currentNumberBitmap.Empty) then
        exit;
    log := TLog.create();

    fRecognitionService := getRecognitionService();

    if (boolWholeNumber) then
    begin
        fMainView.getStatusBar.setStatus('Выполняется распознавание', 1000, true);

        fRecognitionService.Initialize(fMainViewModel, true);

        reportBuilder := fRecognitionService.getReport();
        resultView := Emballo.Get(IResultView) as IResultView;
        resultView.bind(fMainView.getObject(), reportBuilder);
        resultView.show();
        reportBuilder.SaveToFile('report.txt');

        freeAndNil(reportBuilder);
    end
    else
        if (InputQuery('Выбор секции', 'Выберите номер секции(секиции начинаются с 0)', strSecNumber)) then
        begin
            if (Trim(strSecNumber) = '') then
            begin
                freeAndNil(log);
                exit;
            end;
            if (strToInt(strSecNumber) > fMainViewModel.layoutStep) then
            begin
                showMessage('Номер секции не может быть больше количества размеченных.');
                freeAndNil(log);
                exit;
            end;

            fMainView.getStatusBar.setStatus('Выполняется распознавание', 2000, true);

            fRecognitionService.Initialize(fMainViewModel, false, strToInt(strSecNumber));

            reportBuilder := fRecognitionService.getReport();
            resultView := Emballo.Get(IResultView) as IResultView;
            resultView.bind(fMainView.getObject(), reportBuilder);
            resultView.show();
            reportBuilder.SaveToFile('report.txt');
            freeAndNil(reportBuilder);
        end;
    fRecognitionService.unregister();
    freeAndNil(log);
end;


{*------------------------------------------------------------------------------
    Метод генерации номера
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
    Метод загрузки изображения номера из файла
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.openFile;
var
    openDialog: TOpenDialog;
begin
    openDialog := TOpenDialog.Create(fMainView.getObject);
    openDialog.InitialDir := getCurrentDir();
    openDialog.Options := [ofFileMustExist];
    openDialog.Filter := 'Файлы изображений|*.bmp';
    openDialog.FilterIndex := 1;

    if (openDialog.execute()) then
    begin
        fMainViewModel.currentNumberBitmap.LoadFromFile(openDialog.FileName);
        fMainViewModel.currentNumberName := '';
        fMainView.getWorkspace().setWorkspaceBitmap(fMainViewModel.currentNumberBitmap);
        fMainView.getStatusBar().setStatus('Изображение открыто', 1000);
        updateView();
    end;

    freeAndNil(openDialog);
end;

{*------------------------------------------------------------------------------
  Метод открытия справки из главного меню
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.openHelp;
begin
    HtmlHelp(0, 'chareco help.chm', HH_DISPLAY_TOPIC, 0);
end;

{*------------------------------------------------------------------------------
    Метод сохранения изображения номера в файл
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.saveFile;
var
    saveFileDlg: TSaveDialog;
begin
    saveFileDlg := TSaveDialog.Create(fMainView.getObject);
    saveFileDlg.Title := 'Сохранение номера';
    saveFileDlg.InitialDir := getCurrentDir();
    saveFileDlg.Filter := 'Файлы изображений|*.bmp';
    saveFileDlg.DefaultExt := 'bmp';
    saveFileDlg.FilterIndex := 1;
    saveFileDlg.FileName := fMainViewModel.currentNumberName;

    if (saveFileDlg.Execute()) then
    begin
        fMainViewModel.currentNumberBitmap.SaveToFile(saveFileDlg.FileName);
        fMainView.getStatusBar().setStatus('Изображение сохранено', 1000);
    end;
    FreeAndNil(saveFileDlg);
end;

{*------------------------------------------------------------------------------
    Метод установки режима разметки
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.setAutoLayoutMode(boolValue: boolean);
begin
    fMainViewModel.autoLayoutMode := boolValue;
    updateView();
end;

procedure TMainViewPresenter.setMainViewAndSetupLayoutMode;
var
    ws: IGUIWorkspace;
    cursor: TCursor;
    i: integer;
begin
    ws := fMainView.getWorkspace();
    ws.setCursor(crCross);
    updateView();
end;

{*------------------------------------------------------------------------------
    Метод установки режима только просмотра
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

    updateView();
end;

{*------------------------------------------------------------------------------
  Метод установки режима только просмотр или просмотр и разметка
  @param boolValue   ParameterDescription
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.setupLayout;
var
    i: integer;
begin
     // Накладываем разметку
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
  Метод установки режима только просмотра
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
  Метод отображения диалога о программу
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.showAboutBox;
var
    view: IAboutView;
begin
    view := Emballo.Get(IAboutView) as IAboutView;
    view.show();
end;

{*------------------------------------------------------------------------------
  Метод обновления оборажения
  @return ResultDescription
------------------------------------------------------------------------------*}

procedure TMainViewPresenter.updateView;
begin
    fMainViewModel.currentNumberBitmapWithLayout.Canvas.Draw(0, 0, fMainViewModel.currentNumberBitmap);
    setupLayout();
    fMainView.getWorkspace.setWorkspaceBitmap(fMainViewModel.currentNumberBitmapWithLayout);
end;


{*------------------------------------------------------------------------------
  Метод отображения результатов при перемещении мыши над рабочей областью
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

        // Обновляем отображение. иначе не будет видно номера
        updateView();

        // Накладываем разметку
        setupLayout();

        // Если курсов в заданной области, то накладываем и его
        if (x >= left0) and (y >= top0) and
            (x <= left0 + numberWidth) and (y <= top0 + numberHeight) then
        begin
            fMainViewModel.currentNumberBitmapWithLayout.Canvas.Pen.Style := psDot;
            fMainViewModel.currentNumberBitmapWithLayout.Canvas.MoveTo(x - left0, 0);
            fMainViewModel.currentNumberBitmapWithLayout.Canvas.LineTo(x - left0, numberHeight);

            statusBar := fMainView.getStatusBar();
            statusBar.setStatus('x:' + intToStr(x - left0), 0, false);
            //statusBar.setStatus('x:' + intToStr(x) + '  y:' + intToStr(y));
        end;

        ws.setWorkspaceBitmap(fMainViewModel.currentNumberBitmapWithLayout);
    end;
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IMainViewPresenter, TMainViewPresenter);
end.

