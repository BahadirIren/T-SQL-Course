USE Northwind

-- Select Komutu
Select 3

Select 'Bahadir'

Select 'Bahadir' , 'Iren', 25

Select 3,5,6

Select * from Personeller

Select Adi, SoyAdi from Personeller

-- Alias Atama Column a isim vermek icin
Select 3 as Deger -- eskiden kullaniliyordu

Select 3 Deger

Select 'Bahadir' Adi, 'Iren' Soyadi

Select Adi Isimler, Soyadi Soyisimler from Personeller

-- Bosluk karakteri olan alias atama
Select 1453 Istanbulun Fethi

Select 1453 [Istanbulun Fethi]

-- Bosluk karakteri olan alias atama

Select * from Satis Detaylari

Select * from [Satis Detaylari]

-- Columnlari birlestirme 
Select Adi, SoyAdi from Personeller

Select Adi + ' ' + SoyAdi [Personel Bilgileri] from Personeller

-- Farkli Tipte Kolonlari Birlestirme
Select Adi + ' ' + IseBaslamaTarihi from Personeller -- hata veriyor tipleri farkli

Select Adi + ' ' + Convert(nvarchar,IseBaslamaTarihi) from Personeller

Select Adi + ' ' + CAST(IseBaslamaTarihi as nvarchar) from Personeller

