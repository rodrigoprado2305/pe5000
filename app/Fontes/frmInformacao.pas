unit frmInformacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, frmEntrada,
  FMX.ScrollBox, FMX.Memo;

type
  TFormInformacao = class(TForm)
    recTela: TRectangle;
    Layout1: TLayout;
    lblNomeJogador: TLabel;
    imgLogo: TImage;
    Rectangle2: TRectangle;
    barCabecalho: TToolBar;
    btnVoltar: TSpeedButton;
    Memo1: TMemo;
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
