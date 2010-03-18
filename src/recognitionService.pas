unit recognitionService;

interface

uses
    Graphics, mainViewModel, reporter, Classes;

type
    IRecognitionService = interface
        ['{0EEDC417-9021-4B77-BBC4-EC5C0E487C45}']
        function getReport(): TStringList;
        function ExecuteMethodB(): IReporter;
        function ExecuteMethodC(): IReporter;
        procedure Initialize(model: IMainViewModel; boolWholeNumber: boolean = false; iSectionNumber: integer = 0);
    end;
implementation

end.

 