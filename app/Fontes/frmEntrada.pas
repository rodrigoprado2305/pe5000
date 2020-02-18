unit frmEntrada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts,
  FMX.Effects, FMX.Filter.Effects;

type
  TFormEntrada = class(TForm)
    VertScrollBox1: TVertScrollBox;
    lytAcessar: TLayout;
    edtNome: TEdit;
    imgNome: TImage;
    lytHeader: TLayout;
    lytLogo2: TLayout;
    LogoCircle: TCircle;
    imgLogo2: TImage;
    imgLogo1: TImage;
    btnAcessar: TButton;
    lytEspaco: TLayout;
    edtEscola: TEdit;
    Image1: TImage;
    StyleBook1: TStyleBook;
    lblVersaoBD: TLabel;
    procedure btnAcessarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgLogo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEntrada: TFormEntrada;

implementation

uses uDMConexao, FrmQuiz;

{$R *.fmx}

procedure TFormEntrada.btnAcessarClick(Sender: TObject);
begin
  if Trim(edtNome.Text) = '' then
  begin
    showmessage('Informe o nome do jogador para continuar!');
    exit;
  end;

  if Trim(edtEscola.Text) = '' then
  begin
    showmessage('Informe o nome de sua escola para continuar!');
    exit;
  end;

  if ((edtNome.Text <> DM.psNome) or (edtEscola.Text <> DM.psEscola)) then
    DM.setLogin(Trim(edtNome.Text), Trim(edtEscola.Text));

  DM.psNome := Trim(edtNome.Text);
  DM.psEscola := Trim(edtEscola.Text);

  FormQuiz.lblPergRespondidas.Text := '0';
  FormQuiz.lblAcertos.Text := '0';
  FormQuiz.lblErros.Text := '0.00';
  FormQuiz.lblPontos.Text := 'Você tem: 0 pontos';
  FormQuiz.Show;
end;

procedure TFormEntrada.FormShow(Sender: TObject);
begin
  edtNome.Text := DM.psNome;
  edtEscola.Text := DM.psEscola;
  lblVersaoBD.Visible := False;
  lblVersaoBD.Text := DM.getVersaoBD;
end;

procedure TFormEntrada.imgLogo1Click(Sender: TObject);
begin
 lblVersaoBD.Visible := True;
end;

end.
