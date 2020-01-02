unit UfrmPolpa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCadastroPadrao, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Datasnap.Provider, Data.DB, Datasnap.DBClient;

type
  TfrmPolpa = class(TfrmCadastroPadrao)
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
  frmPolpa: TfrmPolpa;

implementation

uses
  UPolpa, UPadraoEnumeracao;

{$R *.dfm}

procedure TfrmPolpa.btnAlterarClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := False;
end;

procedure TfrmPolpa.btnExcluirClick(Sender: TObject);
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

procedure TfrmPolpa.btnInserirClick(Sender: TObject);
begin
  inherited;
  CadastrarNovo := True;
end;

procedure TfrmPolpa.btnSalvarClick(Sender: TObject);
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

procedure TfrmPolpa.carregaDadosGrid;
begin
    if CDSid.Value <> 0 then
    begin
      lblValorCodigo.Caption := IntToStr(CDSid.Value);
      edtDescricao.Text := CDSdescricao.Value;
    end;
end;

procedure TfrmPolpa.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
  carregaDadosGrid();
end;

end.



