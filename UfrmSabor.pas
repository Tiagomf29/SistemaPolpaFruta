unit UfrmSabor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.Provider, Datasnap.DBClient,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, UPadraoEnumeracao;

type
  TfrmSabor = class(TfrmCadastroPadrao)
    CDSid: TSmallintField;
    CDSdescricao: TWideStringField;
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
  var
    CadastrarNovo: boolean;
  procedure carregaDadosGrid();  
  public
    { Public declarations }
  end;

var
  frmSabor: TfrmSabor;

implementation

uses
  UDM, USabor;

{$R *.dfm}

procedure TfrmSabor.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmSabor.btnExcluirClick(Sender: TObject);
var
  sabor: TSabor;
begin
  inherited;
  if desejaExcluir then        
    begin
      sabor := TSabor.create;
      try
        sabor.id := CDSid.Value;
        sabor.excluir(sabor, TTabelasPadrao(TBSABOR));
        CDS.Refresh;
        edtDescricao.Text := '';
        lblValorCodigo.Caption := '';
        MessageDlg('Registro excluído com sucesso!', mtInformation, [mbOK], 0);
      finally
        FreeAndNil(sabor);
      end;
    end;    
end;

procedure TfrmSabor.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := True;

end;

procedure TfrmSabor.btnSalvarClick(Sender: TObject);
var
  sabor: TSabor;
begin
  inherited;
  sabor := TSabor.create;
  try
    sabor.descricao := edtDescricao.Text;
    if CadastrarNovo then
      sabor.cadastrar(sabor, TTabelasPadrao(TBSABOR))
    else
      begin
        sabor.id := CDSid.Value;
        sabor.atualizar(sabor, TTabelasPadrao(TBSABOR));
      end;
    CDS.Refresh;
    edtDescricao.Text := '';
    lblValorCodigo.Caption := '';
    MessageDlg('Registro Cadastrado com sucesso!', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(sabor);    
  end;
end;

procedure TfrmSabor.carregaDadosGrid;
begin
    if CDSid.Value <> 0 then
    begin
      lblValorCodigo.Caption := IntToStr(CDSid.Value);
      edtDescricao.Text := CDSdescricao.Value;
    end;
end;

procedure TfrmSabor.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  carregaDadosGrid();  
end;

end.
procedure TfrmSabor.DBGrid1CellClick(Column: TColumn);
begin
  inherited;

end;


