unit UEntrada;

interface

uses
  UProduto, UDM, ZDataSet, System.Generics.Collections, System.SysUtils;

type

  TEntrada = class 

  private
    FId: Integer;
    FProduto: TProduto;
    FDataHora: TDateTime;
    FQuantidade: Integer;
    FValorUnitario : Double;
    function getDataHora: TDateTime;
    function getId: Integer;
    function getProduto: TProduto;
    function getQuantidade: Integer;
    procedure setId(const Value: Integer);
    procedure setProduto(const Value: TProduto);
    procedure setQuantidade(const Value: Integer);
    procedure setDataHora(const Value: TDateTime);
    function getValorUnitario: Double;
    procedure setValorUnitario(const Value: Double);

  public
    property id: Integer read getId write setId;
    property produto: TProduto read getProduto write setProduto;
    property dataHora: TDateTime read getDataHora write setDataHora;
    property quantidade: Integer read getQuantidade write setQuantidade;
    property valorUnitario : Double read getValorUnitario write setValorUnitario;
    procedure finalizarEnrada(obj : TObjectList<TEntrada>);

  end;

implementation

{ TEntrada }

procedure TEntrada.finalizarEnrada(obj: TObjectList<TEntrada>);
var
  qry : TZQuery;
  i   : Integer;
begin

  qry := TZQuery.Create(nil);
  qry.Connection := DM.conexao;
  qry.Close;

  for i := 0 to obj.Count-1 do
    begin

        qry.SQL.Clear;       
        qry.SQL.Add('insert into tbentrada');
        qry.SQL.Add('(');
        qry.SQL.Add('id_tbproduto,');
        qry.SQL.Add('data_hora,');
        qry.SQL.Add('quantidade,');
        qry.SQL.Add('valor_unitario');        
        qry.SQL.Add(')');
        qry.SQL.Add('values');
        qry.SQL.Add('(');
        qry.SQL.Add(':id_tbproduto,');
        qry.SQL.Add(':data_hora,');
        qry.SQL.Add(':quantidade,');
        qry.SQL.Add(':valor_unitario');        
        qry.SQL.Add(')');      
    
        qry.ParamByName('id_tbproduto').AsInteger := obj.Items[i].FProduto.id;
        qry.ParamByName('data_hora').AsDateTime := obj.Items[i].dataHora;
        qry.ParamByName('quantidade').AsInteger := obj.Items[i].quantidade;
        qry.ParamByName('valor_unitario').AsFloat := obj.Items[i].valorUnitario;        

        qry.ExecSQL;               
    end;    
      
end;

function TEntrada.getDataHora: TDateTime;
begin
  Result := FDataHora;
end;

function TEntrada.getId: Integer;
begin
  Result := FId;
end;

function TEntrada.getProduto: TProduto;
begin
  Result := FProduto;
end;

function TEntrada.getQuantidade: Integer;
begin
  Result := FQuantidade;
end;

function TEntrada.getValorUnitario: Double;
begin
  Result := FValorUnitario;
end;

procedure TEntrada.setDataHora(const Value: TDateTime);
begin
  FDataHora := Value;
end;

procedure TEntrada.setId(const Value: Integer);
begin
  FId := Value;
end;

procedure TEntrada.setProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TEntrada.setQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

procedure TEntrada.setValorUnitario(const Value: Double);
begin
   FValorUnitario := Value;
end;

end.
