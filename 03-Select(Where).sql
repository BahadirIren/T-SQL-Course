USE Northwind

-- Select Sorgularinda (Where) Sarti yazmak

Select * from Personeller

Select * from Personeller Where Sehir = 'London'

Select * from Personeller Where BagliCalistigiKisi < 5

Select * from Personeller Where Sehir = 'London' and Ulke = 'UK' 

Select * from Personeller Where UnvanEki = 'Mr.' or Sehir = 'Seattle'

Select * from Personeller Where Ulke = 'USA'

Select * from Personeller Where Adi = 'Robert' and SoyAdi ='King'

Select * from Personeller Where Sehir = 'London' or Sehir = 'Tacoma' or Sehir = 'Kirkland'

Select * from Personeller Where PersonelID = 5

Select * from Personeller Where PersonelID >= 5

-- <> esit degilse 
-- = esitse
-- <= kucuk ve esitse
-- >= buyuk ve esitse

Select * from Personeller Where YEAR(IseBaslamaTarihi) = 1993

Select * from Personeller Where YEAR(IseBaslamaTarihi) > 1992

Select * from Personeller Where DAY(DogumTarihi) <> 29

Select * from Personeller Where YEAR(DogumTarihi) > 1950 and YEAR(DogumTarihi) < 1965





-- Between Komutu

Select * from Personeller Where YEAR(DogumTarihi) > 1950 and YEAR(DogumTarihi) < 1965

Select * from Personeller Where YEAR(DogumTarihi) Between 1950 and 1965



-- In Komutu

Select * from Personeller Where Sehir = 'London' or Sehir = 'Tacoma' or Sehir = 'Kirkland'

Select * from Personeller Where Sehir In('London','Tacoma','Kirkland')




-- Like Komutu

-- adinin bas harfi j ile baslayanlari getir
Select Adi,SoyAdi from Personeller Where Adi Like 'j%'

-- adinin son harfi y ile bitenleri getir
Select Adi,SoyAdi from Personeller Where Adi Like '%y'

Select Adi,SoyAdi from Personeller Where Adi Like '%ert'

Select Adi,SoyAdi from Personeller Where Adi Like 'r%t'

Select Adi,SoyAdi from Personeller Where Adi Like 'r%' and Adi Like '%t'

-- adinda an gecenleri getir
Select Adi,SoyAdi from Personeller Where Adi Like '%an%'

Select Adi,SoyAdi from Personeller Where Adi Like 'n%an%' 

-- isminin bas harfi a ikinci harfi onemli degil ucuncu harfi d olacak
Select Adi,SoyAdi from Personeller Where Adi Like 'a_d%'

Select Adi,SoyAdi from Personeller Where Adi Like 'm___a%'


-- [] ya da operatoru

-- isminin ilk harfi n ya da m ya da r olanlari getir
Select Adi,SoyAdi from Personeller Where Adi Like '[nmr]%'

-- ismin icerisinde  a ya da i harfi olanlari getir
Select Adi,SoyAdi from Personeller Where Adi Like '%[ai]%'

-- [*-*] (Alfabetik Arasinda) operatoru

-- bas harfi a-k arasinda
Select Adi,SoyAdi from Personeller Where Adi Like '[a-k]%'


-- [^*] (degil) operatoru

-- bas harfi a olmayanlari getir
Select Adi,SoyAdi from Personeller Where Adi Like '[^a]%'

Select Adi,SoyAdi from Personeller Where Adi Like '[^an]%'





-- Like Sorgularinda Escape Karakterleri

-- [] Operatoru ile
-- Escape Komutu ile

Select Adi,SoyAdi from Personeller Where Adi Like '_%'

Select Adi,SoyAdi from Personeller Where Adi Like '[_]%'

Select Adi,SoyAdi from Personeller Where Adi Like 'u_%' Escape 'u' -- Escape Karakteri




