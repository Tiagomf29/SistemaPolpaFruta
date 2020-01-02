unit UEstoque;

interface

uses
  UProduto;

type

  TEstoque = class

  private
    FProduto: TProduto;
    FQuantidade: Integer;
    function getProduto: TProduto;
    function getQuantidade: Integer;
    procedure setProduto(const Value: TProduto);
    procedure setQuantidade(const Value: Integer);

  public
    property produto: TProduto read getProduto write setProduto;
    property quantidade: Integer read getQuantidade write setQuantidade;

  end;

implementation

{ TEstoque }

{ TEstoque }

function TEstoque.getProduto: TProduto;
begin
  Result := FProduto;
end;

function TEstoque.getQuantidade: Integer;
begin
  Result := FQuantidade;
end;

procedure TEstoque.setProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

procedure TEstoque.setQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

end.
