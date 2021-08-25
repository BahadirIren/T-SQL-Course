USE Northwind

-- Inner Join

-- Genel Mantik
-- Select * from Tablo1 Inner Join Tablo2 on Tablo1.IliskiliKolon = Tablo2.IliskiliKolon

-- Tablolara Alias tanimlanabilir
-- Select * from Tablo1 t1 Inner Join Tablo2 t2 on t1.IliskiliKolon = t2.IliskiliKolon


-- Iki Tabloyu Iliskisel Birlestirme

-- Hangi personel hangi satislari yapmistir. (Personller, Satislar)
Select p.PersonelID, s.SatisID from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID

-- Hangi urun hangi kategoride. (Urunler, Kategoriler)
Select u.UrunAdi, k.KategoriAdi from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID





-- Where komutunun Kullanilmasi

-- Beverages kategorisindeki urunlerim (Urunler, Kategoriler)
Select u.UrunAdi, k.KategoriAdi from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID Where k.KategoriAdi = 'Beverages'

-- Beverages kategorisindeki urunlerimin sayisi kactir (Urunler, Kategoriler)
Select COUNT(u.UrunAdi) from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID Where k.KategoriAdi = 'Beverages'

-- Seafood kategorisindeki urunlerin listesi (Urunler, Kategoriler)
Select u.urunAdi, k.KategoriAdi from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID Where k.KategoriAdi = 'Seafood'

-- Hangi satisi hangi calisanim yapmis? (Satislar, Personeller)
Select s.SatisID,  p.Adi + ' ' + p.SoyAdi from Satislar s Inner Join Personeller p on s.PersonelID = p.PersonelID

-- Faks numarasi "null" olmayan tedarikcilerden alinmis urunler nelerdir? (Urunler, Tedarikciler)
Select t.SirketAdi, u.UrunAdi from Urunler u Inner Join Tedarikciler t on u.TedarikciID = t.TedarikciID Where t.Faks <> 'null'
Select t.SirketAdi, u.UrunAdi from Urunler u Inner Join Tedarikciler t on u.TedarikciID = t.TedarikciID Where t.Faks is not null




-- Ikiden fazla tabloyu birlestirme

-- 1997 yilindan sonra Nancy'nin satis yaptigi firmalarin isimleri: (1997 dahil) (Personeller, Satislar, Musteriler)
Select YEAR(s.SatisTarihi) [Satis Tarihi],m.MusteriAdi from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID Inner Join Musteriler m on s.MusteriID = m.MusteriID
Where p.Adi = 'Nancy' and YEAR(s.SatisTarihi) >= 1997

-- Limited olan tedarikcilerden alinmis seafood kategorisindeki urunlerimin toplam satis tutari? (Tedarikciler, Kategoriler, Urunler)
Select SUM(u.HedefStokDuzeyi * u.BirimFiyati) from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID Inner Join Tedarikciler t on t.TedarikciID = u.TedarikciID
Where t.SirketAdi Like '%Ltd.%' and k.KategoriAdi = 'Seafood'





-- Ayni tabloyu iliskisel birlestirme

-- Personellerimin bagli olarak calistigi kisileri listele (Personeller, Personeller)
Select p1.Adi, p2.Adi from Personeller p1 Inner Join Personeller p2 on p1.BagliCalistigiKisi = p2.PersonelID




-- Inner Joinde Group By Kullanimi

-- Hangi personelim(adi ve soyadi ile birlikte), toplam kac adetlik satis yapmis? Satis adedi 100 den fazla olanlar ve personelin
-- adinin bas harfi "m" olan kayitlar gelsin. (Personeller, Satislar)
Select p.Adi + ' '+ p.SoyAdi, COUNT(s.SatisID) from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID
Where p.Adi Like 'm%' Group By p.Adi + ' '+ p.SoyAdi Having COUNT(s.SatisID) > 100 

-- Seafood kategorisindeki urunlerin sayisi? (Urunler, Kategoriler)
Select k.KategoriAdi,COUNT(u.UrunID) from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID Where k.KategoriAdi = 'Seafood'
Group By k.KategoriAdi

-- Hangi personelim toplam kac adet satis yapmis? (Personeller, Satislar)
Select p.Adi, COUNT(s.SatisID) from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID Group By p.Adi

-- En cok satis yapmis personelim? (Personeller, satislar)
Select top 1 p.Adi, COUNT(s.SatisID) from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID Group By p.Adi order by COUNT(s.SatisID) desc

-- Adinda "a" harfi olan personellerin satis id'si 10500 den buyuk olan satislarinin toplam tutarini(miktar * birimFiyat)
-- ve bu satislarin hangi tarihte gerceklestigini listele. (Personeller, Satislar, [Satis Detaylari])
Select SUM(sd.Miktar * sd.BirimFiyati) [Toplam Tutar], s.SatisTarihi from Satislar s Inner Join [Satis Detaylari] sd on s.SatisID = sd.SatisID Inner Join Personeller p on p.PersonelID = s.PersonelID
Where p.Adi Like '%a%' and s.SatisID > 10500 Group By s.SatisTarihi