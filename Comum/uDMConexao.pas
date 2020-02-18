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
    procedure getLogin(var sNome, sEscola: String);
    { Private declarations }
  public
    { Public declarations }
    psResposta, psNome, psEscola: String;
    piPontos: integer;
    procedure filtraPergunta(iPerguntaID: Integer);
    procedure setLogin(sNome, sEscola: String);
    function getVersaoBD: String;
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

  getLogin(psNome, psEscola);
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

procedure TDM.setLogin(sNome, sEscola: String);
begin
  qryTemp.Close;
  qryTemp.SQL.Text :=
    ' update login set nome =:nome, escola =:escola ';
  qryTemp.ParamByName('nome').AsString := sNome;
  qryTemp.ParamByName('escola').AsString := sEscola;
  try
     qryTemp.ExecSQL;
  except
    on E:Exception do
      raise Exception.Create('Erro ao atualizar o login: ' + E.Message);
  end;
end;

procedure TDM.getLogin(var sNome, sEscola: String);
begin
  qryTemp.Close;
  try
    qryTemp.Open('select nome, escola from login');
  except
    on E:Exception do
      raise Exception.Create('Erro ao carregar o login: ' + E.Message);
  end;
  sNome := qryTemp.Fields[0].AsString;
  sEscola := qryTemp.Fields[1].AsString;
end;

function TDM.getVersaoBD: String;
begin
  qryTemp.Close;
  try
    qryTemp.Open('select descricao from versaobd');
  except
    on E:Exception do
      raise Exception.Create('Erro ao carregar o versão do BD: ' + E.Message);
  end;
  result := qryTemp.Fields[0].AsString;
end;

end.
