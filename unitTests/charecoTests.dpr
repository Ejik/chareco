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
  testsRecognitionService in '..\src\testsRecognitionService.pas',
  imageRepositoryMock in 'imageRepositoryMock.pas',
  testsImageGeneratorService in 'testsImageGeneratorService.pas';

{$R *.res}

begin

  //TextTestRunner.RunRegisteredTests;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
  
end.

