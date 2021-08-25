-- Triggers

-- === DML Trigger ===
-- Bir tabloda Insert, Update ve Delete islemleri gerceklestiginde devreye giren yapilardir.
-- Bu islemler sonucunda veya surecinde devreye girerler.


-- === DDL Trigger ===
-- Create, Alter ve Drop islemleri sonucunda veya surecinde devreye girecek olan yapilardir.





-- === DML Trigger ===
-- Bir tabloda Insert, Update ve Delete islemleri gerceklestiginde devreye giren yapilardir.
-- Bu islemler sonucunda veya surecinde devreye girerler.

-- Inserted Table
-- Eðer bir tabloda insert iþlemi yapýlýyorsa arka planda iþlemler ilk önce RAM de oluþturulan inserted isimli bir tablo üzerinde yapýlýr. 
-- Eðer iþlemde bir problem yoksa inserted tablosundaki veriler fiziksel tabloya insert edilir. 
-- Ýþlem bittiðinde RAM de oluþturulan bu inserted tablosu silinir

-- Deleted Table
-- Eðer bir tabloda delete iþlemi yapýlýyorsa arka planda iþlemler ilk önce RAM de oluþturulan deleted isimli bir tablo üzerinde yapýlýr.
-- Eðer iþlemlerde bir problem yoksa Deleted tablosundaki veriler fiziksel tablodan silinir. 
-- Ýþlem bittiðinde RAM’den bu deleted tablosu silinecektir

-- Eðer bir tabloda update Ýþlemi yapýlýyorsa RAM de Updated isimli bir tablo oluþturulmaz!!!

-- SQL Server'da ki update Mantýðý önce silme (delete), sonra Eklemedir(insert)

-- Eðer bir tabloda update iþlemi yapýlýyorsa arka planda RAM de hem deleted hem inserted de tablolar oluþturulur.
-- iþlemler bunlar üzerinde yapýlýr

-- Not: update yaparken güncellenen kaydýn orijinali deleted Tablasunda,
-- güncellendikten sonraki hali ise inserted tablosunda bulunmaktadýr. Çünkü güncelleme demek kaydý önce silmek sonra eklemek demektir.


-- Deleted ve inserted tablolari, ilgili sorgu sonucu olustuklari icin o sorgunun kullandigi kolonlara da sahip olur.
-- Boylece deleted ve inserted tablolarindan select sorgusu yapmak mumkundur.



-- === Trigger Tanimlama ===

-- Prototip
-- Create Trigger [Trigger Adi]
-- on [Islem Yapilacak Tablo Adi]
-- after -- veya for delete, update, insert
-- as
-- [Kodlar]


-- Dikkat!!
-- Tanimlanan Triggerlara ilgili tablonun icerisindeki Triggers sekmesi altindan erisebiliriz.

Create Trigger OrnekTrigger
on Personeller
after Insert
as
Select * from Personeller

Insert Personeller(Adi,SoyAdi) Values('Bahadir', 'Iren')


-- Ornek 1
-- Tedarikciler tablosundan bir veri silindiginde tum urunlerin fiyati otomatik olarak 10 artsin
Create Trigger TriggerTedarikciler
on Tedarikciler
after Delete
as
Update Urunler Set BirimFiyati += 10
Select * from Urunler

Delete from Tedarikciler Where TedarikciID = 30




-- Ornek 2
-- Tedarikciler tablosunda bir veri guncellendiginde, kategoriler tablosunda "meyve kokteyli" adinda bir kategori olustur.
Create Trigger trgTedarikGuncellendiginde
on Tedarikciler
after Update
as
Insert Kategoriler(KategoriAdi) Values('Meyve Kokteyli')

Update Tedarikciler Set MusteriAdi = 'Hilmi' Where TedarikciID = 29
Select * from Kategoriler



-- Ornek 3
-- Personeller tablosundan bir kayit silindiginde silinen kaydin adi, soyadi, kim tarafindan ve hangi tarihte silindigi baska bir tabloya
-- kayit edilsin. Bir nevi log tablosu.
Create Table LogTablosu
(
	Id int primary key identity(1,1),
	Rapor nvarchar(MAX)
)

Create Trigger triggerPersoneller
on Personeller
after Delete
as
Declare @Adi nvarchar(MAX), @Soyadi nvarchar(MAX)
Select @Adi = Adi, @Soyadi = SoyAdi from deleted
Insert LogTablosu Values('Adi ve Soyadi ' + @Adi + ' ' + @Soyadi + ' olan personel ' + 
	SUSER_NAME() + ' tarafindan ' + CAST(GETDATE() as nvarchar(MAX)) + ' tarihinde silinmistir.')

Delete  from Personeller Where PersonelID = 55


-- Ornek 4
-- Personeller tablosunda update gerceklestigi anda devreye giren ve bir log tablosuna
-- "Adi ... olan personel ... yeni adiyla degistirilerek ... kullanici tarafindan ... tarihinde guncellendi."
-- kalibinda rapor yazan trigger yazalim.
Create Trigger trgPersonellerRapor
on Personeller
after update
as
Declare @EskiAdi nvarchar(MAX), @YeniAdi nvarchar(MAX)
Select @EskiAdi = Adi from deleted
Select @YeniAdi = Adi from inserted
Insert LogTablosu Values('Adi ' + @EskiAdi + ' olan personel ' + @YeniAdi + ' yeni adiyla degistirilerek ' + 
	SUSER_NAME() + ' kullanici tarafindan ' + CAST(GETDATE() as nvarchar(MAX)) + ' tarihinde guncellendi.')

Update Personeller Set Adi = 'Baha' Where PersonelID = 51





-- === Mutiple Actions Trigger ===

Create Trigger MultiTrigger
on Personeller
after delete, insert
as
print 'Merhaba'


Insert Personeller(Adi,SoyAdi) Values('Ahmed','Kaya')
Delete from Personeller Where PersonelID = 54



-- === Instead of Triggerlar === 
