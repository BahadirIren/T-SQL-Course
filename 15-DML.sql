USE Northwind

-- DML (Data Manipulation Language)

-- Select, Insert, Update, Delete


-- Select
Select * from Personeller



-- Insert

-- Insert [Tablo adi](kolonlar) Values(Degerler)
Insert Personeller(Adi, SoyAdi) Values('Bahadir', 'Iren')
Insert Personeller Values('Iren', 'Bahadir', 'Yazilim ve Veritabani Uzmani', 'YM', '09.05.1992', GETDATE(),
'Istanbul', 'Istanbul', 'Marmara', '34000', 'Turkiye', '05552221111', null, null, null, null, null)

-- [Dikkat edilmesi gerekenler]
-- Into Komutu ile yazilabilir
Insert Into Personeller(Adi,SoyAdi) Values('Bahadir', 'Iren') -- Eski versiyon
-- Kolonun kabul ettigi veri tipi ve karakter uzunluguda kayit yapilmalidir.
-- Not Null olan kolonlara bos birakilamayacaklarindan dolayi mutlaka deger gonderilmelidir.
Insert Personeller(Adi,SoyAdi,Unvan, UnvanEki) Values('','','a', 'b')
-- Otomatik artan(identity) kolonlara deger gonderilmez.
-- Tablodaki secilen yahut butun kolonlara deger gonderilecegi belirtilip, gonderilmezse hata verecektir.
Insert Personeller(Adi,SoyAdi) Values('Bahadir')
Insert Personeller Values('Bahadir')


-- Pratik kullanim
Insert Musteriler(MusteriAdi, Adres) Values('Hilmi', 'Corum')
Insert Musteriler(MusteriAdi, Adres) Values('Necati', 'Cankiri')
Insert Musteriler(MusteriAdi, Adres) Values('Rifki', 'Yozgat')

Insert Musteriler(MusteriAdi, Adres) Values('Hilmi', 'Corum'), ('Necati', 'Cankiri'), ('Rifki', 'Yozgat')


-- Insert Komutu ile Select Sorgusu sonucu gelen verileri farkli tabloya kaydetme
Insert OrnekPersoneller Select Adi, Soyadi from Personeller
-- Burada dikkat etmeniz gereken nokta; Select sorgusunda donen kolon sayisi ile Insert islemi yapilacak tablonun kolon sayisi
-- birbirine esit olmasi gerekmektedir.


-- Select sorgusu sonucu gelen verileri farkli bir tablo olusturarak kaydetme
Select Adi,SoyAdi, Ulke Into OrnekPersoneller2 from Personeller
-- bu yontemle primary key ve foreign keyler olusturulmazlar. (yeni bir tablo olusturur)






-- Update

-- Update [Tablo adi] Set [Kolon Adi] = Deger

Update OrnekPersoneller Set Adi = 'Mehmet' -- tablonun ilgili kolonunun tamami degisti

-- Update Sorgusunda Where Sarti Yazmak
Update OrnekPersoneller Set Adi = 'Mehmet' Where Adi = 'Nancy'
Update OrnekPersoneller Set Adi = 'Ayse' Where SoyAdi = 'Davolio'

-- Update sorgusunda Join yapilarini kullanarak birden fazla tabloda guncelleme yapmak
Update Urunler Set UrunAdi = k.KategoriAdi from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID

-- Update sorgusunda Subquery ile guncelleme yapmak
Update Urunler Set UrunAdi = (Select Adi from Personeller Where PersonelID = 3)

-- Update sorgusunda Top keywordu ile guncellem yapmak
Update Top(30) Urunler Set UrunAdi = 'x'






-- Delete 

-- Delete from [Tablo adi]

Delete from Urunler -- sart eklemezsen ilgili tablonun butun verilerini silecektir.

-- Delete sorgusuna where sarti yazmak
Delete from Urunler Where KategoriID < 3


-- Dikkat edilmesi gerekenler
-- Delete sorgusuyla tablo icerisindeki tum verileri silmeniz identity kolonunu sifirlamayacaktir.
-- Silme isleminden sonra ilk eklenen veride kalindigi yerden id degeri verilecektir.