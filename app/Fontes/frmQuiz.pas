unit frmQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Media, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  TFormQuiz = class(TForm)
    lytMeio: TLayout;
    lblPergunta: TLabel;
    btnResp01: TButton;
    btnResp02: TButton;
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    btnInfo: TSpeedButton;
    lblPontos: TLabel;
    MediaPlayer1: TMediaPlayer;
    rectOkErro: TRectangle;
    imgErro: TImage;
    imgOk: TImage;
    timer1: TTimer;
    rectPergunta: TRectangle;
    rectEstatisticas: TRectangle;
    lbl1: TLabel;
    lblPergRespondidas: TLabel;
    lbl2: TLabel;
    lblAcertos: TLabel;
    lbl3: TLabel;
    lblErros: TLabel;
    ToolBar1: TToolBar;
    btnSair: TSpeedButton;
    procedure btnInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timer1Timer(Sender: TObject);
    procedure btnResp01Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    iPergRespondidas, iAcertos, iErros: Integer;
    sRespClicada: String;
    procedure proximaFase;
  public
    { Public declarations }
  end;

var
  FormQuiz: TFormQuiz;

const
  NUM_FASES = 5;

implementation

uses uDMConexao, System.Math, frmInformacao, frmEstatisticas;

{$R *.fmx}

procedure TFormQuiz.btnInfoClick(Sender: TObject);
begin
  FormInformacao.show;
end;

procedure TFormQuiz.btnResp01Click(Sender: TObject);
begin
  sRespClicada := TButton(Sender).Text;
  if sRespClicada = dm.psResposta then
  begin
    imgOk.Visible := True;
    imgErro.Visible := False;
  end
  else
  begin
    imgOk.Visible := False;
    imgErro.Visible := True;
  end;
  timer1.Enabled := True;
end;

procedure TFormQuiz.btnSairClick(Sender: TObject);
begin
  FormEstatisticas.lblPergRespondidas.Text := IntToStr(iPergRespondidas);
  FormEstatisticas.lblAcertos.Text := IntToStr(iAcertos);
  FormEstatisticas.lblErros.Text := FormatFloat('0.00',(iAcertos*100)/iPergRespondidas);
  FormEstatisticas.Show;
end;

procedure TFormQuiz.FormShow(Sender: TObject);
begin
  proximaFase;
end;

procedure TFormQuiz.proximaFase;
var
  iRandomPerg: Integer;
begin
  imgOk.Visible := False;
  imgErro.Visible := False;

  iRandomPerg := RandomRange(1, 5000);

  DM.FiltraPergunta(iRandomPerg);

  lblPergunta.Text := DM.qryPerguntas.FieldByName('descricao').AsString;
  btnResp01.Text := DM.qryPerguntas.FieldByName('certa').AsString;
  btnResp02.Text := DM.qryPerguntas.FieldByName('errada').AsString;
  DM.psResposta := btnResp01.Text;
end;

procedure TFormQuiz.timer1Timer(Sender: TObject);
begin
  inc(iPergRespondidas);
  if sRespClicada = dm.psResposta then
    inc(iAcertos)
  else
    inc(iErros);
  proximaFase;
  timer1.Enabled := False;

  lblPergRespondidas.Text := IntToStr(iPergRespondidas);
  lblAcertos.Text := IntToStr(iAcertos);
  lblErros.Text := FormatFloat('0.00',(iAcertos*100)/iPergRespondidas);
  //lblErros.Text := IntToStr(iErros);
   //    FormPontuacao.lblPercAcerto.Text := FormatFloat('0.00',(iAcerto*100)/NUM_FASES);
end;

end.
