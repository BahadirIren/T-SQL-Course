USE Northwind

-- DDL (Data Definition Language)
-- T-SQL'de varitabani nesneleri olusturmamizi saglayan ve bu nesneler uzerinde degisiklikler yapmamizi ve silmemizi saglayan yapilar.

-- Create, Alter, Drop


-- Create
-- Veritabani nesnesi olusturmamizi saglar. (database, table, view, storeproc, trigger vs.)

-- Prototipi
-- Create [Nesne] [Nesnenin Adi]

-- Create ile Database olusturmak
Create Database OrnekVeritabani
-- bu sekilde bir kullanim varsayilan ayarlarda veritabani olusturacaktir.

Create Database OrnekVeritabani
On
(
	Name = 'DDL_OrnekVeritabani',
	Filename = 'C:\Users\bahadir\Desktop\DeveloperWin\T-SQL\DDL_OrnekVeritabani.mdf',
	Size = 5,
	Filegrowth = 3
)
-- Name : Olusturulacak Veritabaninin fiziksel ismini belirtiyoruz
-- Filename :  Olusturulacak Veritabani dosyasinin fiziksel dizinini belirtiyoruz
-- Size : Veritabaninin baslangic boyutunu mb cinsinden ayarliyoruz
-- Filegrowth : Veritabaninin boyutu, baslangic boyutunu gectigi durumda boyutun ne kadar artmasi gerektigini mb cinsinden belirtiyoruz


-- Create ile Log Dosyasiyla Birlikte Database Olusturma
Create Database OrnekVeritabani
On
(
	Name = 'DDL_OrnekVeritabani',
	Filename = 'C:\Users\bahadir\Desktop\DeveloperWin\T-SQL\DDL_OrnekVeritabani.mdf',
	Size = 5,
	Filegrowth = 3
)
Log
On
(
	Name = 'DDL_OrnekVeritabani',
	Filename = 'C:\Users\bahadir\Desktop\DeveloperWin\T-SQL\DDL_OrnekVeritabani.mdf',
	Size = 5,
	Filegrowth = 3
)


-- Create Ile Tablo Olusturmak
USE OrnekVeritabani
Create Table OrnekTablo
(
	Kolon1 int,
	Kolon2 nvarchar(MAX),
	Kolon3 money
)
-- Eger Kolon adlarinda bosluk varsa
Create Table OrnekTablo2
(
	[Kolon 1] int,
	[Kolon 2] nvarchar(MAX),
	[Kolon 3] money
)
-- Kolona Primary Key ve Identity ozelligi kazandirmak
Create Table OrnekTablo3
(
	Id int Primary Key Identity(1,1),
	[Kolon 2] nvarchar(MAX),
	[Kolon 3] money
)





-- Alter 

-- Create ile olusturulan veritabani nesnelerinde degisiklik yapmamizi saglar

-- Alter ile database guncelleme

-- Prototip
-- Alter [Nesne] [Nesne Adi]
-- (Yapiya gore islemler)

Alter Database OrnekVeritabani
Modify File
(
	Name = 'GG', -- name'i GG olani degistir
	Size = 20
)

-- Alter ile olan bir tabloya kolon ekleme
Alter Table OrnekTablo
Add Kolon4 nvarchar(MAX)

-- Alter ile tablodaki kolonu guncelleme
Alter Table OrnekTablo
Alter Column Kolon4 int

-- Alter ile Tablodaki kolonu silme
Alter Table OrnekTablo
Drop Column Kolon4

-- Alter ile tabloya constraint ekleme
Alter Table OrnekTablo
Add Constraint OrnekConstraint Default 'Bos' for Kolon2

-- Alter ile tablodaki constraint silme 
Alter Table OrnekTablo
Drop Constraint OrnekConstraint




-- SP_RENAME ile Tablo adi guncelleme
SP_RENAME 'OrnekTablo', 'OrnekTabloYeni'

-- SP_RENAME ile Kolon guncelleme
SP_RENAME 'OrnekTabloYeni.Kolon1', 'Kolon1453', 'Column' 






-- Drop

-- Create ile olusturulan veritabani nesnelerini silmemize yarar.

-- Prototip
-- Drop [Nesne] [Nesne Adi]


Drop Table OrnekTabloYeni
Drop Database OrnekVeritabani

