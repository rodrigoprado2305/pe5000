unit frmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormLogin = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses frmQuiz;

{$R *.fmx}

procedure TFormLogin.Button1Click(Sender: TObject);
begin
  FormQuiz.lblPergRespondidas.Text := '0';
  FormQuiz.lblAcertos.Text := '0';
  FormQuiz.lblErros.Text := '0.00';
  FormQuiz.lblPontos.Text := 'Você tem: 0 pontos';
  FormQuiz.Show;
end;

end.
