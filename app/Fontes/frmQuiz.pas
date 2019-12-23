unit frmQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Media, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts,
  FMX.Advertising, frmEntrada, System.IOUtils;

type
  TFormQuiz = class(TForm)
    lytMeio: TLayout;
    lblPergunta: TLabel;
    barCabecalho: TToolBar;
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
    BannerAd1: TBannerAd;
    lblLembrete: TLabel;
    Panel1: TPanel;
    btnFinalizar: TButton;
    btnResp01: TSpeedButton;
    btnResp02: TSpeedButton;
    chkEfeitosSonoros: TCheckBox;
    procedure btnInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timer1Timer(Sender: TObject);
    procedure btnResp01Click(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkEfeitosSonorosChange(Sender: TObject);
  private
    { Private declarations }
    iPergRespondidas, iAcertos, iAcertosSeq, iErros, iPontos, iFaseAtual: integer;
    sRespClicada: String;
    sFrases: array[0..9] of string;
    bMusica: Boolean;

    procedure proximaFase;
    procedure tocaSom(sArqNome: String);
  public
    { Public declarations }
  end;

var
  FormQuiz: TFormQuiz;

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
    tocaSom('rsrcOk');
  end
  else
  begin
    imgOk.Visible := False;
    imgErro.Visible := True;
    tocaSom('rsrcErro');
  end;
  timer1.Enabled := True;
end;

procedure TFormQuiz.chkEfeitosSonorosChange(Sender: TObject);
begin
  bMusica := not bMusica;
end;

procedure TFormQuiz.btnFinalizarClick(Sender: TObject);
begin
  DM.piPontos := iPontos;
  FormEstatisticas.lblResultados.Text := 'Você conquistou '+IntToStr(iPontos)+' pontos';
  FormEstatisticas.lblPergRespondidas.Text := IntToStr(iPergRespondidas);
  FormEstatisticas.lblAcertos.Text := IntToStr(iAcertos);
  try
    FormEstatisticas.lblErros.Text := FormatFloat('0.00',(iAcertos*100)/iPergRespondidas);
  except
    FormEstatisticas.lblErros.Text := '0.00';
  end;
  FormEstatisticas.lblNome.Text := DM.psNome;
  FormEstatisticas.lblEscola.Text := DM.psEscola;
  FormEstatisticas.Show;
  Close;
end;

procedure TFormQuiz.FormCreate(Sender: TObject);
begin
  sFrases[0]  := 'Pense na resposta...';
  sFrases[1]  := 'Leia e responda...';
  sFrases[2]  := 'Pense antes de responder...';
  sFrases[3]  := 'Responda com atenção';
  sFrases[4]  := 'Será que você sabe?';
  sFrases[5]  := 'Essa é um pouco difícil!';
  sFrases[6]  := 'Sempre que você responde... Você aprende!';
  sFrases[7]  := 'Quanto mais você responder em sequência mais pontos você ganha';
  sFrases[8]  := 'Esse jogo avalia você! Conforme você joga, pontos surpresas você recebe';
  sFrases[9]  := 'Jogue e aprenda';

  //BannerAd1.AdUnitID := 'ca-app-pub-9350000386173480/4464322998';
  bMusica := True;
end;

procedure TFormQuiz.FormShow(Sender: TObject);
begin
  iPontos := 0;
  iAcertos := 0;
  iErros := 0;
  iPergRespondidas := 0;
  iAcertosSeq := 0;
  iFaseAtual := 0;
  proximaFase;
end;

procedure TFormQuiz.proximaFase;
var
  iRandomPerg, i: Integer;
begin
  inc(iFaseAtual);
  imgOk.Visible := False;
  imgErro.Visible := False;

  i := RandomRange(0, 9);
  lblLembrete.Text := sFrases[i];

  iRandomPerg := RandomRange(1, 5000);

  DM.FiltraPergunta(iRandomPerg);

  i := Random(2)+1;

  lblPergunta.Text := DM.qryPerguntas.FieldByName('descricao').AsString;
  btnResp01.Text := DM.qryPerguntas.Fields[i].AsString;//DM.qryPerguntas.FieldByName('certa').AsString;

  if i = 1 then
    btnResp02.Text := DM.qryPerguntas.Fields[2].AsString
  else
    btnResp02.Text := DM.qryPerguntas.Fields[1].AsString;//DM.qryPerguntas.FieldByName('errada').AsString;

  DM.psResposta := DM.qryPerguntas.FieldByName('certa').AsString;//btnResp01.Text;
end;

procedure TFormQuiz.timer1Timer(Sender: TObject);
var
  iBonus: integer;
begin
  inc(iPergRespondidas);
  if sRespClicada = dm.psResposta then
  begin
    inc(iAcertos);
    inc(iAcertosSeq);
    iPontos := iPontos + iFaseAtual;
    iBonus := 0;
    case iAcertosSeq of
      5 : iBonus := 10;
      10: iBonus := 50;
      20: iBonus := 100;
      40: iBonus := 500;
      50: iBonus := 1000;
      70: iBonus := 2000;
      100 : iBonus := 5000;
      150 : iBonus := 7000;
      200 : iBonus := 15000;
    end;
    iPontos := iPontos + iBonus;
    if iBonus = 200 then
      iAcertosSeq := 0;
  end
  else
  begin
    iAcertosSeq := 0;
    inc(iErros);
  end;
  proximaFase;
  timer1.Enabled := False;

  lblPergRespondidas.Text := IntToStr(iPergRespondidas);
  lblAcertos.Text := IntToStr(iAcertos);
  lblErros.Text := FormatFloat('0.00',(iAcertos*100)/iPergRespondidas);
  lblPontos.Text := 'Você tem: '+IntToStr(iPontos)+' pontos';
  //lblErros.Text := IntToStr(iErros);
   //    FormPontuacao.lblPercAcerto.Text := FormatFloat('0.00',(iAcerto*100)/NUM_FASES);
end;

procedure TFormQuiz.tocaSom(sArqNome: String);
var
  ResStream: TResourceStream;
  sFile: string;
begin
  if bMusica then
  begin
    if sArqNome = 'rsrcOk' then
    begin
      ResStream := TResourceStream.Create(HInstance, sArqNome, RT_RCDATA);
      try
        sFile := TPath.Combine(System.IOUtils.TPath.GetDownloadsPath, 'ok.mp3');
        ResStream.Position := 0;
        ResStream.SaveToFile(sFile);
        MediaPlayer1.FileName := sFile;
        MediaPlayer1.Play;
      finally
        ResStream.Free;
      end;
    end
    else if sArqNome = 'rsrcErro' then
    begin
      ResStream := TResourceStream.Create(HInstance, sArqNome, RT_RCDATA);
      try
        sFile := TPath.Combine(System.IOUtils.TPath.GetDownloadsPath, 'erro.mp3');
        ResStream.Position := 0;
        ResStream.SaveToFile(sFile);
        MediaPlayer1.FileName := sFile;
        MediaPlayer1.Play;
      finally
        ResStream.Free;
      end;
    end;
  end;
end;

end.

