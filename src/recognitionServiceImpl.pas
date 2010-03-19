unit recognitionServiceImpl;

interface

uses
    recognitionService, EBDependencyInjection, EBInjectable, Graphics,
    recognizerByAreaImpl, Classes, mainViewModel, recognizer, reporter;

type
    TResultCell = array[1..2] of string;
    TResultMatrix = array[1..3] of array[1..2] of string;


    TRecognitionService = class(TInjectable, IRecognitionService)
    private
        fModel: IMainViewModel;
        fboolEntireNumber: boolean;
        fSecNum: integer;
        fInitialiazed: boolean;
        fRecoByArea: IRecognizerByArea;
        fRecoByVector: IRecognizerByVector;
        fRecoByMask: IRecognizerByMask;
        fSectionList: TList;

        function getSectionByIndex(index: integer): TBitmap;
        function getBestResult(const matrix: TResultMatrix): TResultCell;
        procedure clearSectionList();
        procedure prepareSections();
    public
        destructor destroy(); override;
        procedure Initialize(model: IMainViewModel; boolEntireNumber: boolean = false; iSectionNumber: integer = 0);
        function getReport(): TStringList;
        function ExecuteMethodB(): IReporter;
        function ExecuteMethodC(): IReporter;
    end;

implementation

uses
    EBDIRegistry, TypInfo, SysUtils, Dialogs, systemConsts;

{ TRecognitionService }

destructor TRecognitionService.destroy;
begin
    if (fInitialiazed) then
        clearSectionList();
    freeAndNil(fSectionList);
    inherited;
end;

function TRecognitionService.getReport(): TStringList;
var
    i: integer;
    currentBitmap: TBitmap;
    reporter: IReporter;
    reportBuilder: TStringList;
    percents: TResultMatrix;
    resultNumber: string;
    resultCell: TResultCell;
begin
    reportBuilder := TStringList.create();
    reportBuilder.Add('Результаты анализа:');
    reportBuilder.Add('');
    result := reportBuilder;

    if (fboolEntireNumber) then
    begin
        reportBuilder.add('Комплексное распознавание');
        resultNumber := '';
        for i := 0 to NumberLength - 1 do
        begin

            currentBitmap := getSectionByIndex(i);
            if (currentBitmap = nil) then
            begin
                exit;
            end;

            // Метод 1
            reporter := Emballo.get(IReporter) as IReporter;
            fRecoByArea.recognize(currentBitmap, reporter);

            percents[1, 1] := reporter.getMaxMatchSymbol();
            percents[1, 2] := intToStr(reporter.getMaxMatchPercent());

            // Метод 2
            reporter := Emballo.get(IReporter) as IReporter;
            fRecoByVector.recognize(currentBitmap, reporter);
            percents[2, 1] := reporter.getMaxMatchSymbol();
            percents[2, 2] := intToStr(reporter.getMaxMatchPercent());

            // Метод 3
            reporter := Emballo.get(IReporter) as IReporter;
            fRecoByMask.recognize(currentBitmap, reporter);
            percents[3, 1] := reporter.getMaxMatchSymbol();
            percents[3, 2] := intToStr(reporter.getMaxMatchPercent());

            resultCell := getBestResult(percents);

            reportBuilder.add('Символ: ' + resultCell[1] +
                ' ' + resultCell[2] + '%');

            resultNumber := resultNumber + resultCell[1];

        end;
        reportBuilder.Insert(2, 'Результат: ' + resultNumber);
    end // if (fboolEntireNumber) then
    else
    begin
        reporter := Emballo.get(IReporter) as IReporter;

        currentBitmap := getSectionByIndex(fSecNum);
        if (currentBitmap <> nil) then
        begin
            reporter := Emballo.get(IReporter) as IReporter;
            fRecoByArea.recognize(currentBitmap, reporter);
        end
        else
            exit;
        reportBuilder.add('Метод распознавания "по площади"');
        reportBuilder.add('Результат: ' + reporter.getMaxMatchSymbol());
        reportBuilder.add(reporter.getMaxMatch() + '%');
        reportBuilder.add(reporter.getMidMatch() + '%');
        reportBuilder.add(reporter.getMinMatch() + '%');
        reportBuilder.add('');
        percents[1, 1] := reporter.getMaxMatchSymbol();
        percents[1, 2] := intToStr(reporter.getMaxMatchPercent());

        if (currentBitmap <> nil) then
        begin
            reporter := Emballo.get(IReporter) as IReporter;
            fRecoByVector.recognize(currentBitmap, reporter);
        end
        else
            exit;
        reportBuilder.add('Метод распознавания "по вектору"');
        reportBuilder.add('Результат: ' + reporter.getMaxMatchSymbol());
        reportBuilder.add(reporter.getMaxMatch() + '%');
        reportBuilder.add(reporter.getMidMatch() + '%');
        reportBuilder.add(reporter.getMinMatch() + '%');
        reportBuilder.add('');
        percents[2, 1] := reporter.getMaxMatchSymbol();
        percents[2, 2] := intToStr(reporter.getMaxMatchPercent());

        if (currentBitmap <> nil) then
        begin
            reporter := Emballo.get(IReporter) as IReporter;
            fRecoByMask.recognize(currentBitmap, reporter);
        end
        else
            exit;

        reportBuilder.add('Метод распознавания "по маске"');
        reportBuilder.add('Результат: ' + reporter.getMaxMatchSymbol());
        reportBuilder.add(reporter.getMaxMatch() + '%');
        reportBuilder.add(reporter.getMidMatch() + '%');
        reportBuilder.add(reporter.getMinMatch() + '%');
        reportBuilder.add('');
        percents[3, 1] := reporter.getMaxMatchSymbol();
        percents[3, 2] := intToStr(reporter.getMaxMatchPercent());

        reportBuilder.add('Комплексное распознавание');
        reportBuilder.add('Результат: ' + getBestResult(percents)[1, 1]);

        reportBuilder.add('');
    end;

end;

function TRecognitionService.ExecuteMethodB: IReporter;
begin

end;

function TRecognitionService.ExecuteMethodC: IReporter;
begin

end;

function TRecognitionService.getSectionByIndex(index: integer): TBitmap;
begin
    try
        result := fSectionList[index];
    except
        showMessage('Выход за пределы списка секций.');
        result := nil;
    end;
end;

procedure TRecognitionService.Initialize(model: IMainViewModel; boolEntireNumber: boolean = false; iSectionNumber: integer = 0);
begin
    fmodel := model;
    fboolEntireNumber := boolEntireNumber;
    fSecNum := iSectionNumber;
    fInitialiazed := true;
    if (fSectionList = nil) then
    begin
        fSectionList := TList.create();
    end;
    clearSectionList();
    prepareSections();
end;

procedure TRecognitionService.prepareSections();
    procedure addBitmap(left, width: integer); // procedure addBitmap
    var
        buffer: TBitmap;
    begin
        if (width <= 0) then
            exit;
        buffer := TBitmap.create();
        buffer.Width := width;
        buffer.Height := NumberHeight;

        buffer.Canvas.CopyRect(
            Rect(0, 0, width, NumberHeight),
            fModel.currentNumberBitmap.Canvas,
            Rect(left, 0, left + width, NumberHeight)
            );

        fSectionList.Add(buffer);
    end; //  procedure addBitmap;

begin // procedure TRecognitionService.

    addBitmap(0, fModel.layoutPoint[0]);
    addBitmap(fModel.layoutPoint[0], fModel.layoutPoint[1] - fModel.layoutPoint[0]);
    addBitmap(fModel.layoutPoint[1], fModel.layoutPoint[2] - fModel.layoutPoint[1]);
    addBitmap(fModel.layoutPoint[2], fModel.layoutPoint[3] - fModel.layoutPoint[2]);
    addBitmap(fModel.layoutPoint[3], fModel.layoutPoint[4] - fModel.layoutPoint[3]);
    addBitmap(fModel.layoutPoint[4], fModel.layoutPoint[5] - fModel.layoutPoint[4]);
    addBitmap(fModel.layoutPoint[5], fModel.layoutPoint[6] - fModel.layoutPoint[5]);
    addBitmap(fModel.layoutPoint[6], fModel.layoutPoint[7] - fModel.layoutPoint[6]);
    addBitmap(fModel.layoutPoint[7], NumberWidth - fModel.layoutPoint[7]);

end; // procedure TRecognitionService.

function TRecognitionService.getBestResult(
    const matrix: TResultMatrix): TResultCell;
var
    i: integer;
begin

    // Если совпадения у 1 и 2 или у 1 и 3 методов
    if (matrix[1, 1] = matrix[2, 1]) or (matrix[1, 1] = matrix[3, 1]) then
    begin
        result[1] := matrix[1, 1];
        result[2] := matrix[1, 2];
    end
    else
        // Если совпадение у 2 и 3 методов
        if (matrix[2, 1] = matrix[3, 1]) then
        begin
            result[1] := matrix[2, 1];
            result[2] := matrix[2, 2];
        end
        else
        // Если нет совпадений, выбираем знак по максимальным процентам
        begin
            result[1] := matrix[1, 1];
            result[2] := matrix[1, 2];
            for i := 2 to 3 do
            begin
                if (StrToInt(matrix[i, 2]) > strToInt(result[2])) then
                begin
                    result[1] := matrix[i, 1];
                    result[2] := matrix[i, 2];
                end;
            end;
        end;

end;

procedure TRecognitionService.clearSectionList;
var
    i: integer;
    bmp: TBitmap;
begin
    for i := 0 to fSectionList.Count - 1 do
    begin
        bmp := TBitmap(fSectionList[i]);
        freeAndNil(bmp);
    end;
    fSectionList.clear();
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognitionService, TRecognitionService);
end.


