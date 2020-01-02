unit UfrmProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.StdCtrls,System.Generics.Collections,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Datasnap.Provider, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,UPolpa, UPadraoEnumeracao, UTipoProduto, 
  Usabor, Uproduto;

type
  TfrmProduto = class(TfrmCadastroPadrao)
    lblTipoProduto: TLabel;
    cbxTipoProduto: TComboBox;
    lblSabor: TLabel;
    cbxSabor: TComboBox;
    lblTipoPolpa: TLabel;
    cbxTipoPolpa: TComboBox;
    lblPeso: TLabel;
    edtPeso: TEdit;
    lblEstoqueMinimo: TLabel;
    edtEstoqueMinimo: TEdit;
    CDSid: TIntegerField;
    CDSid_tpproduto: TSmallintField;
    CDStipoProduto: TWideStringField;
    CDSdescricao: TWideStringField;
    CDSpeso: TFloatField;
    CDSid_tbsabor: TSmallintField;
    CDSsabor: TWideStringField;
    CDSid_tppolpa: TSmallintField;
    CDSTpPolpa: TWideStringField;
    CDSestoque_minimo: TSmallintField;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    listaCbxSabor : TObjectList<TSabor>;
    listaCbxTipoProduto : TObjectList<TTipoProduto>;
    listaCbxTipoPolpa : TObjectList<TPolpa>;
    procedure carregaComboTipoPolpa();
    procedure carregaComboTipoProduto();
    procedure carregaComboSabor();
    procedure statusBotoesInsercao();override;
    procedure statusBotoesNaoInsercao();override; 
    procedure validacaoPadrao(); override; 
    procedure carregaDadosGrid();    
    procedure limparCampos();

    var
      CadastrarNovo: boolean;
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation
    

{$R *.dfm}

{ TfrmProduto }

procedure TfrmProduto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmProduto.btnCancelarClick(Sender: TObject);
begin
  inherited;
  limparCampos();
end;

procedure TfrmProduto.btnExcluirClick(Sender: TObject);
var
  produto :TProduto;
begin
  inherited;
  if MessageDlg('Tem certeza que deseja excluir o registro?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    begin
      produto := TProduto.create;
      produto.id := CDSid.Value;
      produto.excluir(produto);
      CDS.Close;
      CDS.Open;
      MessageDlg('Registro exclu�do com sucesso!',mtInformation,[mbOK],0);
    end 
  else
    limparCampos();  
end;

procedure TfrmProduto.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo :=True;
  limparCampos();
  edtDescricao.Text := 'Polpa de Fruta';
end;

procedure TfrmProduto.btnSalvarClick(Sender: TObject);
var
  produto : TProduto;
  tipoProduto : TTipoProduto;
  tipoPolpa : TPolpa;
  sabor : TSabor;
begin
  inherited;

  produto := TProduto.create;
  tipoProduto := TTipoProduto.create;
  tipoPolpa := TPolpa.create;
  sabor := TSabor.create;

  try
    produto.descricao := edtDescricao.Text;
    sabor.id := Integer(cbxSabor.Items.Objects[cbxSabor.ItemIndex]);
    produto.sabor := sabor;
    tipoProduto.id := Integer(cbxTipoProduto.Items.Objects[cbxTipoProduto.ItemIndex]);
    produto.tipoProduto := tipoProduto;
    tipoPolpa.id := Integer(cbxTipoPolpa.Items.Objects[cbxTipoPolpa.ItemIndex]);
    produto.tipoPolpa := tipoPolpa;
    
    if edtPeso.Text <> '' then
      produto.peso := StrToFloat(edtPeso.Text);

    if edtEstoqueMinimo.Text <> '' then
      produto.estoqueMinimo := StrToInt(edtEstoqueMinimo.Text);      
      
    if CadastrarNovo then
      begin
        produto.cadastrar(produto);     
        CDS.Close;
        CDS.Open;
        limparCampos();
        MessageDlg('Produto cadastro com sucesso!',mtInformation,[mbOK],0);        
      end
    else  
      begin     
        produto.id := CDSid.Value;        
        produto.atualizar(produto);
        CDS.Close;
        CDS.Open;
        limparCampos();
        MessageDlg('Produto atualizado com sucesso!',mtInformation,[mbOK],0);
      end;
  finally
    FreeAndNil(produto);
    FreeAndNil(tipoProduto);
    FreeAndNil(tipoPolpa);
    FreeAndNil(sabor);
  end;
end;

procedure TfrmProduto.carregaComboSabor;
var
  sabor : TSabor;
  i     : Integer;
begin
   
  sabor := TSabor.create;

  for i := 0 to sabor.consultar(TBSABOR).Count-1 do
   begin
     sabor := TSabor.create;
     sabor.id := sabor.consultar(TBSABOR).Items[i].id;
     sabor.descricao := sabor.consultar(TBSABOR).Items[i].descricao;
     cbxSabor.Items.AddObject(sabor.descricao,TSabor(sabor.id));
     listaCbxSabor.Add(sabor);
   end;
   
end;

procedure TfrmProduto.carregaComboTipoPolpa;
var
  TipoPolpa : TPolpa;
  i         : Integer;
begin

  TipoPolpa := TPolpa.create;

  for i := 0 to TipoPolpa.consultar(TPPOLPA).Count-1 do
   begin
     TipoPolpa := TPolpa.create;
     TipoPolpa.id := TipoPolpa.consultar(TPPOLPA).Items[i].id;
     TipoPolpa.descricao := TipoPolpa.consultar(TPPOLPA).Items[i].descricao;
     cbxTipoPolpa.Items.AddObject(TipoPolpa.descricao, TPolpa(TipoPolpa.id));
     listaCbxTipoPolpa.Add(TipoPolpa);
   end;
       
end;

procedure TfrmProduto.carregaComboTipoProduto;
var
  tipoProduto : TTipoProduto;
  i           : Integer;
begin

  tipoProduto := TTipoProduto.create;
  
  for i := 0 to tipoProduto.consultar(TPPRODUTO).Count-1 do
    begin
      tipoProduto := TTipoProduto.create;
      tipoProduto.id := tipoProduto.consultar(TPPRODUTO).Items[i].id;
      tipoProduto.descricao := tipoProduto.consultar(TPPRODUTO).Items[i].descricao;
      cbxTipoProduto.Items.AddObject(tipoProduto.descricao,TTipoProduto(tipoProduto.id));
      listaCbxTipoProduto.Add(tipoProduto);
    end;
  
end;

procedure TfrmProduto.carregaDadosGrid;
var
  i  : Integer;
begin

  lblValorCodigo.Caption := IntToStr(CDS.FieldByName('id').AsInteger);
  edtDescricao.Text := CDS.FieldByName('descricao').AsString;
  edtPeso.Text      := FloatToStr(CDS.FieldByName('peso').AsFloat);
  edtEstoqueMinimo.Text := IntToStr(CDS.FieldByName('estoque_minimo').AsInteger);
  
  for i := 0 to listaCbxTipoProduto.Count-1 do
    begin
      if listaCbxTipoProduto.Items[i].id = CDS.FieldByName('id_tpproduto').AsInteger then
        cbxTipoProduto.ItemIndex:=i;
    end;

  for i := 0 to listaCbxSabor.Count-1 do
    begin
      if listaCbxSabor.Items[i].id = CDS.FieldByName('id_tbsabor').AsInteger then
        cbxSabor.ItemIndex := i;
    end;

  for i := 0 to listaCbxTipoPolpa.Count-1 do
    begin    
      if listaCbxTipoPolpa.Items[i].id = CDS.FieldByName('id_tppolpa').AsInteger then
        cbxTipoPolpa.ItemIndex := i;
    end;
end;

procedure TfrmProduto.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  carregaDadosGrid();
end;

procedure TfrmProduto.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if (gdSelected in State) then
    carregaDadosGrid();
end;

procedure TfrmProduto.FormCreate(Sender: TObject);
begin
  inherited;
  listaCbxSabor := TObjectList<TSabor>.Create;
  listaCbxTipoProduto := TObjectList<TTipoProduto>.Create;
  listaCbxTipoPolpa := TObjectList<TPolpa>.Create;
end;

procedure TfrmProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(listaCbxSabor);
  FreeAndNil(listaCbxTipoProduto);
  FreeAndNil(listaCbxTipoPolpa);
end;

procedure TfrmProduto.FormShow(Sender: TObject);
begin
  inherited;
  carregaComboTipoPolpa();
  carregaComboTipoProduto();
  carregaComboSabor();
end;

procedure TfrmProduto.limparCampos;
begin
  lblValorCodigo.Caption := '';
  edtDescricao.Text := '';
  cbxTipoProduto.ItemIndex := -1;
  cbxTipoPolpa.ItemIndex := -1;
  cbxSabor.ItemIndex := -1;
  edtPeso.Text := '';
  edtEstoqueMinimo.Text := '';
  DBGrid1.Options := DBGrid1.Options - [dgAlwaysShowSelection];
end;

procedure TfrmProduto.statusBotoesInsercao;
begin
  edtDescricao.Enabled     := True;
  edtDescricao.SetFocus;
  cbxTipoProduto.Enabled   := True;
  cbxTipoPolpa.Enabled     := True;
  cbxSabor.Enabled         := True;
  edtPeso.Enabled          := True;
  edtEstoqueMinimo.Enabled := True;
  btnInserir.Enabled       := False;
  btnSalvar.Enabled        := True;
  btnAlterar.Enabled       := False;
  btnCancelar.Enabled      := True;
  btnExcluir.Enabled       := False;
  btnSair.Enabled          := False;  
end;

procedure TfrmProduto.statusBotoesNaoInsercao;
begin
  edtDescricao.Enabled     := False;
  cbxTipoProduto.Enabled   := False;
  cbxTipoPolpa.Enabled     := False;
  cbxSabor.Enabled         := False;
  edtPeso.Enabled          := False;
  edtEstoqueMinimo.Enabled := False;
  btnInserir.Enabled       := True;
  btnSalvar.Enabled        := False;
  btnAlterar.Enabled       := True;
  btnCancelar.Enabled      := False;
  btnExcluir.Enabled       := True;
  btnSair.Enabled          := True;  
end;

procedure TfrmProduto.validacaoPadrao;
begin

  if edtDescricao.Text = '' then
   begin
     MessageDlg('Informe a descri��o!',mtInformation,[mbOK],0);
     edtDescricao.SetFocus;
     Abort;
   end
  else
   if cbxTipoProduto.ItemIndex = -1 then
     begin
       MessageDlg('Informe o tipo do produto!',mtInformation,[mbOK],0);
       cbxTipoProduto.SetFocus;
       Abort;       
     end
   else
     if cbxSabor.ItemIndex = -1 then
       begin  
         MessageDlg('Informe o sabor!',mtInformation,[mbOK],0);
         cbxSabor.SetFocus;
         Abort;           
       end
     else
      if cbxTipoPolpa.ItemIndex = -1 then
        begin  
          MessageDlg('Informe o tipo de polpa!',mtInformation,[mbOK],0);
          cbxTipoPolpa.SetFocus;
          Abort;            
        end;
end;

end.
