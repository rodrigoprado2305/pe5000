program pe5000;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmLogin in 'Fontes\frmLogin.pas' {Form1},
  frmQuiz in 'Fontes\frmQuiz.pas' {Form2},
  frmEstatisticas in 'Fontes\frmEstatisticas.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
