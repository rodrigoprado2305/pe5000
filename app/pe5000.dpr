program pe5000;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmEntrada in 'Fontes\frmEntrada.pas' {FormEntrada},
  frmQuiz in 'Fontes\frmQuiz.pas' {FormQuiz},
  frmEstatisticas in 'Fontes\frmEstatisticas.pas' {FormEstatisticas},
  uBiblioteca in '..\Comum\uBiblioteca.pas',
  uDMConexao in '..\Comum\uDMConexao.pas' {DM: TDataModule},
  frmInformacao in 'Fontes\frmInformacao.pas' {FormInformacao};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormEntrada, FormEntrada);
  Application.CreateForm(TFormQuiz, FormQuiz);
  Application.CreateForm(TFormEstatisticas, FormEstatisticas);
  Application.CreateForm(TFormInformacao, FormInformacao);
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.Run;
end.



