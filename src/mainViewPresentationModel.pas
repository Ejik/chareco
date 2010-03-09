unit mainViewPresentationModel;

interface

uses
    PresentationModel, mainViewModel;

type
    TmainViewPresentationModel = class(TPresentationModel)
    private
        fModelState: TObject;
        fModel: TMainViewModel;
        function getModel(): TMainViewModel;
        procedure setModel(model: TMainViewModel);
        function getModelState(): TObject;
        procedure setModelState(modelState: TObject);

    public
        constructor create(model : TMainViewModel; modelState : TObject);
        destructor destroy();

        property Model: TMainViewModel read getModel write setModel; { get; set; }
        property ModelState: TObject read getModelState write setModelState; { get; set; }
    end;
implementation

{ TmainViewPresentationModel }

constructor TmainViewPresentationModel.create(model : TMainViewModel; modelState : TObject);
begin
    fModel := model;
    fModelState := modelState;
end;

destructor TmainViewPresentationModel.destroy;
begin

end;

function TmainViewPresentationModel.getModel: TMainViewModel;
begin
    result := fModel;
end;

function TmainViewPresentationModel.getModelState: TObject;
begin
    result := fModelState;
end;

procedure TmainViewPresentationModel.setModel(model: TMainViewModel);
begin

end;

procedure TmainViewPresentationModel.setModelState(modelState: TObject);
begin
    fModelState := modelState;
end;

end.

