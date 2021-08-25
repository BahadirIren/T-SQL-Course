USE Northwind

-- Tablolari yan yana birlestirme

Select * from Personeller
Select * from Satislar

Select * from Personeller, Satislar

-- hata veriyor cunku her iki tabloda da PersonelID var  hangisinden cekecegini bilemiyor
Select PersonelID from Personeller,Satislar 


-- Boyle cozebiliriz
Select Personeller.PersonelID, Satislar.MusteriID from Personeller,Satislar 
Select p.PersonelID, s.MusteriID from Personeller p ,Satislar s Where p.PersonelID = s.PersonelID