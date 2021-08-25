USE Northwind

-- With Komutu

-- boyle bir yapi veritabanina kaydedilmemektedir.
With PersonelSatis(id, adi, soyadi, satisid)
as
(
Select p.PersonelID, p.Adi, p.SoyAdi, s.SatisID from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID 
)
Select * from PersonelSatis ps Inner Join [Satis Detaylari] sd on ps.satisid = sd.SatisID