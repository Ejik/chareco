unit recognizerBaseImpl;

interface

uses
    EBDependencyInjection, EBInjectable, Graphics, recognizer, reporter;

type

    TRecognizerBase = class(TInjectable, IRecognizerBase)

    public
        function calculateArea(bitmap: TBitmap) : integer; virtual;
        function recognize(bitmap: TBitmap; const reporter: IReporter) : IReporter; virtual; abstract;
    end;

implementation

uses
  SysUtils;

{ TRecognizerBase }

function TRecognizerBase.calculateArea(bitmap: TBitmap) : integer;
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

end.

 