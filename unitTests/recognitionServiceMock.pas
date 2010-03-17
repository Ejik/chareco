unit recognitionServiceMock;

interface

uses
    recognitionService, mainViewModel, reporter;

type
    TRecognitionServiceMock = class(TInterfacedObject, IRecognitionService)
    public
        function ExecuteMethodA() : IReporter;
        function ExecuteMethodB() : IReporter;
        function ExecuteMethodC() : IReporter;
        procedure Initialize(model: IMainViewModel; boolEntireNumber: boolean = false; iSectionNumber: integer = 1);
    end;

implementation

{ TRecognitionServiceMock }


function TRecognitionServiceMock.ExecuteMethodA: IReporter;
begin

end;

function TRecognitionServiceMock.ExecuteMethodB: IReporter;
begin

end;

function TRecognitionServiceMock.ExecuteMethodC: IReporter;
begin

end;

procedure TRecognitionServiceMock.Initialize(model: IMainViewModel;
  boolEntireNumber: boolean; iSectionNumber: integer);
begin

end;

end.

