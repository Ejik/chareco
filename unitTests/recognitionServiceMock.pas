unit recognitionServiceMock;

interface

uses
    recognitionService, mainViewModel, reporter, Classes;

type
    TRecognitionServiceMock = class(TInterfacedObject, IRecognitionService)
    public
        function getReport() : TStringList;
        function ExecuteMethodB() : IReporter;
        function ExecuteMethodC() : IReporter;
        procedure initialize(model: IMainViewModel; boolEntireNumber: boolean = false; iSectionNumber: integer = 1);
        procedure unregister();
    end;

implementation

{ TRecognitionServiceMock }


function TRecognitionServiceMock.ExecuteMethodB: IReporter;
begin

end;

function TRecognitionServiceMock.ExecuteMethodC: IReporter;
begin

end;

function TRecognitionServiceMock.getReport: TStringList;
begin

end;

procedure TRecognitionServiceMock.Initialize(model: IMainViewModel;
  boolEntireNumber: boolean; iSectionNumber: integer);
begin

end;

procedure TRecognitionServiceMock.unregister;
begin

end;

end.

