unit MBC.Classes;

interface

uses Classes, DB, Dialogs, DbClient;

type
    TMBCTableValues = class;

    TRow = class
    published
  //ID : integer;
        columns: TParams;
        constructor create(owner: TMBCTableValues);
        destructor destroy(); override;
        function get(index: integer): Variant;
    end;

    TMBCTableValues = class
    private
        rows: TList;
    published
        columns: TStringList;
        constructor create;
        destructor destroy(); override;
        function add(): TRow;
        function count(): integer;

    end;

    TLog = class
    private
        _filename: string;
    public
        constructor create(); overload;
    published
        constructor create(const filename: string); overload;
        procedure addToLog(const logText: string);
        function getRefCount(const i: IUnknown): Integer;
    end;

procedure addToLog(const logText: string);
function toString(Value: Variant): string;

implementation

uses TypInfo, SysUtils, Variants;

procedure addToLog(const logText: string);
var
    log: TLog;
begin
    log := TLog.Create();
    log.addToLog(logText);
    FreeAndNil(log);
end;

function toString(Value: Variant): string;
begin
    case TVarData(Value).VType of
        varSmallInt,
            varInteger: Result := IntToStr(Value);
        varSingle,
            varDouble,
            varCurrency: Result := FloatToStr(Value);
        varDate: Result := FormatDateTime('dd/mm/yyyy', Value);
        varBoolean: if Value then Result := 'T' else Result := 'F';
        varString: Result := Value;
    else
        try
            Result := VarToStr(value);
        except
            on E: Exception do
                Result := '';
        end;
    end;
end;

// TLog class

constructor TLog.create();
begin
    _filename := 'c:\mbcimport.log';
end;

constructor TLog.create(const filename: string);
begin
    _filename := filename;
end;

procedure TLog.addToLog(const logText: string);
var
    log: TStringList;
begin { TLog.addToLog }
    log := TStringList.create();
    if (FileExists(_filename)) then
        log.loadFromFile(_filename);
    log.Add('VK: ' + FormatDateTime('hh:mm:ss', Time) + ' ' + logText);
    log.saveToFile(_filename);
    freeAndNil(log);
end;

// TRow class

constructor TRow.create(owner: TMBCTableValues);
var
    i: integer;
    cols: TStringList;

begin
    cols := owner.columns;
    columns := TParams.create();
    for i := 0 to cols.Count - 1 do
    begin
        columns.AddParam(columns.CreateParam(ftVariant, cols[i], ptInputOutput));
    end;
end;

destructor TRow.destroy();
begin

 {for i := 0 to columns.Count - 1 do
 begin

    if (columns[i].value is TObject) then
      columns[i].Value.Free();
 end;}

    columns.Free();
end;

function TRow.get(index: integer): Variant;
begin
    Result := columns.Items[index].Value;
end;


// TMBC.TableValues

constructor TMBCTableValues.create();
begin
    columns := TStringList.create();
    rows := TList.create();
end;

destructor TMBCTableValues.destroy();
var
    i: integer;
begin
    for i := 0 to rows.count - 1 do
        TRow(rows[i]).free();

    rows.free();
    columns.free();
end;

function TMBCTableValues.add(): TRow;
var
    newRow: TRow;
begin
    newRow := TRow.create(self);
    rows.add(newRow);
    result := newRow;
end;


function TMBCTableValues.count: integer;
begin
    count := rows.Count;
end;

function TLog.getRefCount(const i: IInterface): Integer;
begin
    i._AddRef;
    Result := i._Release;
end;

end.

