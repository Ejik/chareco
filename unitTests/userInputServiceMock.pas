unit userInputServiceMock;

interface

uses
    UserInputService;
type
    TUserInputServiceMock = class (TInterfacedObject, IUserInputService)
         function inputNumber() : wideString;
    end;

implementation

{ TUserInputServiceMock }

function TUserInputServiceMock.inputNumber: wideString;
begin
    result := 'a111aa';
end;

end.
