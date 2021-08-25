
-- Constraints
-- Constraintsler sayesinde tablolar uzerinde istedigimiz sartlar ve durumlara gore kisitlamalar yapabiliyoruz.

-- 1. Default Constraints
-- 2. Check Constraints
-- 3. Primary Key Constraints
-- 4. Unique Constraints
-- 5. Foreign Key Constraints


-- 1. Default Constraints
-- Default Constraint sayesinde kolona bir deger girilmedigi takdirde varsayilan olarak ne girilmesi gerektigini belirtebiliyoruz.

-- Genel Yapisi
-- Add Constraint [Constraint Adi] Default 'Varsayilan Deger' for [Kolon Adi]

Create Table OrnekTablo
(
	Id int Primary key identity(1,1),
	Kolon1 nvarchar(MAX),
	Kolon2 int

)

Alter Table OrnekTablo
Add Constraint Kolon1Constraint Default 'Bos' for Kolon1

Alter Table OrnekTablo
Add Constraint Kolon2Constraint Default -1 for Kolon2

Insert OrnekTablo(Kolon2) Values(0)
Insert OrnekTablo(Kolon1) Values('Ornek Bir Deger')

Select * from OrnekTablo





-- 2. Check Constraints
-- Bir kolona girilecek olan verinin belrli bir sarta uymasi zorunlu tutar.

-- Genel Yapisi
-- Add Constraint [Constraint Adi] Check (Sart)

Alter Table OrnekTablo
Add Constraint Kolon2Kontrol Check ((Kolon2 * 5) % 2 = 0)

-- Dikkat!!
-- Check constraint olusturulmadan once ilgili tabloda sarta aykiri degerler varsa eger constraint olusturulmayacaktir!!!
-- Ancak onceki kayitlari gormezden gelip yine de Check Constrainti uygulamak istiyorsak "With NoCheck" komutu kullanilmalidir.

-- With NoCheck Komutu
-- Suana kadar olan kayitlari gormezden gelip, check constrainti uygulattirir.
Alter Table OrnekTablo
With NoCheck Add Constraint Kolon2Kontrol Check ((Kolon2 * 5) % 2 = 0)





-- 3. Primary Key Constraints
-- Primary Key Constraint ile; o kolona eklenen primary key ile, baska tablolarda foreign key olusturarak iliski kurmamiz mumkun olur.
-- Bunun yaninda o kolonun tasidigi verinin tekil olacagi da garanti edilmis olur. Primary key constraint ile ayrica CLUSTERED  index
-- olusturulmus olur.

-- Genel Yapisi
-- Add Constraint [Constraint Adi] Primary Key (Kolon Adi)

-- Dikkat!!
-- Primary key constraint kullanilan kolon primary key ozelligine sahip olamamalidir.

Alter Table OrnekTablo
Add Constraint PrimaryId Primary Key (Id)






-- 4. Unique Constraints
-- Unique constraintin tek amaci, belirttigimiz kolondaki degerlerin tekil olmasin saglamaktadir. Birden fazla tekrarli kayiti engeller.

-- Genel yapisi
-- Add Constraint [Constraint Adi] Unique (Kolon Adi)

Alter Table OrnekTablo
Add Constraint OrnekTabloUnique Unique (Kolon2)

-- "Kolon2" kolonuna unique constraint verilerek tekil hale getirilmistir. Bundan sonra iki tane ayni veriden kayit yapilamamaktadir.








-- 5. Foreign Key Constraints
-- Tablolarin kolonlari arasinda iliski kurmamizi saglar. Bu iliski neticesinde; foreign key olan kolondaki karsiliginin bosa dusmemesi
-- icin primary key kolonu olan tablodan veri silinmesini, guncellenmesini engeller.

-- Genel Yapisi
-- Add Constraint [Constraint Adi] Foreign Key (Kolon Adi) References [2. Tablo Adi](2. Tablodaki Kolon Adi)

Create Table Ogrenciler
(
	OgrenciId int primary key identity(1,1),
	DersId int,
	Adi nvarchar(MAX),
	SoyAdi nvarchar(MAX)
)

Create Table Dersler
(
	DersId int primary key identity(1,1),
	DersAdi nvarchar(MAX)
)
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrencilerDers Foreign Key (DersId) References Dersler(DersId)
-- Su durumda, delete ve update islemlerinden iliskili kolondaki veriler etkilenmez.
-- Davranisi degistirmek icin asagidaki komutlar kullanilir.


-- Cascade
-- Ana tablodaki kayit silindiginde ya da guncellendiginde, iliskili kolondaki karsiliginda otomatik olarak silinir ya da guncellenir.
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrencilerDers Foreign Key (DersId) References Dersler(DersId)
On Update Cascade
On Delete Cascade


-- Set Null
-- Ana tablodaki kayit silindiginde ya da guncellendiginde, iliskili kolondaki karsiliginda "Null" degeri basilir.
Alter Table Ogrenciler
Add Constraint ForeignKeyOgrencilerDers Foreign Key (DersId) References Dersler(DersId)
On Update Set Null
On Delete Set Null

-- Set Default
-- Ana tablodaki kayit silindiginde ya da guncellendiginde, iliskili kolondaki karsiligina o kolonun default degeri basilir.
-- Bu default deger dedigimiz default tipte bit constrainttir. Bunu kendimiz olusturabiliriz.
Alter Table Ogrenciler
Add Constraint DefaultOgrenciler Default -1 for DersId

Alter Table Ogrenciler
Add Constraint ForeignKeyOgrencilerDers Foreign Key (DersId) References Dersler(DersId)
On Update Set Default
On Delete Set Default

-- Bu ayarlar verilmedigi taktirde "no action" ozelligi gecerlidir.