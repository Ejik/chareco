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
  mainViewModel in '..\src\mainViewModel.pas';

{$R *.res}

begin

  //TextTestRunner.RunRegisteredTests;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
  
end.

