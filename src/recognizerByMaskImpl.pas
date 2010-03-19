unit recognizerByMaskImpl;

interface

uses
    recognizer, recognizerBaseImpl, Graphics, reporter, imageRepository;

type
    TRecognizerByMask = class(TRecognizerBase, IRecognizerByMask)
    private
        fPatternsRepo: IImageRepository;
        function getPercentage(S, Si: integer): integer;
    public
        function calculateSign(bitmap: TBitmap): integer; override;
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean; override;
    end;


implementation

uses
    SysUtils, Classes, EBDIRegistry;

{ TRecognizerByVector }

function TRecognizerByMask.calculateSign(bitmap: TBitmap): integer;
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
            if (scanLine^[x] = 0) then
                result := result + 1;
    end;

end;

function TRecognizerByMask.getPercentage(S, Si: integer): integer;
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


function TRecognizerByMask.recognize(bitmap: TBitmap;
    var reporter: IReporter): boolean;
var
    i: integer;
    buffer: TBitmap;
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
        buffer := fPatternsRepo.getImage(strName);
        patternArea := calculateSign(buffer);

        freeAndNil(buffer);

        if (strName = 'bl') then
            strName := ' ';
        // Будем сразу считать не расстояния, а процент совпадения, поэтому пока
        // закомментируем расчет расстояний
        //arrD.add(strName + '=' + intToStr(numberArea - patternArea));
        percent := getPercentage(numberArea, patternArea);
        arrD.add(strName + '=' + intToStr(getPercentage(numberArea, patternArea)));
    end;

    // Отсортируем массив расстояний по убыванию
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
    arrD.SaveToFile('extReport.txt');
    reporter.initReport(arrD);

    freeAndNil(arrD);
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognizerByMask, TRecognizerByMask);

end.


