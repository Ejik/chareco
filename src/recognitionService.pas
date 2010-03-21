unit recognitionService;

interface

uses
    Graphics, mainViewModel, Classes;

type
    IRecognitionService = interface
        ['{0EEDC417-9021-4B77-BBC4-EC5C0E487C45}']
        function getReport(): TStringList;
        procedure initialize(model: IMainViewModel; boolWholeNumber: boolean = false; iSectionNumber: integer = 0);
        procedure unregister();
    end;

implementation

end.

 