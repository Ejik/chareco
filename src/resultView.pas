unit resultView;

interface

uses
  Forms, Classes;

type
    IResultView = interface
    ['{2987E787-AC83-4170-AE2E-8E0AA3855D3A}']
        procedure bind(owner: TComponent; data: TStringList);
        procedure show();
    end;


implementation

end.
