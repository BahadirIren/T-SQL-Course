USE Northwind

-- Group by

Select * from Urunler

Select KategoriID, COUNT(*) Adet from Urunler Group By KategoriID

Select PersonelID, COUNT(*) Adet from Satislar Group By PersonelID

Select PersonelID, SUM(NakliyeUcreti) from Satislar Group By PersonelID



-- Group By isleminde Where sarti kullanma
-- Normal kolonlar uzerinde sart uygular

Select KategoriID, COUNT(*) Adet from Urunler Where KategoriID >= 5 Group By KategoriID

Select PersonelID, COUNT(*) Adet from Satislar Where PersonelID < 4 Group By PersonelID

Select PersonelID, SUM(NakliyeUcreti) from Satislar Where PersonelID = 5  Group By PersonelID



-- Group By isleminde Having Komutu kullanarak Sart olusturma
-- Having Aggregate uzerinde sart uygular

Select KategoriID, COUNT(*) Adet from Urunler Where KategoriID > 5 Group By KategoriID Having COUNT(*) > 5 

Select KategoriID, COUNT(*) Adet from Urunler Group By KategoriID Having COUNT(*) > 5 
