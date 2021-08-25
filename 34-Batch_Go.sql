-- Batch Kavrami - Go

-- Birbirinden bagimsiz olan komutlari, bagimsizliklarini derleyiciye soylemis oluyor. Aksi taktirde hata veriyor.

Create Database OrnekDatabase
Use OrnekDatabase
Create Table OrnekTablo
(
	Id int primary key identity(1,1),
	Kolon1 nvarchar(MAX),
	Kolon2 nvarchar(MAX)
)
-- Bunun yerine
Create Database OrnekDatabase
Go
Use OrnekDatabase
Go
Create Table OrnekTablo
(
	Id int primary key identity(1,1),
	Kolon1 nvarchar(MAX),
	Kolon2 nvarchar(MAX)
)