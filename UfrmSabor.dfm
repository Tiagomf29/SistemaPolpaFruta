inherited frmSabor: TfrmSabor
  BorderStyle = bsSingle
  Caption = 'Cadastro de Sabor'
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
    inherited btnInserir: TBitBtn
      Left = 5
      ExplicitLeft = 5
    end
  end
  inherited DBGrid1: TDBGrid
    Top = 141
    Width = 505
  end
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
end
