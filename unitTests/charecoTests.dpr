//{$APPTYPE CONSOLE}
program charecoTests;

uses
  FastMM4,
  TestFrameWork,
  GUITestRunner,
  TextTestRunner,
  Forms,
  TestsMainView in 'TestsMainView.pas',
  mainViewMock in 'mainViewMock.pas';

{$R *.res}

begin

  //TextTestRunner.RunRegisteredTests;
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
  
end.

