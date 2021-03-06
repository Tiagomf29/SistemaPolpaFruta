unit UfrmValor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Datasnap.Provider, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmValor = class(TfrmCadastroPadrao)
    Label1: TLabel;
    edtCodigo: TEdit;
    btnPesquisa: TBitBtn;
    edtNomeProduto: TEdit;
    Label2: TLabel;
    cbxTipoValor: TComboBox;
    Label3: TLabel;
    mEData: TMaskEdit;
    Label4: TLabel;
    mEValor: TMaskEdit;
    CDSid: TIntegerField;
    CDSidProduto: TIntegerField;
    CDSdescricao: TWideStringField;
    CDSidTpProduto: TSmallintField;
    CDStpProduto: TWideStringField;
    CDSdata: TDateField;
    CDSvalor: TFloatField;
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure statusBotoesInsercao();override;
    procedure statusBotoesNaoInsercao();override;
    procedure validacaoPadrao();override;
    procedure carregaComboTpValor();
    procedure limparCampos();
    procedure carregaDadosGrid();
  var
    CadastrarNovo: boolean;    
  public
    { Public declarations }
  end;

var
  frmValor: TfrmValor;

implementation
uses
 UFrmPesquisaProdutos, UValor, UProduto, UTipoValor, UPadraoEnumeracao,UGenericRecord;

{$R *.dfm}

procedure TfrmValor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmValor.btnCancelarClick(Sender: TObject);
begin
  inherited;
  limparCampos();
end;

procedure TfrmValor.btnExcluirClick(Sender: TObject);
var
  valor : TValor;
begin
  inherited;
  if desejaExcluir then        
    begin
      valor := TValor.create;
      try
        valor.id := CDSid.Value;
        valor.excluir(valor);
        CDS.Refresh;
        limparCampos();
        MessageDlg('Registro exclu�do com sucesso!', mtInformation, [mbOK], 0);
      finally
        FreeAndNil(valor);
      end;
    end;    
end;

procedure TfrmValor.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := True;
  limparCampos();
end;

procedure TfrmValor.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  try
    frmPesquisaProdutos := tfrmPesquisaProdutos.create(nil);
    frmPesquisaProdutos.ShowModal;
    edtCodigo.Text := IntToStr(T_TransporteDadosForm.FId);
  finally
    FreeAndNil(frmPesquisaProdutos);
  end;
  
end;

procedure TfrmValor.btnSalvarClick(Sender: TObject);
var
  valor: TValor;
  produto : TProduto;
  tipoValor : TTipoValor; 
begin
  inherited;

  valor := TValor.create;
  produto := TProduto.create;
  tipoValor := TTipoValor.create;

  try
              
    produto.id := StrToInt(edtCodigo.Text);
    valor.produto := produto;
    tipoValor.id := Integer(cbxTipoValor.Items.Objects[cbxTipoValor.ItemIndex]);
    valor.tipoValor := tipoValor;
    valor.data := StrToDate(mEData.Text);
    valor.valor := StrToFloat(mEValor.Text);
    
    if CadastrarNovo then
      begin
        if valor.verificaDuplicidadeLancamento(valor,False) > 0 then
          begin
            MessageDlg('Valor j� cadastrado. Verifique!', mtInformation,[mbOK],0);
            statusBotoesInsercao;
            Abort;
          end;
      valor.cadastrar(valor)
      end
    else
      begin
        valor.id := CDSid.Value;
        if valor.verificaDuplicidadeLancamento(valor,True) > 0 then
          begin
            MessageDlg('Valor j� cadastrado. Verifique!', mtInformation,[mbOK],0);
            Abort;
          end;
        valor.atualizar(valor);
      end;
    CDS.Refresh;    
    lblValorCodigo.Caption := '';
    statusBotoesNaoInsercao();
    limparCampos();
    MessageDlg('Registro Cadastrado com sucesso!', mtInformation, [mbOK], 0);
    
  finally
    FreeAndNil(valor);    
  end;
      
end;

procedure TfrmValor.carregaComboTpValor;
var
  tipoValor : TTipoValor;
  i: Integer;
begin
  tipoValor := TTipoValor.create;
  for i :=0 to tipoValor.consultar(TTabelasPadrao(TPVALOR)).Count -1 do
    begin      
      tipoValor.id := tipoValor.consultar(TTabelasPadrao(TPVALOR)).Items[i].id;
      tipoValor.descricao := tipoValor.consultar(TTabelasPadrao(TPVALOR)).Items[i].descricao;
      cbxTipoValor.Items.AddObject(tipoValor.descricao,TTipoValor(tipoValor.id));        
    end;      
end;

procedure TfrmValor.carregaDadosGrid;
var
  i : Integer;
  tipoValor : TTipoValor;
  
begin
  if CDSid.Value <> 0 then
    begin
      lblValorCodigo.Caption := IntToStr(CDSid.Value);
      edtCodigo.Text := IntToStr(CDSidProduto.Value);
      edtNomeProduto.Text := CDSdescricao.Value;
      tipoValor :=TTipoValor.create;
      for i := 0 to tipoValor.consultar(TPVALOR).Count-1 do
        begin
          if  (tipoValor.consultar(TPVALOR).Items[i].id = CDSidtpproduto.Value) then
            begin
              cbxTipoValor.ItemIndex:= i;
            end;          
        end;              
      mEData.Text := DateToStr(CDSdata.Value);
      mEValor.Text := FloatToStr(CDSvalor.Value);
    end;
end;

procedure TfrmValor.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  carregaDadosGrid;
end;

procedure TfrmValor.edtCodigoChange(Sender: TObject);
var
  produto : TProduto;
begin
  inherited;    
  if edtCodigo.Text <> '' then 
    begin
      try
        produto:= TProduto.create; 
        if produto.consultaProdutoId(StrToInt(edtCodigo.Text)).Count > 0 then
          begin
            edtNomeProduto.Text := produto.consultaProdutoId(StrToInt(edtCodigo.Text)).Items[0].descricao;
          end;
      finally
        FreeAndNil(produto);
      end;
    end
   else 
      edtNomeProduto.Text := '';
end;

procedure TfrmValor.edtCodigoExit(Sender: TObject);
begin
  inherited;
 { if edtNomeProduto.Text = '' then
    begin
      MessageDlg('C�digo do produto n�o existe. Verifique!',mtInformation,[mbOK],0);
      edtCodigo.SetFocus;
      Abort;
    end;}
end;

procedure TfrmValor.FormShow(Sender: TObject);
begin
  inherited;
  carregaComboTpValor();
end;

procedure TfrmValor.limparCampos;
begin
  lblValorCodigo.Caption := '';
  edtCodigo.Text := '';
  cbxTipoValor.ItemIndex := -1;
  mEData.Text := '  /  /   ';
  mEValor.Text := '';
end;

procedure TfrmValor.statusBotoesInsercao;
begin
  edtCodigo.Enabled     := True;
  edtCodigo.SetFocus;
  btnPesquisa.DragMode  := dmManual;
  cbxTipoValor.Enabled  := True;
  mEData.Enabled        := True;
  mEValor.Enabled       := True;
  btnInserir.Enabled    := False;
  btnSalvar.Enabled     := True;
  btnAlterar.Enabled    := False;
  btnCancelar.Enabled   := True;
  btnExcluir.Enabled    := False;
  btnSair.Enabled       := False;
end;



procedure TfrmValor.statusBotoesNaoInsercao;
begin
  edtCodigo.Enabled     := False;
  btnPesquisa.DragMode  := dmAutomatic;
  cbxTipoValor.Enabled  := False;
  mEData.Enabled        := False;
  mEValor.Enabled       := False;
  btnInserir.Enabled    := True;
  btnSalvar.Enabled     := False;
  btnAlterar.Enabled    := True;
  btnCancelar.Enabled   := False;
  btnExcluir.Enabled    := True;
  btnSair.Enabled       := True;
end;

procedure TfrmValor.validacaoPadrao;
begin
   if edtCodigo.Text = '' then
    begin
      MessageDlg('Produto n�o informado. Verifique!',mtInformation,[mbOK],0);
      edtCodigo.SetFocus;
      Abort;
    end
  else
    if cbxTipoValor.ItemIndex = -1 then
      begin
        MessageDlg('Tipo valor n�o informado. Verifique!',mtInformation,[mbOK],0);
        cbxTipoValor.SetFocus;
        Abort;
      end
  else
    if mEData.Text = '  /  /    ' then
      begin
        MessageDlg('Data n�o informada. Verifique!',mtInformation,[mbOK],0);
        mEData.SetFocus;
        Abort;
      end 
    else 
      if mEValor.Text = '' then        
        begin
          MessageDlg('Valor n�o informado. Verifique!',mtInformation,[mbOK],0);
          mEValor.SetFocus;
          Abort;
        end;
end;

end.
