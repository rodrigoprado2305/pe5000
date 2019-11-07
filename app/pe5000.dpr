program pe5000;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmLogin in 'Fontes\frmLogin.pas' {FormLogin},
  frmQuiz in 'Fontes\frmQuiz.pas' {FormQuiz},
  frmEstatisticas in 'Fontes\frmEstatisticas.pas' {FormEstatisticas},
  uBiblioteca in '..\Comum\uBiblioteca.pas',
  uDMConexao in '..\Comum\uDMConexao.pas' {DM: TDataModule},
  frmInformacao in 'Fontes\frmInformacao.pas' {FormInformacao};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormQuiz, FormQuiz);
  Application.CreateForm(TFormEstatisticas, FormEstatisticas);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormInformacao, FormInformacao);
  Application.Run;
end.
