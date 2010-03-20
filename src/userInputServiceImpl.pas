unit userInputServiceImpl;

interface

uses
    EBInjectable, EBDIRegistry, EBDependencyInjection, userInputService;
type
    TUserInputService = class(TInjectable, IUserInputService)
    private

    public
        function checkNumber(const strNumber: string): boolean;
        function inputNumber(): string;
    end;

implementation

uses
    inputNumberDlg, Forms, Controls, SysUtils, Dialogs, systemConsts;


{ TUserInputService }

function TUserInputService.checkNumber(const strNumber: string): boolean;
var
    i: integer;
    n: integer;
    boolOK: boolean;
begin
    result := false;
    if (length(strNumber) > NumberLength) then
        exit;
    for i := 1 to length(strNumber) do
    begin
        boolOK := TryStrToInt(strNumber[i], n);
        if not boolOK then
            if (strNumber[i] = 'A')
                or (strNumber[i] = 'E')
                or (strNumber[i] = 'B')
                or (strNumber[i] = 'K')
                or (strNumber[i] = 'M')
                or (strNumber[i] = 'N')
                or (strNumber[i] = 'H')
                or (strNumber[i] = 'O')
                or (strNumber[i] = 'P')
                or (strNumber[i] = 'C')
                or (strNumber[i] = 'T')
                or (strNumber[i] = 'Y')
                or (strNumber[i] = 'X')
                or (strNumber[i] = 'D') then
            begin
                result := true;
            end
            else
            begin
                result := false;
                exit;
            end;
    end;
end;

function TUserInputService.inputNumber: string;
var
    inputNumDld: TfmInputNumDlg;
    mr: integer;
    isCorrect: boolean;
    strNumber: string;
begin
    result := '';
    inputNumDld := TfmInputNumDlg.Create(Application);
    repeat
        mr := inputNumDld.ShowModal();
        if (mr = mrOk) then
        begin
            strNumber := StringReplace(inputNumDld.MaskEdit.Text, ' ', '', [rfReplaceAll]);
            isCorrect := checkNumber(strNumber);
            if (not isCorrect) then
                ShowMessage('Не корректный номер');
            result := strNumber;
        end
        else
            result := '';

    until isCorrect or (mr = mrCancel);
    freeAndNil(inputNumDld);
end;

initialization
    GetDIRegistry.RegisterFactory(IUserInputService, TUserInputService);
end.

