//{$APPTYPE CONSOLE}
program charecoTests;

uses
  FastMM4,
  TestFrameWork,
  GUITestRunner,
  TextTestRunner,
  Forms,
  TestsMainViewPresenter in 'TestsMainViewPresenter.pas',
  mainViewMock in 'mainViewMock.pas',
  userInputServiceMock in 'userInputServiceMock.pas',
  mainViewModelMock in 'mainViewModelMock.pas',
  imageGeneratorServiceMock in 'imageGeneratorServiceMock.pas',
  MBC.Classes in '..\src\MBC.Classes.pas',
  guiWorkspaceMock in 'guiWorkspaceMock.pas',
  testsUserInputService in 'testsUserInputService.pas',
  guiStatusBarMock in 'guiStatusBarMock.pas',
  numberMock in 'numberMock.pas',
  testsNumber in 'testsNumber.pas',
  imageRepositoryMock in 'imageRepositoryMock.pas',
  testsImageGeneratorService in 'testsImageGeneratorService.pas',
  recognitionServiceMock in 'recognitionServiceMock.pas',
  testsRecognizerByArea in 'testsRecognizerByArea.pas',
  reporterMock in 'reporterMock.pas',
  testsReporter in 'testsReporter.pas';

{$R *.res}

begin

  //TextTestRunner.RunRegisteredTests;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
  
end.

