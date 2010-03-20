unit recognizerByVectorImpl;

interface

uses
    recognizer, recognizerBaseImpl, Graphics, reporter, imageRepository;

type
    TRecognizerByVector = class(TRecognizerBase, IRecognizerByVector)
    private
        fPatternsRepo: IImageRepository;
        function getPercentage(S, Si: integer): integer;
    protected
        function calculateFormula(D: integer; width: integer; height: integer): integer; reintroduce; virtual;
    public
        function calculateSign(bitmap: TBitmap): TVector;  reintroduce; virtual;
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean; override;
    end;


implementation

uses
    SysUtils, Classes, EBDIRegistry;

{ TRecognizerByVector }


function TRecognizerByVector.calculateFormula(D: integer; width, height: integer): integer;
begin
    result := round((1 - D / (Height * Width)) * 100);
    //result := round((1 - (Height * Width) / D) * 100);
end;

function TRecognizerByVector.calculateSign(bitmap: TBitmap): TVector;
var
    k: integer; // k-й элемент вектора
    scanLine: PByteArray;
    x, y: integer;
    sumRow: integer; // сумма пикселей в строке
begin
    bitmap.PixelFormat := pf8bit;
    setLength(result, bitmap.Width + bitmap.Height);

    k := 0;
    for y := 0 to bitmap.Height - 1 do
    begin
        sumRow := 0;
        scanLine := bitmap.ScanLine[y];
        for x := 0 to bitmap.Width - 1 do
        begin
            if (scanLine^[x] = clBlack) then
            begin
                sumRow := sumRow + 1;
                result[x] := result[x] + 1;
            end;
        end;

        result[bitmap.Width + k] := sumRow;

        k := k + 1;
    end;

end;

function TRecognizerByVector.getPercentage(S, Si: integer): integer;
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


function TRecognizerByVector.recognize(bitmap: TBitmap;
    var reporter: IReporter): boolean;
var
    i, j: integer;
    pattern: TBitmap;
    patternSign: TVector; // вектор Si i-го паттерна
    numberSign: TVector; // вектор распознаваемого символа
    arrD: TStringList; // массив расстояний между эталонными и распознаваемым символами
    strName: string;
    percent: integer; // процент совпадения
    D: integer; // расстояние между эталоном и рапознаваемым символом
    minVictorLength: TVector; // вектор минимальной длины
begin
    inherited;
    result := true;
    fPatternsRepo.initialize();

    arrD := TStringList.create();
    numberSign := calculateSign(bitmap);

    for i := 0 to fPatternsRepo.getPatternsCount() - 1 do
    begin
        strName := fPatternsRepo.getImageNameByIndex(i);
        pattern := fPatternsRepo.getImage(strName);
        patternSign := calculateSign(pattern);

        if (strName = 'bl') then
            strName := ' ';
        // эталон и образец могут быть разными по размеру
        if (length(numberSign) > length(patternSign)) then
            minVictorLength := patternSign
        else
            minVictorLength := numberSign;

        d := 0;
        for j := 0 to length(minVictorLength) do
            D := D + (patternSign[j] - numberSign[j]) * (patternSign[j] - numberSign[j]);

        arrD.add(strName + '=' + intToStr(calculateFormula(D, pattern.Width, pattern.Height)));

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
    arrD.SaveToFile('vectorExtReport.txt');
    reporter.initReport(arrD);

    freeAndNil(arrD);
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognizerByVector, TRecognizerByVector);
end.

