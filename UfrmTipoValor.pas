unit UfrmTipoValor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Datasnap.Provider, Data.DB, Datasnap.DBClient;

type
  TfrmTipoValor = class(TfrmCadastroPadrao)
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
  frmTipoValor: TfrmTipoValor;

implementation
uses 
  UTipoValor, UPadraoEnumeracao;

{$R *.dfm}

procedure TfrmTipoValor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmTipoValor.btnExcluirClick(Sender: TObject);
var
  tipoValor: TTipoValor;
begin
  inherited;
  if desejaExcluir then        
    begin
      tipoValor := TTipoValor.create;
      try
        tipoValor.id := CDSid.Value;
        tipoValor.excluir(tipoValor, TTabelasPadrao(TPVALOR));
        CDS.Refresh;
        edtDescricao.Text := '';
        lblValorCodigo.Caption := '';
        MessageDlg('Registro exclu�do com sucesso!', mtInformation, [mbOK], 0);
      finally
        FreeAndNil(tipoValor);
      end;
    end; 
end;

procedure TfrmTipoValor.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := True;
end;

procedure TfrmTipoValor.btnSalvarClick(Sender: TObject);
var
  tipoValor: TTipoValor;
begin
  inherited;
  tipoValor := TTipoValor.create;
  try
    tipoValor.descricao := edtDescricao.Text;
    if CadastrarNovo then
      tipoValor.cadastrar(tipoValor, TTabelasPadrao(TPVALOR))
    else
      begin
        tipoValor.id := CDSid.Value;
        tipoValor.atualizar(tipoValor, TTabelasPadrao(TPVALOR));
      end;
    CDS.Refresh;
    edtDescricao.Text := '';
    lblValorCodigo.Caption := '';
    MessageDlg('Registro Cadastrado com sucesso!', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(tipoValor);
  end;
end;
procedure TfrmTipoValor.carregaDadosGrid;
begin
    if CDSid.Value <> 0 then
    begin
      lblValorCodigo.Caption := IntToStr(CDSid.Value);
      edtDescricao.Text := CDSdescricao.Value;
    end;
end;

procedure TfrmTipoValor.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  carregaDadosGrid();
end;

end.



