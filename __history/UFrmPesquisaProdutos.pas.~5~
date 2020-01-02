unit UFrmPesquisaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPesquisaPadrao, Datasnap.Provider,
  Data.DB, Datasnap.DBClient, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesquisaProdutos = class(TfrmPesquisaPadrao)
    procedure dbgPesquisaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisaProdutos: TfrmPesquisaProdutos;

implementation
uses
  UGenericRecord;

{$R *.dfm}

procedure TfrmPesquisaProdutos.dbgPesquisaDblClick(Sender: TObject);
begin
  inherited;
  T_TransporteDadosForm.FId        := CDSid.Value;
  T_TransporteDadosForm.FDescricao := CDSdescricao.Value;
  Close;
    
end;

end.
