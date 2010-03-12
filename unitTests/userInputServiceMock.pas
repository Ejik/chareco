unit userInputServiceMock;

interface

uses
    UserInputService;
type
    TUserInputServiceMock = class (TInterfacedObject, IUserInputService)
         function inputNumber() : string;
    end;

implementation

{ TUserInputServiceMock }

function TUserInputServiceMock.inputNumber: string;
begin
    result := 'a111aa';
end;

end.
