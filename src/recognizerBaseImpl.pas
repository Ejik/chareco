unit recognizerBaseImpl;

interface

uses
    EBDependencyInjection, EBInjectable, Graphics, recognizer, reporter;

type

    TRecognizerBase = class(TInjectable, IRecognizerBase)

    public
        function calculateSign(bitmap: TBitmap) : integer; virtual; abstract;
        function recognize(bitmap: TBitmap; var reporter: IReporter) : boolean; virtual; abstract;
    end;

implementation

uses
  SysUtils;

{ TRecognizerBase }

end.

 