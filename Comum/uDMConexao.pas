unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    BD: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryPerguntas: TFDQuery;
    qryTemp: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    psResposta, psNome, psEscola: String;
    piPontos: integer;
    procedure filtraPergunta(iPerguntaID: Integer);
  end;

var
  DM: TDM;

implementation

uses uBiblioteca;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  BD.Params.Clear;
  BD.Params.Values['DriverID'] := 'SQLite';
  BD.Params.Add('Database='+fnCaminhoBD);

  try
    BD.Connected := True;
  except
    on E:Exception do
      raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;

  try
    //qryPerguntas.Close;
    //qryPerguntas.Open('select perguntaid, descricao, certa, errada from perguntas');
  except
    on E:Exception do
      raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;

end;

procedure TDM.FiltraPergunta(iPerguntaID: Integer);
begin
  qryPerguntas.Close;
  qryPerguntas.SQL.Text :=
    'select descricao, certa, errada from perguntas ' +
    'where perguntaid =:perguntaid ';
  qryPerguntas.ParamByName('perguntaid').AsInteger := iPerguntaID;
  qryPerguntas.Open;
end;

end.
