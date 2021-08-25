-- Uniqueidentifier Veri Tipi

-- int, varchar vs. gibi bir veri tipidir.
-- Aldigi deger, rakamlar ve harflerden olusan cok buyuk bir sayidir.
-- Bundan dolayi bu kolona ayni degerin birden fazla gelmesi neredeyse imkansizdir.
-- O yuzden tekil bir veri olusturmak icin kullanilir.

Create Table OrnekTablo
(
	Id int primary key identity(1,1),
	Kolon1 nvarchar(MAX),
	Kolon2 nvarchar(MAX),
	Kolon3 uniqueidentifier
)


-- NEWID Fonksiyonu
-- Anlik olarak random Uniqueidentifier tipinde veri uretmemizi saglar.
Select NEWID()

Insert OrnekTablo Values('x','y', NEWID())