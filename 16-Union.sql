USE Northwind

-- Union

-- Birden fazla select sorgusu sonucunu tek seferde alt alta gostermenizi saglar.

Select Adi, SoyAdi from Personeller
Select MusteriAdi, MusteriUnvani from Musteriler

Select Adi, SoyAdi from Personeller
Union
Select MusteriAdi, MusteriUnvani from Musteriler


-- 2' den fazla 
Select Adi, SoyAdi from Personeller
Union
Select MusteriAdi, MusteriUnvani from Musteriler
Union
Select SevkAdi, SevkAdresi from Satislar


-- Joinler yan yana, Unionlar alt alta tablolari birlestirir. Joinlerde belirli(iliskisel) bir kolon uzerinden birlestirme yapilirken,
-- Union'da boyle bir durum yoktur.


-- Dikkat edilmesi gereken kosullar:
-- Union sorgusunun sonucunda olusan tablonun kolon isimleri, ustteki sorgunun kolon isimlerinden olusturulur.
-- Ustteki sorgudan kac kolon cekilmisse alttaki sorgudan da o kadar cekilmek zorundadir.
-- Ustteki sorgudan cekilen kolonlarin tipleriyle, alttaki sorgudan cekilen kolonlarin tipleri uyumlu olmalidir.
-- Union tekrarli kayitlari getirmez.


-- Union'da kullanilan tablolara kolon eklenebilir. Dikkat etmemiz gereken nokta, yukaridaki kurallar cercevesinde asagiya da yukariya da
-- ayni sayida kolonlarin eklenmesi gerekmektedir.

Select Adi, SoyAdi, 'Personel' Kategori from Personeller
Union
Select MusteriAdi, MusteriUnvani, 'Musteri' from Musteriler





-- Union All

-- Union tekrarli kayitlari getirmez. Tekrarli kayitlari getirmek icin Union All Komutu kullanilmalidir.
Select Adi, SoyAdi from Personeller
Union All
Select Adi, SoyAdi from Personeller