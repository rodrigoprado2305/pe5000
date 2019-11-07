unit frmEstatisticas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Layouts;

type
  TFormEstatisticas = class(TForm)
    lytGeral: TLayout;
    btnCompartilhar: TButton;
    UserImage: TImage;
    FillRGBEffect4: TFillRGBEffect;
    lytTela: TLayout;
    recTela: TRectangle;
    lblParabens: TLabel;
    lblNome: TLabel;
    lblRespondidas1: TLabel;
    lblPergRespondidas: TLabel;
    lblAcerto1: TLabel;
    lblAcertos: TLabel;
    lblErro1: TLabel;
    lblErros: TLabel;
    imgLogo1: TImage;
    lblLinhaBot: TLabel;
    lblLinhaTop: TLabel;
    lblResultados: TLabel;
    barCabecalho: TToolBar;
    btnSair: TSpeedButton;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEstatisticas: TFormEstatisticas;

implementation

{$R *.fmx}

procedure TFormEstatisticas.btnSairClick(Sender: TObject);
begin
  Close;
end;

end.
