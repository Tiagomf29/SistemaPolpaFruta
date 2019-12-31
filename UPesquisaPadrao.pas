unit UPesquisaPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Datasnap.DBClient, Datasnap.Provider, UDM;

type
  TfrmPesquisaPadrao = class(TForm)
    dbgPesquisa: TDBGrid;
    pnlPesquisa: TPanel;
    Label1: TLabel;
    edtPesquisa: TEdit;
    DTS: TDataSource;
    QRY: TZQuery;
    CDS: TClientDataSet;
    DSP: TDataSetProvider;
    CDSid: TIntegerField;
    CDSdescricao: TWideStringField;
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  frmPesquisaPadrao: TfrmPesquisaPadrao;

implementation

{$R *.dfm}

procedure TfrmPesquisaPadrao.edtPesquisaChange(Sender: TObject);
begin
  with QRY do
  begin
    close;
    sql.Clear;
    SQL.Add('select * from tbproduto where descricao like :descricao');
    ParamByName('descricao').AsString := '%'+trim(edtPesquisa.Text)+'%';
    Open;
  end;
  CDS.Close;
  CDS.Open;
end;

procedure TfrmPesquisaPadrao.FormShow(Sender: TObject);
begin
 edtPesquisa.SetFocus;
end;

end.
