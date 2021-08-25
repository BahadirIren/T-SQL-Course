USE Northwind

-- Tarih Fonksiyonlari

-- GETDATE : Bu gunun tarihini verir
Select GETDATE();

-- DATEADD : Verilen tarihe verildigi kadar gun, ay, yil ekler
-- ekleyecegimiz zaman diliminin cinsi, ne kadar ekleyecegimiz, hangi tarihe ekleme olacak
Select DATEADD(DAY, 999, GETDATE());
Select DATEADD(MONTH, 999, GETDATE());
Select DATEADD(YEAR, 999, GETDATE());

-- DATEDIFF : iki tarih arasinda gunu, ayi veya yili hesaplar
Select DATEDIFF(DAY, '05.09.1992', GETDATE());
Select DATEDIFF(MONTH, '05.09.1992', GETDATE());
Select DATEDIFF(YEAR, '05.09.1992', GETDATE());

-- DATEPART : Verilen tarihin haftanin, ayin yahut yilin kacinci gunu oldugunu hesaplar
Select DATEPART(DW, GETDATE()); -- bugunun tarihi haftanin kacinci gunune denk geliyor
Select DATEPART(MONTH, GETDATE()); -- bugunun tarihi kacinci aya denk geliyor
Select DATEPART(DAY, GETDATE()); -- bugunun tarihi ayin kacinci gunune denk geliyor