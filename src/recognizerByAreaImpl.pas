unit recognizerByAreaImpl;

interface

uses
    recognizerBaseImpl, Graphics, recognizer, reporter, imageRepository;

type

    TRecognizerByArea = class(TRecognizerBase, IRecognizerByArea)
    private
        fPatternsRepo: IImageRepository;
        fReporter: IReporter;
        function getPercentage(S, Si: integer): integer;
    public
        constructor create(patternsRepo: IImageRepository;
            reporter: IReporter); overload;
        destructor destroy(); override;

        function recognize(bitmap: TBitmap): IReporter; override;
    end;

implementation

uses
    EBDIRegistry, EBDependencyInjection, SysUtils, systemConsts,
    Classes;

{ TRecognizerByArea }


constructor TRecognizerByArea.create(patternsRepo: IImageRepository;
    reporter: IReporter);
begin
    fPatternsRepo := patternsRepo;
    fReporter := reporter;
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

function TRecognizerByArea.recognize(bitmap: TBitmap): IReporter;
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
    arrD := TStringList.create();
    numberArea := calculateArea(bitmap);

    for i := 0 to fPatternsRepo.getPatternsCount() - 1 do
    begin
        strName := fPatternsRepo.getImageNameByIndex(i);
        buffer := fPatternsRepo.getImage(strName);
        patternArea := calculateArea(buffer);

        freeAndNil(buffer);

        // Будем сразу считать не расстояния, а процент совпадени, поэтому пока
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
    fReporter.initReport(arrD);
    result := fReporter;
    freeAndNil(arrD);
end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognizerByArea, TRecognizerByArea);

end.

 