USE Northwind

-- With Cube
-- Group By ile gruplanmis veri kumesinde teker teker toplam alinmasini saglar.


Select SatisID, UrunID, SUM(Miktar) from [Satis Detaylari] Group By SatisID, UrunID With Cube

Select KategoriID, UrunID, SUM(TedarikciID) from Urunler Group By KategoriId, UrunID With Cube

-- Having sartiyla beraber With Cube
Select SatisID, UrunID, SUM(Miktar) from [Satis Detaylari] Group By SatisID, UrunID With Cube Having SUM(Miktar) > 150