unit UValor;

interface

uses
  UProduto, UTipoValor, System.Generics.Collections, ZDataSet;

type

  TValor = class

  private
    FId: Integer;
    FProduto: TProduto;
    FTpValor: TTipoValor;
    FData: TDate;
    FValor: Double;
    function getData: TDate;
    function getId: Integer;
    function getProduto: TProduto;
    procedure setData(const Value: TDate);
    procedure setId(const Value: Integer);
    procedure setProduto(const Value: TProduto);
    function getValor: Double;
    procedure setValor(const Value: Double);
    function getTipoValor: TTipoValor;
    procedure setTipoValor(const Value: TTipoValor);

  public
    property id: Integer read getId write setId;
    property produto: TProduto read getProduto write setProduto;
    property tipoValor: TTipoValor read getTipoValor write setTipoValor;
    property data: TDate read getData write setData;
    property valor: Double read getValor write setValor;

    procedure cadastrar(obj: TValor);
    procedure atualizar(obj: TValor);
    procedure excluir(obj: TValor);

    function consultar(tabela: TValor): TObjectList<TValor>;
    function verificaDuplicidadeLancamento(valor : Tvalor; alterando : boolean): Integer;

  end;

implementation

uses
  UDM, System.SysUtils;

{ TValor }

procedure TValor.atualizar(obj: TValor);
var
  qry: TZQuery;
begin
  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('update tbvalor set ');
    qry.SQL.Add('id_tbproduto =:id_tbproduto,');
    qry.SQL.Add('id_tpvalor =:id_tpvalor,');
    qry.SQL.Add('data=:data,');
    qry.SQL.Add('valor =:valor');
    qry.SQL.Add('where id=:id');

    qry.ParamByName('id_tbproduto').AsInteger := obj.FProduto.id;
    qry.ParamByName('id_tpvalor').AsInteger := obj.FTpValor.id;
    qry.ParamByName('data').AsDate := FData;
    qry.ParamByName('valor').AsFloat := FValor;
    qry.ParamByName('id').AsInteger := FId;

    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TValor.cadastrar(obj: TValor);
var
  qry: TZQuery;
begin
  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;
  try
    qry.Close;
    qry.SQL.Clear;

    qry.SQL.Add('insert into tbvalor (id_tbproduto,id_tpvalor,data,valor)');
    qry.SQL.Add('values');
    qry.SQL.Add('(:id_tbproduto,:id_tpvalor,:data,:valor)');
    qry.ParamByName('id_tbproduto').AsInteger := obj.produto.id;
    qry.ParamByName('id_tpvalor').AsInteger := obj.tipoValor.id;
    qry.ParamByName('data').AsDate := obj.FData;
    qry.ParamByName('valor').AsFloat := obj.valor;

    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;
end;

function TValor.consultar(tabela: TValor): TObjectList<TValor>;
var
  lista: TObjectList<TValor>;
  qry: TZQuery;
  valor: TValor;
begin

  lista := TObjectList<TValor>.Create;

  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;
  try
    qry.Close;
    qry.SQL.Clear;

    qry.SQL.Add('select * from tvalor');
    qry.Open;

    while not qry.Eof do
      begin

        valor := TValor.Create;

        valor.FId := qry.FieldByName('id').AsInteger;
        valor.FProduto.id := qry.FieldByName('id_tbproduto').AsInteger;
        valor.FTpValor.id := qry.FieldByName('id_tpvalor').AsInteger;
        valor.FData := qry.FieldByName('data').AsDateTime;
        valor.FValor := qry.FieldByName('valor').AsFloat;

        lista.Add(valor);
      end;
  finally
    FreeAndNil(qry);
  end;

  Result := lista;

end;

procedure TValor.excluir(obj: TValor);
var
  qry: TZQuery;
begin
  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;
  try
    qry.Close;
    qry.SQL.Clear;

    qry.SQL.Add('delete from tbvalor where id=:id');
    qry.ParamByName('id').AsInteger := obj.FId;

    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;
end;

function TValor.getData: TDate;
begin
  Result := FData;
end;

function TValor.getId: Integer;
begin
  Result := FId;
end;

function TValor.getProduto: TProduto;
begin
  Result := FProduto;
end;

function TValor.getTipoValor: TTipoValor;
begin
  Result := FTpValor;
end;

function TValor.getValor: Double;
begin
  Result := FValor;
end;

procedure TValor.setData(const Value: TDate);
begin
  FData := Value;
end;

procedure TValor.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TValor.setProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TValor.setTipoValor(const Value: TTipoValor);
begin
  FTpValor := Value;
end;

procedure TValor.setValor(const Value: Double);
begin
  FValor := Value;
end;

function TValor.verificaDuplicidadeLancamento(valor : Tvalor; alterando : boolean): Integer;
var
  qtde : Integer;
  qry : TZQuery;
begin

  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;
  
  try 
    qry.close;
    qry.sql.clear;
    qry.SQL.Add('select count(*)as qtde from tbvalor a ');
    qry.SQL.Add('where id_tbproduto =:produto ');
    qry.SQL.Add('and id_tpvalor =:tipoValor ');
    qry.SQL.Add('and data =:data');

    if alterando then
      qry.SQL.Add('and id <> :id');

    qry.ParamByName('produto').AsInteger := valor.FProduto.id;
    qry.ParamByName('tipoValor').AsInteger := valor.FTpValor.id;
    qry.ParamByName('data').AsDate := valor.data;

    if alterando then
      qry.ParamByName('id').AsInteger := valor.id;

    qry.Open;
    
    qtde := qry.FieldByName('qtde').AsInteger;
  
    
  finally
    FreeAndNil(qry);
  end;

  Result := qtde;
    
end;

end.
