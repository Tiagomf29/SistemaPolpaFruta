unit UProduto;

interface

uses
  UBaseCadastro, System.Generics.Collections, UTipoProduto, USabor, UPolpa, ZDataSet, UDM;

type

  TProduto = class(TBaseCadastro)

  private
    FtipoProduto: TTipoProduto;
    FSabor: TSabor;
    FTipoPolpa: TPolpa;
    FPeso: Double;
    FEstoqueMinimo: Integer;
    function getPeso: Double;
    function getSabor: TSabor;
    function getTipoPolpa: TPolpa;
    function getTipoProduto: TTipoProduto;
    procedure setPeso(const Value: Double);
    procedure setSabor(const Value: TSabor);
    procedure setTipoPolpa(const Value: TPolpa);
    procedure setTipoProduto(const Value: TTipoProduto);
    function getEstoqueMinimo: Integer;
    procedure setEstoqueMinimo(const Value: Integer);

  public
    property tipoProduto: TTipoProduto read getTipoProduto write setTipoProduto;
    property sabor: TSabor read getSabor write setSabor;
    property tipoPolpa: TPolpa read getTipoPolpa write setTipoPolpa;
    property peso: Double read getPeso write setPeso;
    property estoqueMinimo: Integer read getEstoqueMinimo
      write setEstoqueMinimo;

    procedure cadastrar(produto : TProduto);
    procedure atualizar(produto : TProduto);
    procedure excluir(produto : TProduto);
      
    function consultaProdutoId(id: Integer): TObjectList<TProduto>;

  end;

implementation
  uses
    System.SysUtils;

{ TProduto }

procedure TProduto.atualizar(produto: TProduto);
var
  qry : TZQuery;
begin

  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('update tbproduto set id_tpproduto =:id_tpproduto,');
    qry.SQL.Add('descricao =:descricao,');
    qry.SQL.Add('peso =:peso,');
    qry.SQL.Add('id_tbsabor =:id_tbsabor,');
    qry.SQL.Add('id_tppolpa =:id_tppolpa,');
    qry.SQL.Add('estoque_minimo =:estoque_minimo ');
    qry.SQL.Add('where id =:id');
  
    qry.ParamByName('id_tpproduto').AsInteger := produto.tipoProduto.id;
    qry.ParamByName('descricao').AsString := produto.descricao;
    qry.ParamByName('peso').AsFloat := produto.peso;
    qry.ParamByName('id_tbsabor').AsInteger := produto.sabor.id;
    qry.ParamByName('id_tppolpa').AsInteger := produto.tipoPolpa.id;
    qry.ParamByName('estoque_minimo').AsInteger := produto.estoqueMinimo;
    qry.ParamByName('id').AsInteger := produto.id;

    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;
  
end;

procedure TProduto.cadastrar(produto: TProduto);
var
  qry : TZQuery;
begin
  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;

  qry.Close;
  qry.SQL.Clear;
  try
    qry.SQL.Add('insert into tbproduto');
    qry.SQL.Add('(');  
    qry.SQL.Add('id_tpproduto,');
    qry.SQL.Add('descricao,');  
    qry.SQL.Add('peso,');   
    qry.SQL.Add('id_tbsabor,');     
    qry.SQL.Add('id_tppolpa,'); 
    qry.SQL.Add('estoque_minimo');         
    qry.SQL.Add(')');     
    qry.SQL.Add('values'); 
    qry.SQL.Add('(');         
    qry.SQL.Add(':id_tpproduto,');     
    qry.SQL.Add(':descricao,');     
    qry.SQL.Add(':peso,');     
    qry.SQL.Add(':id_tbsabor,');     
    qry.SQL.Add(':id_tppolpa,');     
    qry.SQL.Add(':estoque_minimo');     
    qry.SQL.Add(')');

    qry.ParamByName('id_tpproduto').AsInteger := produto.tipoProduto.id;
    qry.ParamByName('descricao').AsString := produto.descricao;
    qry.ParamByName('peso').AsFloat := produto.peso;
    qry.ParamByName('id_tbsabor').AsInteger := produto.sabor.id;
    qry.ParamByName('id_tppolpa').AsInteger := produto.tipoPolpa.id;
    qry.ParamByName('estoque_minimo').AsInteger := produto.estoqueMinimo;   

    qry.ExecSQL;    
  finally
    FreeAndNil(qry);
  end;
end;

function TProduto.consultaProdutoId(id: Integer): TObjectList<TProduto>;
var
  lista: TObjectList<TProduto>;
  produto: TProduto;
begin

  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add
    ('select  b.id,concat(b.descricao," - ",d.descricao," - ",e.descricao)as descricao');
  qry.SQL.Add('from tbproduto b ');
  qry.SQL.Add('inner join tbsabor d on d.id = b.id_tbsabor ');
  qry.SQL.Add('inner join tppolpa e on e.id = b.id_tppolpa ');
  qry.SQL.Add('where b.id=:id');
  qry.ParamByName('id').AsInteger := id;
  qry.Open;

  lista := TObjectList<TProduto>.Create;

  while not qry.Eof do
    begin
      produto := TProduto.Create;
      produto.id := qry.FieldByName('id').AsInteger;
      produto.descricao := qry.FieldByName('descricao').AsString;
      lista.Add(produto);
      qry.Next;
    end;

  Result := lista;

end;

procedure TProduto.excluir(produto: TProduto);
var
  qry : TZQuery;
begin

  qry := TZQuery.Create(nil);                  
  qry.Connection := DM.conexao;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('delete from tbproduto where id=:id');
    qry.ParamByName('id').AsInteger := produto.id;
    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;  
end;

function TProduto.getEstoqueMinimo: Integer;
begin
  Result := FEstoqueMinimo;
end;

function TProduto.getPeso: Double;
begin
  Result := FPeso;
end;

function TProduto.getSabor: TSabor;
begin
  Result := FSabor;
end;

function TProduto.getTipoPolpa: TPolpa;
begin
  Result := FTipoPolpa;
end;

function TProduto.getTipoProduto: TTipoProduto;
begin
  Result := FtipoProduto;
end;

procedure TProduto.setEstoqueMinimo(const Value: Integer);
begin
  FEstoqueMinimo := Value;
end;

procedure TProduto.setPeso(const Value: Double);
begin
  FPeso := Value;
end;

procedure TProduto.setSabor(const Value: TSabor);
begin
  FSabor := Value;
end;

procedure TProduto.setTipoPolpa(const Value: TPolpa);
begin
  FTipoPolpa := Value;
end;

procedure TProduto.setTipoProduto(const Value: TTipoProduto);
begin
  FtipoProduto := Value;
end;

end.
