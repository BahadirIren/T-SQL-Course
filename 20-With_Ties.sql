USE Northwind

-- With Ties Komutu

Select * from [Satis Detaylari]

Select Top 6 * from [Satis Detaylari]

-- 6. veriye esit olan veriler var onlari da getirmek istiyoruz
Select Top 6 with ties * from [Satis Detaylari] Order By SatisID -- order by sart