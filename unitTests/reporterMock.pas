unit reporterMock;

interface

uses
    reporter, Classes;

type
    TReporterMock = class(TInterfacedObject, IReporter)
    private
        fmax, fmid, fmin: integer;
    public
        destructor destroy(); override;
        procedure initReport(data: TStringList);
        function getMaxMatch(): string;
        function getMidMatch(): string;
        function getMinMatch(): string;
        function getMaxMatchSymbol(): string;
        function getMaxMatchPercent(): integer;
    end;

implementation

uses TypInfo, SysUtils;

{ TReporterMock }



destructor TReporterMock.destroy;
begin

    inherited;
end;

function TReporterMock.getMaxMatch: string;
begin
    result := '100%';
end;

function TReporterMock.getMaxMatchPercent: integer;
begin

end;

function TReporterMock.getMaxMatchSymbol: string;
begin

end;

function TReporterMock.getMidMatch: string;
begin

end;

function TReporterMock.getMinMatch: string;
begin

end;


procedure TReporterMock.initReport(data: TStringList);
begin

end;

end.

