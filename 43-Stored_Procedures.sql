-- === Stored Procedures ===

-- Genel Ozellikleri

-- Normal sorgulardan daha hýzlý çalýþýrlar

-- Çünkü normal sorgular execute edilirken "Execute Plan" Ýþlemi yapýlýr.
-- Bu iþlem sýrasýnda hangi tablodan veri çekilecek, hangi kolonlardan gelecek, bunlar nerede vs gibi iþlemler yapýlýr.
-- Bir sorgu her çalýþtýrýldýðýnda bu iþlemler aynen tekrar tekrar yapýlýr. 
-- Fakat sorgu Stored Procedure Olarak çalýþtýrýlýrsa bu iþlem sadece bir kere yapýlýr ve oda ilk çalýþtýrma esnasýndadýr.
-- Diðer çalýþtýrmalarda bu iþlemler yapýlmaz. Bundan dolayý hýz ve performans da artýþ saðlanýr.

-- Ýçerisinde select, insert, update ve delete iþlemleri yapýlabilir
-- Ýç içe kullanýlabilir
-- Ýçlerinde fonksiyon oluþturulabilir

-- Sorgularýmýzýn dýþarýdan alacaðý deðerler parametre olarak Stored Procedure'lere Geçirilebildiðinden dolayý sorgularýmýzýn "SQL Injection"
-- yemelerini de önlemiþ oluruz. Bu yönleriyle de daha güvenilirdirler

-- Stored Procedure Fiziksel bir veritabaný nesnesidir. Haliyle create komutu ile oluþturulur
-- Fiziksel olarak ilgili veri tabanýnýn "Programmability" -> "Stored Procedures" Kombinasyonundan eriþilebilirler


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