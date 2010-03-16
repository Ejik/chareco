unit recognitionServiceImpl;

interface

uses
    recognitionService, EBDependencyInjection, EBInjectable;

type
    TRecognitionService = class(TInjectable, IRecognitionService)
    public
        procedure ExecuteMethodA();
        procedure ExecuteMethodB();
        procedure ExecuteMethodC();
    end;

implementation

uses
  EBDIRegistry;

{ TRecognitionService }

procedure TRecognitionService.ExecuteMethodA;
begin

end;

procedure TRecognitionService.ExecuteMethodB;
begin

end;

procedure TRecognitionService.ExecuteMethodC;
begin

end;

initialization
    GetDIRegistry.RegisterFactorySingleton(IRecognitionService, TRecognitionService);
end.

