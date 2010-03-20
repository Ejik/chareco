unit recognizerByAreaImpl;

interface

uses
    recognizerBaseImpl, Graphics, recognizer, reporter, imageRepository;

type

    TRecognizerByArea = class(TRecognizerBase, IRecognizerByArea)
    private
        fPatternsRepo: IImageRepository;
        function getPercentage(S, Si: integer): integer;
    protected
        function calculateFormula(numberValue: integer; patternValue: integer; width: integer; height: integer): integer;
    public
        constructor create(const patternsRepo: IImageRepository); overload;
        destructor destroy(); override;

        function calculateSign(bitmap: TBitmap): integer;
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean; override;
    end;

implementation

uses
    EBDIRegistry, EBDependencyInjection, SysUtils, systemConsts,
    Classes;

{ TRecognizerByArea }


constructor TRecognizerByArea.create(const patternsRepo: IImageRepository);
begin
    fPatternsRepo := patternsRepo;
end;

destructor TRecognizerByArea.destroy;
begin

    inherited;
end;


function TRecognizerByArea.getPercentage(S, Si: integer): integer;
var
    difference: integer;
begin
    result := 0;
    difference := S - Si;

    if (difference = 0) then
        result := 100
    else
        if (difference < 0) then
            result := round(S / Si * 100)
        else
            if (difference > 0) then
                result := round(Si / S * 100);
end;

function TRecognizerByArea.recognize(bitmap: TBitmap; var reporter: IReporter): boolean;
var
    i: integer;
    pattern: TBitmap;
    patternArea: integer; // площадь Si i-го паттерна
    numberArea: integer; // площадь распознаваемого символа
    arrD: TStringList; // массив расстояний между эталонными и распознаваемым символами
    strName: string;
    percent: integer; // процент совпадения
begin
    inherited;
    result := true;
    fPatternsRepo.initialize();

    arrD := TStringList.create();
    numberArea := calculateSign(bitmap);

    for i := 0 to fPatternsRepo.getPatternsCount() - 1 do
    begin
        strName := fPatternsRepo.getImageNameByIndex(i);
        pattern := fPatternsRepo.getImage(strName);
        patternArea := calculateSign(pattern);

        if (strName = 'bl') then
            strName := ' ';

        // Будем сразу считать не расстояния, а процент совпадения, поэтому пока
        arrD.add(strName + '=' + intToStr(calculateFormula(numberArea, patternArea, pattern.Width, pattern.Height)));

        //percent := getPercentage(numberArea, patternArea);
        //arrD.add(strName + '=' + intToStr(getPercentage(numberArea, patternArea)));
        freeAndNil(pattern);
    end;

    // Отсортируем массив расстояний по возрастанию
    i := 0;
    while (i < arrD.Count - 1) do
    begin
        if (strToInt(arrD.ValueFromIndex[i]) < strToInt(arrD.ValueFromIndex[i + 1])) then
        begin
            arrD.Exchange(i, i + 1);
            i := 0;
        end
        else
            i := i + 1;
    end;
    arrD.SaveToFile('areaExtReport.txt');
    reporter.initReport(arrD);

    freeAndNil(arrD);
end;

function TRecognizerByArea.calculateSign(bitmap: TBitmap): integer;
var
    scanLine: PByteArray;
    x, y: integer;
begin
    result := 0;
    bitmap.PixelFormat := pf8bit;
    for y := 0 to bitmap.Height - 1 do
    begin
        scanLine := bitmap.ScanLine[y];
        for x := 0 to bitmap.Width - 1 do
            if (scanLine^[x] = clBlack) then
                result := result + 1;
    end;

end;


function TRecognizerByArea.calculateFormula(numberValue,
    patternValue: integer; width: integer; height: integer): integer;
begin
    result := round(
        (1 - abs(patternValue - numberValue)
        / (width * height)) * 100);
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognizerByArea, TRecognizerByArea);

end.

