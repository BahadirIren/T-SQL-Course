USE Northwind

-- @@Rowcount Komutu
-- yapilan islemden kac tane elemanin etkilendigini doner.

Delete from OrnekPersoneller Where Adi = 'Ayse'
Select @@ROWCOUNT

Select * from Personeller
Select @@ROWCOUNT