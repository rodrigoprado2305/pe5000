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
    procedure btnAcessarClick(Sender: TObject);
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

  DM.psNome := Trim(edtNome.Text);
  DM.psEscola := Trim(edtEscola.Text);

  FormQuiz.lblPergRespondidas.Text := '0';
  FormQuiz.lblAcertos.Text := '0';
  FormQuiz.lblErros.Text := '0.00';
  FormQuiz.lblPontos.Text := 'Voc� tem: 0 pontos';
  FormQuiz.Show;
end;

end.
