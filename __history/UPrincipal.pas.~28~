unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ImgList, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    ipodeProduto1: TMenuItem;
    N3: TMenuItem;
    ipodePOlpa1: TMenuItem;
    N4: TMenuItem;
    ipodeValor1: TMenuItem;
    N5: TMenuItem;
    Valor1: TMenuItem;
    Movimentao1: TMenuItem;
    Entrada1: TMenuItem;
    N6: TMenuItem;
    Sada1: TMenuItem;
    N7: TMenuItem;
    Perda1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Utilitrios1: TMenuItem;
    Exportao1: TMenuItem;
    Arquivos1: TMenuItem;
    Relatrios1: TMenuItem;
    Sabor1: TMenuItem;
    N10: TMenuItem;
    Produtos1: TMenuItem;
    N11: TMenuItem;
    ipodepolpas1: TMenuItem;
    N12: TMenuItem;
    iposdevalor1: TMenuItem;
    N13: TMenuItem;
    Entradas1: TMenuItem;
    N14: TMenuItem;
    Vendas1: TMenuItem;
    N15: TMenuItem;
    Perdas1: TMenuItem;
    ImageList: TImageList;
    procedure N1Click(Sender: TObject);
    procedure ipodeProduto1Click(Sender: TObject);
    procedure ipodeValor1Click(Sender: TObject);
    procedure ipodePOlpa1Click(Sender: TObject);
    procedure Valor1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation
uses
  USabor, UfrmSabor, UfrmTipoProduto, UFrmTipoValor, UFrmPolpa, UFrmValor, UFrmProduto;

{$R *.dfm}

procedure TfrmPrincipal.ipodePOlpa1Click(Sender: TObject);
begin
  try
    frmPolpa:= TfrmPolpa.Create(nil);
    frmPolpa.ShowModal;
  finally
    FreeAndNil(frmPolpa);
  end;
end;

procedure TfrmPrincipal.ipodeProduto1Click(Sender: TObject);
begin
  try
    frmTipoProduto := TfrmTipoProduto.Create(nil);
    frmTipoProduto.ShowModal;
  finally
    FreeAndNil(frmTipoProduto);
  end;
end;

procedure TfrmPrincipal.ipodeValor1Click(Sender: TObject);
begin
  try
    frmTipoValor := TfrmTipoValor.Create(nil);
    frmTipoValor.ShowModal;
  finally
    FreeAndNil(frmTipoValor);
  end;
end;

procedure TfrmPrincipal.N1Click(Sender: TObject);
begin
  try
    frmSabor := TfrmSabor.Create(nil);
    frmSabor.ShowModal;
  finally
    FreeAndNil(frmSabor);
  end;
end;

procedure TfrmPrincipal.N2Click(Sender: TObject);
begin
  try
    frmProduto := TfrmProduto.Create(nil);
    frmProduto.ShowModal;
  finally
    FreeAndNil(frmProduto);
  end;
end;

procedure TfrmPrincipal.Valor1Click(Sender: TObject);
begin
  try
    FrmValor := TfrmValor.create(nil);
    FrmValor.showmodal;
  finally
    FreeAndNil(FrmValor);
  end;
end;

end.
