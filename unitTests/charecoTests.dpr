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
  guiWorkspaceMock in 'guiWorkspaceMock.pas';

{$R *.res}

begin

  //TextTestRunner.RunRegisteredTests;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
  
end.

