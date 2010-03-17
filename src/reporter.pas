unit reporter;

interface

uses
    Classes;

type
    IReporter = interface
        ['{924C0996-90B0-4A97-A8B4-11BCD04D7961}']
        procedure initReport(data: TStringList);
        function getMaxMatch(): string;
        function getMidMatch(): string;
        function getMinMatch(): string;
    end;

implementation

end.

