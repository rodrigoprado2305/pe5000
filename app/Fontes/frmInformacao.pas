unit frmInformacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFormInformacao = class(TForm)
    recTela: TRectangle;
    Layout1: TLayout;
    lblNomeJogador: TLabel;
    imgLogo: TImage;
    Rectangle2: TRectangle;
    lblPergunta: TLabel;
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInformacao: TFormInformacao;

implementation

{$R *.fmx}

procedure TFormInformacao.btnVoltarClick(Sender: TObject);
begin
  close;
end;

end.
