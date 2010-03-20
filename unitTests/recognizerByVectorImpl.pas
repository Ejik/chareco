unit recognizerByVectorImpl;

interface

uses
    recognizer, recognizerBaseImpl, Graphics, reporter, imageRepository;

type
    TRecognizerByVector = class(TRecognizerBase, IRecognizerByVector)
    private
        fPatternsRepo: IImageRepository;
        procedure serializeVector(const vector: TVector);
    protected
        function calculateFormula(D: integer; width: integer; height: integer): integer; reintroduce; virtual;
    public
        function calculateSign(bitmap: TBitmap): TVector; reintroduce; virtual;
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

    for x := 0 to bitmap.Width + bitmap.Height - 1 do
        result[x] := 0;

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
            D := D + abs(numberSign[j] - patternSign[j]);// * (numberSign[j] - patternSign[j]);

        arrD.add(strName + '=' + intToStr(calculateFormula(D, pattern.Width, pattern.Height)));

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

procedure TRecognizerByVector.serializeVector(const vector: TVector);
var
    i: integer;
    buffer: TStringList;
begin
    buffer := TStringList.create();
    for i := 0 to length(vector) - 1 do
    begin
        buffer.Add(intToStr(vector[i]));
    end;
    buffer.SaveToFile('vector.txt');
    freeAndNil(buffer);
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognizerByVector, TRecognizerByVector);
end.

