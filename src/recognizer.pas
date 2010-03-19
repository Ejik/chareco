unit recognizer;

interface

uses
    Graphics, reporter;

type
    IRecognizerBase = interface
        ['{9504D7F6-B2C8-42BE-9C2B-7BB554CDE8DE}']
        function recognize(bitmap: TBitmap; var reporter: IReporter): boolean;
        function calculateSign(bitmap: TBitmap): integer; 
    end;

    IRecognizerByArea = interface(IRecognizerBase)
        ['{9504D7F6-B2C8-42BE-9C2B-7BB554CDE8DE}']
    end;

    IRecognizerByVector = interface(IRecognizerBase)
        ['{B70F2D39-B55A-4FAB-B8D5-6BBA0D81B7D0}']
    end;

    IRecognizerByMask = interface(IRecognizerBase)
        ['{E7415901-8707-4A5D-972D-4E6B151A0D69}']
    end;


implementation

end.

