-- Fonksiyonlar - Scalar Fonksiyon - Inline Fonksiyon

-- T-SQL'de iki tip fonksiyon vardir:
-- 1. Scalar Fonksiyonlar = Geriye istedigimiz bir tipte  deger gonderen fonksiyon.
-- 2. Inline Fonksiyonlar = Geriye tablo gonderen fonksiyon.


-- Bu her iki fonksiyonda fiziksel olarak veritabaninda olusturulmaktadir.
-- Create komutu ile olusturulmaktadir.
-- Uzerinde calisilan database'in Programmability -> Functions kombinasyonundan olusturulan fonskiyonlara erisebilmekteyiz.


-- === 1. Scalar Fonksiyonlar ===

-- Fonksiyon tanimlama
-- Scalar fonksiyonlara tanimlandiktan sonra Programmability -> Functions -> Scalar-valued Functions kombinasyonundan erisilebilir.
Create Function Topla(@Sayi1 int, @Sayi2 int) Returns int
As
	Begin
		return @Sayi1 + @Sayi2
	End

-- Fonskiyon Kullanimi
-- Fonksiyon kullanirken semasiyla beraber cagirilmalidir.
Select dbo.Topla(2, 5)
print dbo.Topla(10, 20)


-- Ornek
-- "Northwind" veritabaninda; herhangi bir urunun %18 KDV dahil olmak uzere toplam maliyetini getiren fonksiyon yazalim.
Create Function Maliyet(@BirimFiyati int, @StokMiktari int) Returns nvarchar(MAX)
As
	Begin
		Declare @Sonuc int = @BirimFiyati * @StokMiktari * 1.18
		return @Sonuc
	End

Select dbo.Maliyet(10, 20)






-- === 2. Inline Fonksiyonlar ===

-- Geriye bir deger degil, tablo gonderen fonksiyonlardir.

-- Geriye tablo gonderecegi icin bu fonksiyonlar calistirlirken sanki bir tablodan sorgu calistirilir givi calistirilirlar.
-- Bu yonleriyle Viewlara benzerler. View ile yapilan islevler Inline Functions'larla yapilabilir.

-- Genellikle viewle benzer islevler icin view kullanilmasi oneriliyor.


-- Fonksiyon Tanimlama
-- Inline fonksiyonlara tanimlandiktan sonra Programmability -> Functions -> Table-valued Functions kombinasyonundan erisilebilir.

-- Dikkat!!
-- Inline Function olusturulurken Begin End yapisi kullanilmaz.

Create Function fc_Gonder(@Ad nvarchar(20), @Soyad nvarchar(20)) Returns Table
As
	return Select Adi, SoyAdi from Personeller Where Adi = @Ad and SoyAdi = @Soyad


-- Fonksiyon Kullanimi
-- Fonksiyonu semasiyla birlikte cagirmak gerekmektedir.

Select * from dbo.fc_Gonder('Nancy', 'Davolio')







-- === Fonksiyonlarda With Encryption Komutu === 
-- Eðer ki yazmýþ olduðumuz fonksiyonlarýn kodlarýna ikinci üçüncü þahýslarýn eriþimini engellemek istiyorsak "With Encryption" Komutunu kullanmalýyýz.

-- "With Encryption" Ýþleminden sonra fonksiyonu oluþturan kiþi de dahil kimse komutlarý göremez. Geri dönüþ yoktur. 
-- Ancak fonksiyonu oluþturan þahsýn komutlarýn yedigini bulundurmasý gerekmektedir. Ya da "With Encryption" Olmaksýzýn fonksiyonu yeniden alterlamalýyýz.
-- "With Encryption" "As" keywordunden once kullanilmalidir.
Create Function OrnekFonksiyon() Returns int
With Encryption
As
	Begin
		return 3
	End

Create Function OrnekFonksiyon2() Returns Table
With Encryption
As
	return Select * from Personeller