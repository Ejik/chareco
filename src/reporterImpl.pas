unit reporterImpl;

interface

uses
    reporter, EBInjectable, Classes;

type
    TReporter = class(TInjectable, IReporter)
    private
        fData: TStringList;

    public
        destructor Destroy(); override;

        procedure initReport(data: TStringList);
        function getMaxMatch(): string;
        function getMidMatch(): string;
        function getMinMatch(): string;
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
    result := fData.Names[0] + ' ' + fData.ValueFromIndex[0];
end;

function TReporter.getMidMatch: string;
begin
    result := fData.Names[1] + ' ' + fData.ValueFromIndex[1];
end;

function TReporter.getMinMatch: string;
begin
    result := fData.Names[3] + ' ' + fData.ValueFromIndex[3];
end;

initialization
    GetDIRegistry.RegisterFactory(IReporter, TReporter);

end.

