inherited frmTipoPolpa: TfrmTipoPolpa
  Caption = 'Cadastro de tipo de polpa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited CDS: TClientDataSet
    Active = True
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
      'select * from tppolpa')
  end
end
