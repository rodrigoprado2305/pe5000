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
    ToolBar1: TToolBar;
    lblEscola: TLabel;
    Button1: TButton;
    procedure btnCompartilharClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEstatisticas: TFormEstatisticas;

implementation

uses
  {$IFDEF ANDROID}
  FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText,
  Androidapi.Jni.Net, Androidapi.Jni.JavaTypes, idUri, Androidapi.Jni,
  Androidapi.JNIBridge, Androidapi.Helpers,
  FMX.Platform.Android, AndroidApi.Jni.App, AndroidAPI.jni.OS,
  {$ENDIF}
  FrmQuiz, System.IOUtils, uDMConexao;

{$R *.fmx}

procedure TFormEstatisticas.btnCompartilharClick(Sender: TObject);
var
{$IFDEF ANDROID}
  IntentWhats : JIntent;
  IntentWhatsApp: JIntent;
  FileUri: Jnet_Uri;
  lst: JArrayList;
{$ENDIF}
  img: TBitmap;
  sMensagem: String;
begin
  sMensagem := 'Acesse o site: http://www.projetoeducando.com.br  ';
  sMensagem := 'O Jogador: '+DM.psNome+' - conquistou '+IntToStr(DM.piPontos)+' pontos '+sLineBreak+sMensagem;

  img := lytTela.MakeScreenshot;

  try
    img.SaveToFile(TPath.combine(TPath.GetDownloadsPath, 'screenshot_temp.jpg'));
  except
     on E : Exception do
     begin
       ShowMessage('Erro ao salvar a imagem da pontuação: '+E.Message);
     end;
  end;

  {$IFDEF ANDROID}
  lst:= TJArrayList.Create;

  FileUri := TJNet_Uri.JavaClass.fromFile(TJFile.JavaClass.init(StringToJString(system.IOUtils.TPath.GetDownloadsPath + '/screenshot_temp.jpg')));

  lst.add(0,FileUri);

  IntentWhatsApp := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
  IntentWhatsApp.setType(StringToJString('text/plain'));
  IntentWhatsApp.putExtra(TJIntent.JavaClass .EXTRA_TEXT,StringToJString(sMensagem));

  IntentWhatsApp.setType(StringToJString('image/jpg'));
  IntentWhatsApp.putParcelableArrayListExtra(TJIntent.JavaClass.EXTRA_STREAM,lst);
  IntentWhatsApp.setPackage(StringToJString('com.whatsapp'));

  SharedActivity.startActivity(IntentWhatsApp);
  {$ENDIF}
  close;
end;

procedure TFormEstatisticas.Button1Click(Sender: TObject);
begin
  FormQuiz.lblPergRespondidas.Text := '0';
  FormQuiz.lblAcertos.Text := '0';
  FormQuiz.lblErros.Text := '0.00';
  FormQuiz.lblPontos.Text := 'Você tem: 0 pontos';
  FormQuiz.Show;
  close;
end;

end.
