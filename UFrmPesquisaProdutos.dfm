inherited frmPesquisaProdutos: TfrmPesquisaProdutos
  Caption = 'Pesquisa de Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgPesquisa: TDBGrid
    OnDblClick = dbgPesquisaDblClick
  end
  inherited QRY: TZQuery
    SQL.Strings = (
      
        'select  b.id,concat(b.descricao," - ",d.descricao," - ",e.descri' +
        'cao)as descricao'
      'from tbproduto b'
      'inner join tbsabor d on d.id = b.id_tbsabor'
      'inner join tppolpa e on e.id = b.id_tppolpa')
  end
end
