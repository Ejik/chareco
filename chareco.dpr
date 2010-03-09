program chareco;

uses
  Forms,
  mainViewImpl in 'src\mainViewImpl.pas' {Form1},
  mainViewModel in 'src\mainViewModel.pas',
  mainView in 'src\mainView.pas',
  mainViewPresenter in 'src\mainViewPresenter.pas',
  mainViewPresenterImpl in 'src\mainViewPresenterImpl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
