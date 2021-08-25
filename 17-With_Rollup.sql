USE Northwind

-- With Rollup
-- Group By ile gruplanmis veri kumesinde ara toplam alinmasini saglar.

Select SatisID, UrunID, SUM(Miktar) from [Satis Detaylari] Group By SatisID, UrunID With Rollup

Select KategoriID, UrunID, SUM(TedarikciID) from Urunler Group By KategoriId, UrunID With Rollup

-- Having sartiyla beraber With Rollup
Select SatisID, UrunID, SUM(Miktar) from [Satis Detaylari] Group By SatisID, UrunID With Rollup Having SUM(Miktar) > 150