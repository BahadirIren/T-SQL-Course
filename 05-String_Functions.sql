USE Northwind

-- String Fonksiyonlari


-- LEFT : Soldan (bastan) belirtilen sayida karakteri getirir
Select LEFT(Adi ,2) from Personeller

-- RIGHT : Sagdan (sondan) belirtilen sayida karakteri getirir
Select RIGHT(Adi ,3) from Personeller

-- UPPER : Buyuk harfe cevirir
Select UPPER(Adi) from Personeller

-- LOWER : Kucuk harfe cevirir
Select LOWER(Adi) from Personeller

-- SUBSTRING : Belirtilen indexten itibaren belirtilen sayida karakter getirir
Select SUBSTRING(SoyAdi, 3, 2) from Personeller

-- LTRIM : Soldan bosluklari keser
Select '         Bahadir'
Select LTRIM('         Bahadir') from Personeller

-- RTRIM : Sagdan bosluklari keser
Select 'Bahadir         '
Select RTRIM('Bahadir         ') from Personeller

-- REVERSE : Tersine cevirir
Select REVERSE(SoyAdi) from Personeller

-- REPLACE : Belirtilen ifadeyi, belirtilen ifade ile degistirir
Select REPLACE('Benim Adim Iren', 'Iren','Bahadir') from Personeller

-- CHARINDEX : Belirtilen karakterin veri icinde sira numarasini verir
Select MusteriAdi, CHARINDEX('r', MusteriAdi) from Musteriler
Select MusteriAdi, CHARINDEX(' ', MusteriAdi) from Musteriler



-- CHARINDEX ornekleri

-- Musteriler tablosunun MusteriAdi kolonundan sadece adlarini cekelim
Select MusteriAdi from Musteriler

Select SUBSTRING(MusteriAdi, 0,CHARINDEX(' ', MusteriAdi)) from Musteriler

-- Musteriler tablosunun MusteriAdi kolonundan sadece soyadlari cekelim
Select SUBSTRING(MusteriAdi, CHARINDEX(' ' , MusteriAdi), LEN(MusteriAdi)- (CHARINDEX(' ', MusteriAdi) -1)) from Musteriler