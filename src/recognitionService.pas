unit recognitionService;

interface

uses
    Graphics, mainViewModel, reporter;

type
    IRecognitionService = interface
        ['{0EEDC417-9021-4B77-BBC4-EC5C0E487C45}']
        function ExecuteMethodA(): IReporter;
        function ExecuteMethodB(): IReporter;
        function ExecuteMethodC(): IReporter;
        procedure Initialize(model: IMainViewModel; boolEntireNumber: boolean = false; iSectionNumber: integer = 0);
    end;
implementation

end.

 