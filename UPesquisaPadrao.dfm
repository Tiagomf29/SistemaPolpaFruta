object frmPesquisaPadrao: TfrmPesquisaPadrao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Pesquisa Padr'#227'o'
  ClientHeight = 321
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgPesquisa: TDBGrid
    Left = 0
    Top = 52
    Width = 447
    Height = 269
    Align = alBottom
    DataSource = DTS
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 57
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object edtPesquisa: TEdit
      Left = 8
      Top = 25
      Width = 321
      Height = 21
      TabOrder = 0
      OnChange = edtPesquisaChange
    end
  end
  object DTS: TDataSource
    AutoEdit = False
    DataSet = CDS
    Left = 64
    Top = 144
  end
  object QRY: TZQuery
    Connection = DM.conexao
    Active = True
    SQL.Strings = (
      'select id, descricao from tbproduto')
    Params = <>
    Left = 224
    Top = 144
  end
  object CDS: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP'
    Left = 112
    Top = 144
    object CDSid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Required = True
    end
    object CDSdescricao: TWideStringField
      DisplayLabel = 'Descricao'
      FieldName = 'descricao'
      Required = True
      Size = 50
    end
  end
  object DSP: TDataSetProvider
    DataSet = QRY
    Left = 168
    Top = 144
  end
end
