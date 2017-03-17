program eqn2;

uses
  Forms,
  main in 'main.pas' {Form1},
  about in 'about.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'EXFiP QuickNotes 2';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
