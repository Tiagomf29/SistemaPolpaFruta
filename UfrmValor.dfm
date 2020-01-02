inherited frmValor: TfrmValor
  Caption = 'Cadastro de Valor'
  ClientHeight = 516
  ClientWidth = 730
  ExplicitWidth = 746
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlDados: TPanel
    Width = 730
    Height = 177
    ExplicitWidth = 730
    ExplicitHeight = 177
    inherited lblDescricao: TLabel
      Left = 422
      Top = 3
      Visible = False
      ExplicitLeft = 422
      ExplicitTop = 3
    end
    object Label1: TLabel [3]
      Left = 8
      Top = 48
      Width = 42
      Height = 13
      Caption = 'Produto:'
    end
    object Label2: TLabel [4]
      Left = 8
      Top = 82
      Width = 51
      Height = 13
      Caption = 'Tipo Valor:'
    end
    object Label3: TLabel [5]
      Left = 8
      Top = 112
      Width = 27
      Height = 13
      Caption = 'Data:'
    end
    object Label4: TLabel [6]
      Left = 8
      Top = 141
      Width = 28
      Height = 13
      Caption = 'Valor:'
    end
    inherited edtDescricao: TEdit
      Left = 478
      Top = 0
      Width = 9
      Visible = False
      ExplicitLeft = 478
      ExplicitTop = 0
      ExplicitWidth = 9
    end
    object edtCodigo: TEdit
      Left = 65
      Top = 44
      Width = 41
      Height = 21
      TabOrder = 1
      OnChange = edtCodigoChange
      OnExit = edtCodigoExit
    end
    object btnPesquisa: TBitBtn
      Left = 106
      Top = 43
      Width = 23
      Height = 25
      DragMode = dmAutomatic
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 5
      OnClick = btnPesquisaClick
    end
    object edtNomeProduto: TEdit
      Left = 129
      Top = 45
      Width = 250
      Height = 21
      DragMode = dmAutomatic
      TabOrder = 6
    end
    object cbxTipoValor: TComboBox
      Left = 65
      Top = 78
      Width = 316
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 2
    end
    object mEData: TMaskEdit
      Left = 65
      Top = 108
      Width = 120
      Height = 21
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
    end
    object mEValor: TMaskEdit
      Left = 65
      Top = 137
      Width = 119
      Height = 21
      TabOrder = 4
    end
  end
  inherited panel1: TPanel
    Top = 177
    Width = 730
    ExplicitTop = 177
    ExplicitWidth = 730
    inherited btnSalvar: TBitBtn
      Left = 205
      ExplicitLeft = 205
    end
    inherited btnAlterar: TBitBtn
      Left = 286
      ExplicitLeft = 286
    end
    inherited btnSair: TBitBtn
      Left = 529
      ExplicitLeft = 529
    end
    inherited btnExcluir: TBitBtn
      Left = 448
      ExplicitLeft = 448
    end
    inherited btnCancelar: TBitBtn
      Left = 367
      ExplicitLeft = 367
    end
    inherited btnInserir: TBitBtn
      Left = 125
      ExplicitLeft = 125
    end
  end
  inherited DBGrid1: TDBGrid
    Top = 221
    Width = 730
  end
  inherited DS: TDataSource
    Left = 480
    Top = 0
  end
  inherited CDS: TClientDataSet
    Active = True
    Left = 512
    Top = 0
    object CDSid: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 6
      FieldName = 'id'
      Required = True
    end
    object CDSidProduto: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'idProduto'
      Required = True
      Visible = False
    end
    object CDSdescricao: TWideStringField
      DisplayLabel = 'Produto'
      FieldName = 'descricao'
      Required = True
      Size = 60
    end
    object CDSidTpProduto: TSmallintField
      Alignment = taLeftJustify
      FieldName = 'idTpProduto'
      Required = True
      Visible = False
    end
    object CDStpProduto: TWideStringField
      DisplayLabel = 'Tipo de valor'
      FieldName = 'tpProduto'
      Required = True
      Size = 10
    end
    object CDSdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Required = True
    end
    object CDSvalor: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Valor'
      DisplayWidth = 20
      FieldName = 'valor'
      Required = True
      currency = True
    end
  end
  inherited DSP: TDataSetProvider
    Left = 448
    Top = 0
  end
  inherited QRY: TZQuery
    Active = True
    SQL.Strings = (
      
        'select  a.id,b.id as idProduto,concat(b.descricao," - ",d.descri' +
        'cao," - ",e.descricao)as descricao,'
      'c.id as idTpProduto, c.descricao as tpProduto, a.data,a.valor'
      'from tbvalor a'
      'inner join tbproduto b on a.id_tbproduto = b.id'
      'inner join tpvalor c on c.id = a.id_tpvalor'
      'inner join tbsabor d on d.id = b.id_tbsabor'
      'inner join tppolpa e on e.id = b.id_tppolpa'
      ''
      'order by 1 desc')
    Left = 411
    Top = 0
  end
end
