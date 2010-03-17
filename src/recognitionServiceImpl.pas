unit recognitionServiceImpl;

interface

uses
    recognitionService, EBDependencyInjection, EBInjectable, Graphics,
    recognizerByAreaImpl, Classes, mainViewModel, recognizer, reporter;

type
    TRecognitionService = class(TInjectable, IRecognitionService)
    private
        fModel: IMainViewModel;
        fboolEntireNumber: boolean;
        fSecNum: integer;
        fInitialiazed: boolean;
        fRecoByArea: IRecognizerByArea;
        fSectionList: TList;

        function getSectionByIndex(index: integer): TBitmap;
        procedure prepareSections();
    public
        destructor destroy(); override;
        procedure Initialize(model: IMainViewModel; boolEntireNumber: boolean = false; iSectionNumber: integer = 0);
        function ExecuteMethodA(): IReporter;
        function ExecuteMethodB(): IReporter;
        function ExecuteMethodC(): IReporter;
    end;

implementation

uses
    EBDIRegistry, TypInfo, SysUtils, Dialogs, systemConsts;

{ TRecognitionService }

destructor TRecognitionService.destroy;
var
    i: integer;
    bmp: TBitmap;
begin
    if (fInitialiazed) then
        for i := 0 to fSectionList.Count - 1 do
        begin
            bmp := TBitmap(fSectionList[i]);
            freeAndNil(bmp);
        end;
    freeAndNil(fSectionList);
    inherited;
end;

function TRecognitionService.ExecuteMethodA: IReporter;
var
    i: integer;
    currentBitmap: TBitmap;
begin
    if (fboolEntireNumber) then
    begin

    end
    else
    begin
        currentBitmap := getSectionByIndex(fSecNum);
        if (currentBitmap <> nil) then
            result := fRecoByArea.recognize(currentBitmap);
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
        prepareSections();
    end;
end;

procedure TRecognitionService.prepareSections();
    procedure addBitmap(left, width: integer); // procedure addBitmap
    var
        buffer: TBitmap;
    begin
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

    addBitmap(0, LettersWidth);
    addBitmap(fModel.layoutPoint[0], NumbersWidth);
    addBitmap(fModel.layoutPoint[1], NumbersWidth);
    addBitmap(fModel.layoutPoint[2], NumbersWidth);
    addBitmap(fModel.layoutPoint[3], LettersWidth);
    addBitmap(fModel.layoutPoint[4], LettersWidth);
    addBitmap(fModel.layoutPoint[5], NumbersWidth);
    addBitmap(fModel.layoutPoint[6], NumbersWidth);
    addBitmap(fModel.layoutPoint[7], NumbersWidth);

end; // procedure TRecognitionService.

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognitionService, TRecognitionService);
end.

