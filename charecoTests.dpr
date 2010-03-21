//{$APPTYPE CONSOLE}
program charecoTests;

uses
  FastMM4,
  TestFrameWork,
  GUITestRunner,
  TextTestRunner,
  Forms,
  TestsMainViewPresenter in 'unitTests\TestsMainViewPresenter.pas',
  mainViewMock in 'unitTests\mainViewMock.pas',
  userInputServiceMock in 'unitTests\userInputServiceMock.pas',
  mainViewModelMock in 'unitTests\mainViewModelMock.pas',
  imageGeneratorServiceMock in 'unitTests\imageGeneratorServiceMock.pas',
  MBC.Classes in '..\src\MBC.Classes.pas',
  guiWorkspaceMock in 'unitTests\guiWorkspaceMock.pas',
  testsUserInputService in 'unitTests\testsUserInputService.pas',
  guiStatusBarMock in 'unitTests\guiStatusBarMock.pas',
  numberMock in 'unitTests\numberMock.pas',
  testsNumber in 'unitTests\testsNumber.pas',
  imageRepositoryMock in 'unitTests\imageRepositoryMock.pas',
  testsImageGeneratorService in 'unitTests\testsImageGeneratorService.pas',
  recognitionServiceMock in 'unitTests\recognitionServiceMock.pas',
  testsRecognizerByArea in 'unitTests\testsRecognizerByArea.pas',
  reporterMock in 'unitTests\reporterMock.pas',
  testsReporter in 'unitTests\testsReporter.pas';

{$R *.res}

begin

  //TextTestRunner.RunRegisteredTests;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
  
end.

