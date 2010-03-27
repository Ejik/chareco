unit reporterImpl;

interface

uses
    reporter, EBInjectable, Classes;

type
    TReporter = class(TInjectable, IReporter)
    private
        fData: TStringList;
        function valueToInt(const value : string) : string;
    public
        destructor Destroy(); override;

        procedure initReport(data: TStringList);
        function getMaxMatch(): string;
        function getMidMatch(): string;
        function getMinMatch(): string;
        function getMaxMatchSymbol(): string;
        function getMaxMatchPercent(): integer;
    end;

implementation

uses
    EBDIRegistry, SysUtils;

{ TReporter }

procedure TReporter.initReport(data: TStringList);
begin
    fData := TStringList.create();
    fData.Assign(data);
end;

destructor TReporter.Destroy;
begin
    freeAndNil(fData);
    inherited;
end;

function TReporter.getMaxMatch: string;
begin
    result := fData.Names[0] + ' ' + valueToInt(fData.ValueFromIndex[0]);
end;

function TReporter.getMidMatch: string;
begin
    result := fData.Names[1] + ' ' + valueToInt(fData.ValueFromIndex[1]);
end;

function TReporter.getMinMatch: string;
begin
    result := fData.Names[3] + ' ' + valueToInt(fData.ValueFromIndex[3]);
end;

function TReporter.getMaxMatchPercent: integer;
begin
    result := strToInt(valueToInt(fData.ValueFromIndex[0]));
end;

function TReporter.getMaxMatchSymbol: string;
begin
    if fData.Count = 0 then
        result := ''
    else
        result := fData.Names[0];
end;

function TReporter.valueToInt(const value: string): string;
var
    buffer : Extended;
begin
    buffer := StrToFloat(value);
    result := intToStr(round(buffer));
end;

initialization
    GetDIRegistry.RegisterFactory(IReporter, TReporter);

end.

