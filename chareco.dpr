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
  ImageGeneratorServiceImpl in 'src\ImageGeneratorServiceImpl.pas',
  guiStatusBarImpl in 'src\guiStatusBarImpl.pas',
  guiWorkspaceImpl in 'src\guiWorkspaceImpl.pas',
  number in 'src\number.pas',
  numberImpl in 'src\numberImpl.pas',
  systemConsts in 'src\systemConsts.pas',
  guiThreadImpl in 'src\guiThreadImpl.pas',
  aboutViewImpl in 'src\aboutViewImpl.pas' {AboutBox},
  aboutView in 'src\aboutView.pas',
  recognitionService in 'src\recognitionService.pas',
  recognitionServiceImpl in 'src\recognitionServiceImpl.pas',
  recognizerBaseImpl in 'src\recognizerBaseImpl.pas',
  imageRepository in 'src\imageRepository.pas',
  imageRepositoryImpl in 'src\imageRepositoryImpl.pas',
  recognizerByAreaImpl in 'src\recognizerByAreaImpl.pas',
  recognizer in 'src\recognizer.pas',
  reporter in 'src\reporter.pas',
  reporterImpl in 'src\reporterImpl.pas',
  resultViewImpl in 'src\resultViewImpl.pas' {OKBottomDlg},
  resultView in 'src\resultView.pas',
  MBC.Classes in 'src\MBC.Classes.pas',
  recognizerByVectorImpl in 'unitTests\recognizerByVectorImpl.pas',
  recognizerByMaskImpl in 'src\recognizerByMaskImpl.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

