unit userInputServiceImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, userInputService;
type
    TUserInputService = class(TInjectable, IUserInputService)
        function inputNumber(): string;
    end;

implementation

uses
    inputNumberDlg, Forms, Controls;


{ TUserInputService }

function TUserInputService.inputNumber: string;
var
    inputNumDld: TfmInputNumDlg;
begin
    result := '';
    inputNumDld := TfmInputNumDlg.Create(Application);
    if (inputNumDld.ShowModal() = mrOk) then
    begin
        result := inputNumDld.MaskEdit.Text;
    end;
end;

initialization
    GetDIRegistry.RegisterFactory(IUserInputService, TUserInputService);
end.

