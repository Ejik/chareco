unit recogizerThreadImpl;

interface

uses
    recognizerBaseImpl, Graphics, reporter, Classes, recognizer;

type
    TRecognizerType = class of TRecognizerBase;

    TRecognizerThread = class(TThread)
    private
    { Private declarations }
        fRecogizer: TRecognizerType;
        fBitmap: TBitmap;
        fReporter: IReporter;
        function Factory(ClassType: TRecognizerType): IRecognizerBase;
    protected
        procedure Execute; override;
    public
        destructor destroy(); override;
        procedure initialiaze(classType: TRecognizerType; bitmap: TBitmap; const reporter: IReporter);
    end;

implementation

{ TGUIThread }

destructor TRecognizerThread.destroy;
begin

    inherited;
end;

procedure TRecognizerThread.Execute;
begin
    inherited;
    Factory(fRecogizer).recognize(fBitmap, fReporter);
end;

function TRecognizerThread.Factory(
    ClassType: TRecognizerType): IRecognizerBase;
begin
    Result := ClassType.Create();
end;

procedure TRecognizerThread.initialiaze(classType: TRecognizerType;
    bitmap: TBitmap; const reporter: IReporter);
begin
    fRecogizer := classType;
    fBitmap := bitmap;
    fReporter := reporter;
end;

end.

