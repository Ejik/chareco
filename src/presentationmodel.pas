unit PresentationModel;

interface

uses
    Classes, View;

type
    TPresentationModel = class
    private
        fViews: TList;
    public
        procedure Attach(view : TView); virtual;
        procedure Detach(view : TView); virtual;
        procedure Notify(); virtual;
    end;


implementation

procedure TPresentationModel.Attach(view : TView);
begin
    fViews.Add(view);
end;

procedure TPresentationModel.Detach(view: TView);
begin
    fViews.Remove(view);
end;

procedure TPresentationModel.Notify;
var
    i : integer;
begin
    for i := 0 to fViews.count - 1 do
        TView(fViews[i]).update();

end;

end.

