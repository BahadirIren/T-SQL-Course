-- === Stored Procedures ===

-- Genel Ozellikleri

-- Normal sorgulardan daha h�zl� �al���rlar

-- ��nk� normal sorgular execute edilirken "Execute Plan" ��lemi yap�l�r.
-- Bu i�lem s�ras�nda hangi tablodan veri �ekilecek, hangi kolonlardan gelecek, bunlar nerede vs gibi i�lemler yap�l�r.
-- Bir sorgu her �al��t�r�ld���nda bu i�lemler aynen tekrar tekrar yap�l�r. 
-- Fakat sorgu Stored Procedure Olarak �al��t�r�l�rsa bu i�lem sadece bir kere yap�l�r ve oda ilk �al��t�rma esnas�ndad�r.
-- Di�er �al��t�rmalarda bu i�lemler yap�lmaz. Bundan dolay� h�z ve performans da art�� sa�lan�r.

-- ��erisinde select, insert, update ve delete i�lemleri yap�labilir
-- �� i�e kullan�labilir
-- ��lerinde fonksiyon olu�turulabilir

-- Sorgular�m�z�n d��ar�dan alaca�� de�erler parametre olarak Stored Procedure'lere Ge�irilebildi�inden dolay� sorgular�m�z�n "SQL Injection"
-- yemelerini de �nlemi� oluruz. Bu y�nleriyle de daha g�venilirdirler

-- Stored Procedure Fiziksel bir veritaban� nesnesidir. Haliyle create komutu ile olu�turulur
-- Fiziksel olarak ilgili veri taban�n�n "Programmability" -> "Stored Procedures" Kombinasyonundan eri�ilebilirler


-- Prototip
-- Create Proc ya da Precedure [Isim]
--(
-- varsa parametreler
--)AS
-- yazilacak sorgular, kodlar, sartlar, fonksiyonlar, komutlar



-- == Stored Procedure Tanimlama == 
Create Proc sp_Ornek
(
	@Id int -- aksi soylenmedigi taktirde bu parametrelerin yapisi inputtur.
)As
Select * from Personeller Where PersonelID = @Id


-- Dikkat!!
-- Prosedurun parametrelerini tanimlarken parantez kullanmak zorunlu degildir ama okunabilirligi arttirmak icin kullanmakta fayda vardir.
Create Proc sp_Ornek2
	@Id int, -- aksi soylenmedigi taktirde bu parametrelerin yapisi inputtur.
	@Parametre2 int,
	@Parametre3 nvarchar(MAX)
As
Select * from Personeller Where PersonelID = @Id


-- === Stored Procedure Kullanimi ===
-- Stored Procedure yapilarini "Exec" komutu esliginde calistirabilmekteyiz.
Exec sp_Ornek 3
Exec sp_Ornek2 3, 4,'asd'





-- === Geriye deger donduren Stored Procedure Yapisi === 
Create Proc UrunGetir
(
	@Fiyat Money
)As
Select * from Urunler Where BirimFiyati > @Fiyat
Return @@ROWCOUNT


-- Kullanimi
Exec UrunGetir 40
-- Bu sekilde geriye donen degeri elde etmeksizin kullanilabilir. Sikinti olmaz.

Declare @Sonuc int
Exec @Sonuc = UrunGetir 40
print CAST(@Sonuc as nvarchar(MAX)) + ' adet urun bu islemden etkilenmistir'






-- === Output ile Deger Dondurme ===
Create Proc sp_Ornek3
(
	@Id int,
	@Adi nvarchar(MAX) Output,
	@Soyadi nvarchar(MAX) Output
)As
Select @Adi = Adi, @Soyadi = SoyAdi from Personeller Where PersonelID = @Id

-- Kullanimi

Declare @Adi nvarchar(MAX), @Soyadi nvarchar(MAX)
Exec sp_Ornek3 3 , @Adi Output, @Soyadi Output
Select @Adi + ' ' + @Soyadi




-- Genel Ornek
Create Proc sp_PersonelEkle
(
	@Ad nvarchar(MAX),
	@Soyad nvarchar(MAX),
	@Sehir nvarchar(MAX)
)As
Insert Personeller(Adi, SoyAdi, Sehir) Values(@Ad, @Soyad,@Sehir)

Exec sp_PersonelEkle 'Bahadir', 'Iren', 'Istanbul'
Select * from Personeller





-- Parametrelere varsayilan deger atama
Create Proc sp_PersonelEkle2
(
	@Ad varchar(50) = 'Isimsiz',
	@Soyad varchar(50)= 'Soyadsiz',
	@Sehir varchar(15)= 'Sehir girilmemis'
)As
Insert Personeller(Adi, SoyAdi, Sehir) Values(@Ad, @Soyad,@Sehir)

-- Burada varsayilan degerler devreye girmemektedir.
Exec sp_PersonelEkle2 'Bahadir', 'Iren', 'Istanbul'
Select * from Personeller

-- Normalde bu sekilde parametrelere deger gondermeksizin calismamasi lazim ama varsayilan degerler tanimda belirtildigi icin devreye girmektedir.
Exec sp_PersonelEkle2 

-- @Adi parametresi "Ibrahim" degerini alacaktir. Diger parametreler varsayilan degerleri alacaktir.
Exec sp_PersonelEkle2 'Ibrahim'

Select * from Personeller





-- Exec komutu

Exec('Select * from Personeller')
Select * from Personeller


-- Yanlis kullanim
Exec('Declare @Sayac int = 0')
Exec('print @Sayac')

-- Dogru kullanim
Exec('Declare @Sayac int = 0 print @Sayac')






-- === Stored Procedure Icerisinde Nesne Olusturma === 
Create Proc sp_TabloOlustur
(
	@TabloAdi nvarchar(MAX),
	@Kolon1Adi nvarchar(MAX),
	@Kolon1Ozellikleri nvarchar(MAX),
	@Kolon2Adi nvarchar(MAX),
	@Kolon2Ozellikleri nvarchar(MAX)
)As
Exec
('
Create Table ' + @TabloAdi + '
(
	' + @Kolon1Adi + ' ' + @Kolon1Ozellikleri + ',
	' + @Kolon2Adi + ' ' + @Kolon2Ozellikleri + '
)
')

Exec sp_TabloOlustur 'OrnekTabloSP', 'Id', 'int primary key identity(1, 1)', 'Kolon2', 'nvarchar(MAX)'