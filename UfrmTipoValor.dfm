inherited frmTipoValor: TfrmTipoValor
  BorderStyle = bsSingle
  Caption = 'Cadastro de Tipo de Valor'
  ClientHeight = 436
  ClientWidth = 505
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDados: TPanel
    Width = 505
    ExplicitWidth = 505
  end
  inherited panel1: TPanel
    Width = 505
    ExplicitWidth = 505
  end
  inherited DBGrid1: TDBGrid
    Width = 505
    Height = 305
  end
  inherited DS: TDataSource
    AutoEdit = False
  end
  inherited CDS: TClientDataSet
    Active = True
    object CDSid: TSmallintField
      FieldName = 'id'
      Required = True
    end
    object CDSdescricao: TWideStringField
      FieldName = 'descricao'
      Required = True
      Size = 40
    end
  end
  inherited QRY: TZQuery
    SQL.Strings = (
      'select * from tpvalor')
  end
end
