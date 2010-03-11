program chareco;

uses
    FastMM4,
    Forms,
    mainViewImpl in 'src\mainViewImpl.pas' {Form1},
    mainViewModelImpl in 'src\mainViewModelImpl.pas',
    mainView in 'src\mainView.pas',
    mainViewPresenter in 'src\mainViewPresenter.pas',
    mainViewPresenterImpl in 'src\mainViewPresenterImpl.pas',
    userInputService in 'src\userInputService.pas',
    userInputServiceImpl in 'src\userInputServiceImpl.pas',
    inputNumberDlg in 'src\inputNumberDlg.pas' {fmInputNumDlg},
    mainViewModel in 'src\mainViewModel.pas',
    imageGeneratorService in 'src\imageGeneratorService.pas',
    ImageGeneratorServiceImpl in 'src\ImageGeneratorServiceImpl.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TfmInputNumDlg, fmInputNumDlg);
    Application.Run;
end.

