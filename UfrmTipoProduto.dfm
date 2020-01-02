inherited frmTipoProduto: TfrmTipoProduto
  BorderStyle = bsSingle
  Caption = 'Cadastro Tipo de Produto'
  ClientHeight = 436
  ClientWidth = 505
  ExplicitHeight = 465
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
    Top = 141
    Width = 505
  end
  inherited DS: TDataSource
    Left = 368
  end
  inherited CDS: TClientDataSet
    Active = True
    Left = 328
    object CDSid: TSmallintField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Required = True
    end
    object CDSdescricao: TWideStringField
      DisplayLabel = 'Descricao'
      FieldName = 'descricao'
      Required = True
      Size = 40
    end
  end
  inherited QRY: TZQuery
    SQL.Strings = (
      'select * from tpproduto')
  end
end
