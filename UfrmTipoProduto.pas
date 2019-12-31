unit UfrmTipoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Datasnap.Provider, Data.DB, Datasnap.DBClient,UPadraoEnumeracao;

type
  TfrmTipoProduto = class(TfrmCadastroPadrao)
    CDSid: TSmallintField;
    CDSdescricao: TWideStringField;
    procedure btnInserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
  var
    CadastrarNovo: boolean;
  procedure carregaDadosGrid();  
  public
    { Public declarations }
  end;

var
  frmTipoProduto: TfrmTipoProduto;

implementation
uses
  UTipoProduto;
{$R *.dfm}

procedure TfrmTipoProduto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmTipoProduto.btnExcluirClick(Sender: TObject);
var
  tipoProduto: TTipoProduto;
begin
  inherited;
  if desejaExcluir then        
    begin
      tipoProduto := TTipoProduto.create;
      try
        tipoProduto.id := CDSid.Value;
        tipoProduto.excluir(tipoProduto, TTabelasPadrao(TPPRODUTO));
        CDS.Refresh;
        edtDescricao.Text := '';
        lblValorCodigo.Caption := '';
        MessageDlg('Registro exclu�do com sucesso!', mtInformation, [mbOK], 0);
      finally
        FreeAndNil(tipoProduto);
      end;
    end; 
end;

procedure TfrmTipoProduto.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := True;
end;

procedure TfrmTipoProduto.btnSalvarClick(Sender: TObject);
var
  tipoProduto: TTipoProduto;
begin
  inherited;
  tipoProduto := TTipoProduto.create;
  try
    tipoProduto.descricao := edtDescricao.Text;
    if CadastrarNovo then
      tipoProduto.cadastrar(tipoProduto, TTabelasPadrao(TPPRODUTO))
    else
      begin
        tipoProduto.id := CDSid.Value;
        tipoProduto.atualizar(tipoProduto, TTabelasPadrao(TPPRODUTO));
      end;
    CDS.Refresh;
    edtDescricao.Text := '';
    lblValorCodigo.Caption := '';
    MessageDlg('Registro Cadastrado com sucesso!', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(tipoProduto);
  end;
end;

procedure TfrmTipoProduto.carregaDadosGrid;
begin
    if CDSid.Value <> 0 then
    begin
      lblValorCodigo.Caption := IntToStr(CDSid.Value);
      edtDescricao.Text := CDSdescricao.Value;
    end;
end;

procedure TfrmTipoProduto.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  carregaDadosGrid();
end;

end.



