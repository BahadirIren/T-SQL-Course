USE Northwind

-- Null deger Kontrolu


-- Case - When - Then - Else - End Kalibi ile Null Kontrolu

Select MusteriAdi, Bolge from Musteriler

Select MusteriAdi,
Case
When Bolge is null Then 'Bolge Bilinmiyor'
Else Bolge
End
from Musteriler


-- Coalesce Fonksiyonu ile Null Kontrolu
Select MusteriAdi, Coalesce(Bolge, 'Bilinmiyor') Bolge from Musteriler

-- IsNull Fonksiyonu ile Null Kontrolu
Select MusteriAdi, IsNull(Bolge, 'Bilinmiyor') Bolge from Musteriler

-- NullIf Fonksiyonu ile Null Kontrolu
-- Fonksiyona verilen kolon, ikinci parametre verilen degere esit ise o kolon null olarak getirir.
Select NullIf(0,0)



Select HedefStokDuzeyi from Urunler
Select AVG(HedefStokDuzeyi) from Urunler

-- Hedef stok duzeyi 0 olmayan urunlerin ortalamasi nedir?
Select AVG(HedefStokDuzeyi) from Urunler Where HedefStokDuzeyi <> 0
-- veya
Select AVG(NullIf(HedefStokDuzeyi, 0)) from Urunler