unit UfrmTipoPolpa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Datasnap.Provider, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmTipoPolpa = class(TfrmCadastroPadrao)
    CDSid: TSmallintField;
    CDSdescricao: TWideStringField;
    procedure btnInserirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
  var
    CadastrarNovo: boolean;
  public
    { Public declarations }
  end;

var
  frmTipoPolpa: TfrmTipoPolpa;

implementation
uses 
  UPolpa, UPadraoEnumeracao;

{$R *.dfm}

procedure TfrmTipoPolpa.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmTipoPolpa.btnExcluirClick(Sender: TObject);
var
  polpa: TPolpa;
begin
  inherited;
  if desejaExcluir then        
    begin
      polpa := TPolpa.create;
      try
        polpa.id := CDSid.Value;
        polpa.excluir(polpa, TTabelasPadrao(TPPOLPA));
        CDS.Refresh;
        edtDescricao.Text := '';
        lblValorCodigo.Caption := '';
        MessageDlg('Registro excluído com sucesso!', mtInformation, [mbOK], 0);
      finally
        FreeAndNil(polpa);
      end;
    end;    
end;

procedure TfrmTipoPolpa.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := True;
end;

procedure TfrmTipoPolpa.btnSalvarClick(Sender: TObject);
var
  polpa: TPolpa;
begin
  inherited;
  polpa := TPolpa.create;
  try
    polpa.descricao := edtDescricao.Text;
    if CadastrarNovo then
      polpa.cadastrar(polpa, TTabelasPadrao(TPPOLPA))
    else
      begin
        polpa.id := CDSid.Value;
        polpa.atualizar(polpa, TTabelasPadrao(TPPOLPA));
      end;
    CDS.Refresh;
    edtDescricao.Text := '';
    lblValorCodigo.Caption := '';
    MessageDlg('Registro Cadastrado com sucesso!', mtInformation, [mbOK], 0);
  finally
    FreeAndNil(polpa);
  end;
end;

end.
