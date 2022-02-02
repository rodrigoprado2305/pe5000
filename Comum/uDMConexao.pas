unit uDMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDM = class(TDataModule)
    BD: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryPerguntas: TFDQuery;
    qryTemp: TFDQuery;
    FDScript: TFDScript;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure getLogin(var sNome, sEscola: String);
    procedure atualizacoesBD;
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

procedure TDM.atualizacoesBD;
var
  slScript: TStringList;
begin
  slScript := TStringList.Create;
  try
    if getVersaoBD = '1.0.0' then
    begin
      slScript.Text := // atulizando primeira vez o banco de dados, 19/04/2020
        ' update perguntas set descricao = replace(descricao, ''  '', '' ''); ' +
        ' update perguntas set descricao = replace(descricao, '' ?'', ''?''); ' +
        ' update perguntas set certa = ''650'' where perguntaid = 2871; ' +
        ' update perguntas set certa = ''30'', errada = ''25'' where perguntaid = 3184; ' +
        ' update perguntas set descricao = ''A palavra ... tem cinco letras e cinco fonemas ...'' where perguntaid = 1149; ' +
        ' update perguntas set errada = ''JILO'' where perguntaid = 3367; ' +
        ' update perguntas set descricao = ''Campinas não é uma capital, mas possui mais de 1 milhão de habitantes.'' where perguntaid = 506; ' +
        ' update perguntas set certa = ''Salá'', errada = ''Sala'' where perguntaid = 1224; ' +
        ' update perguntas set certa = ''Rodrigo Prado'', errada = ''Bill Gates'' where perguntaid = 4051; ' +
        ' update perguntas set certa = ''180'' where perguntaid = 4800; ' +
        ' update perguntas set errada = ''Morcego'' where perguntaid = 3653; ' +
        ' update perguntas set errada = ''Descartável'' where perguntaid = 4320; ' +
        ' update perguntas set descricao = ''Qual a velocidade média de um tubarão?'', certa = ''60 km/hora'', errada = ''200 km/hora'' where perguntaid = 388; ' +
        ' update perguntas set descricao = ''Qual a velocidade média de um peixe-espada?'', certa = ''95 km/hora'', errada = ''10 km/hora'' where perguntaid = 389; ' +
        ' update perguntas set certa = ''Cubo'', errada = ''Reta'' where perguntaid = 1128; ' +
        ' update perguntas set certa = ''Jogar'' where perguntaid = 1412; ' +
        ' update perguntas set certa = ''3'' where perguntaid = 1954; ' +
        ' update perguntas set certa = ''4'', errada = ''3'' where perguntaid = 2024; ' +
        ' update perguntas set certa = ''26'' where perguntaid = 914; ' +
        ' update perguntas set certa = ''2'', errada = ''0'' where perguntaid = 1004; ' +
        ' update versaobd set descricao = ''1.0.1''; ';
      try
        FDScript.ExecuteScript(slScript);
      except
        on E:Exception do
          raise Exception.Create('Erro ao atualizar o banco de dados para a versao 1.0.1: ' + E.Message);
      end;
    end
    else if getVersaoBD = '1.0.1' then
    begin
      //
    end
    else if getVersaoBD = '1.0.2' then
    begin
      //
    end;
  finally
    slScript.Free;
  end;
end;

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

  //Verifica atualizações de banco
  atualizacoesBD;
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
