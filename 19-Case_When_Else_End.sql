USE Northwind

-- Case - When - Else - End

-- Personellerimizin isim ve soyisimlerinin yaninda: UnvanEki 'Mr.' ise 'Erkek', 'Ms.' ise 'Kadin' yazsin.
Select Adi, SoyAdi, UnvanEki from Personeller

Select
Adi, SoyAdi,
Case
When UnvanEki = 'Mrs.' or UnvanEki = 'Ms.' Then 'Kadin'
When UnvanEki = 'Mr.' Then 'Erkek'
Else UnvanEki
End
from Personeller


-- Eger urunun birim fiyati:
-- 0 - 50 arasi ise 'Cin Mali',
-- 50 - 100 arasi ise 'Ucuz',
-- 100 - 200 arasi ise 'Normal',
-- 200'den fazla ise 'Pahali'

Select UrunID, BirimFiyati from Urunler

Select
UrunID,
Case
When BirimFiyati Between 0 and 50 Then 'Cin Mali'
When BirimFiyati < 100 Then 'Ucuz'
When BirimFiyati < 200 Then 'Normal'
When BirimFiyati > 200 Then 'Pahali'
Else 'Belirsiz'
End
from Urunler