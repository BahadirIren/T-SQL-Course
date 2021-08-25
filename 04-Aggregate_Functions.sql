USE Northwind

-- Aggregate Fonksiyonlari

-- AVG : Ortalama Alir
Select AVG(PersonelID) from Personeller

-- MAX : En buyuk degeri bulur
Select MAX(PersonelID) from Personeller

-- MIN : En kucuk degeri bulur
Select MIN(PersonelID) from Personeller

-- COUNT : Toplam saysini verir
Select COUNT(*) from Personeller -- ne verirsen ver sonuc ayni olur

-- SUM : Toplami verir
Select SUM(NakliyeUcreti) from Satislar