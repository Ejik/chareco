unit recognizerBaseImpl;

interface

uses
    EBDependencyInjection, EBInjectable, Graphics, recognizer, reporter;

type

    TRecognizerBase = class(TInjectable, IRecognizerBase)
    protected
        function calculateFormula(numberValue: integer; patternValue: integer; width: integer; height: integer): integer; virtual; abstract;
    public
        function calculateSign(bitmap: TBitmap): integer; virtual; abstract;
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean; virtual; abstract;

    end;

implementation

uses
    SysUtils;

{ TRecognizerBase }

end.

 