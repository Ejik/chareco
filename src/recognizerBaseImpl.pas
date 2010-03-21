unit recognizerBaseImpl;

interface

uses
    EBDependencyInjection, EBInjectable, Graphics, recognizer, reporter;

type

    TRecognizerBase = class(TInjectable, IRecognizerBase)
    protected
        function calculateFormula(numberValue: extended; patternValue: extended; width: integer; height: integer): extended; virtual; abstract;
    public
        function calculateSign(bitmap: TBitmap): extended; virtual; abstract;
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean; virtual; abstract;

    end;

implementation

uses
    SysUtils;

{ TRecognizerBase }

end.

 