unit recognizerByMaskImpl;

interface

uses
    recognizer, recognizerBaseImpl, Graphics, reporter, imageRepository;

type
    TRecognizerByMask = class(TRecognizerBase, IRecognizerByMask)
    private
        fPatternsRepo: IImageRepository;
        function getPercentage(S, Si: integer): integer;
    protected
        function calculateFormula(maskValue: integer; width: integer; height: integer): integer; reintroduce; virtual;
    public
        function calculateSign(bitmap: TBitmap): integer; override;
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean; override;
    end;


implementation

uses
    SysUtils, Classes, EBDIRegistry;

{ TRecognizerByVector }

function TRecognizerByMask.calculateFormula(maskValue, width,
  height: integer): integer;
begin
    result := round((1 - maskValue / (height * width)) * 100);
end;

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
            if (scanLine^[x] = 255) then // 255 = clWhite
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
    pattern: TBitmap;
    patternArea: integer; // площадь Si i-го паттерна
    numberArea: integer; // площадь распознаваемого символа
    arrD: TStringList; // массив расстояний между эталонными и распознаваемым символами
    strName: string;
    maskValue: integer; // процент совпадения
begin
    inherited;
    result := true;
    fPatternsRepo.initialize();

    arrD := TStringList.create();


    for i := 0 to fPatternsRepo.getPatternsCount() - 1 do
    begin
        strName := fPatternsRepo.getImageNameByIndex(i);
        pattern := fPatternsRepo.getImage(strName);

        pattern.Canvas.CopyMode := cmSrcInvert;
        pattern.Canvas.CopyRect(pattern.Canvas.ClipRect, bitmap.Canvas, bitmap.Canvas.ClipRect);

        maskValue := calculateSign(pattern);

        if (strName = 'bl') then
            strName := ' ';

        arrD.add(strName + '=' + intToStr(calculateFormula(maskValue, pattern.Width, pattern.Height)));
        freeAndNil(pattern);

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
    arrD.SaveToFile('maskExtReport.txt');
    reporter.initReport(arrD);

    freeAndNil(arrD);
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognizerByMask, TRecognizerByMask);

end.

