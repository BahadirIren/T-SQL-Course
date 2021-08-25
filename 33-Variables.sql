-- Degiskenler

-- Declare keywordu ile degisken tanimlanir.

-- Prototip
-- Declare @DegiskenAid DegiskenTipi

Declare @x int

Declare @y nvarchar

Declare @z money

Declare @x int, @z nvarchar, @y bit

Declare @yas int = 3




-- Tanimlanmis degiskenlere deger atama

declare @age int = 3

declare @a int

-- SET
Set @a = 4


declare @tarih datetime
Set @tarih = GETDATE()




-- Degiskenin degerini okuma

declare @b int = 10
print @b
select @b -- tabloda yazdiracak






-- Sorgu sonucu gelen verileri degiskenlerle elde etme

declare @adi nvarchar(MAX), @soyadi nvarchar(MAX)
Select @adi = Adi, @soyadi = SoyAdi from Personeller Where PersonelID = 3
Select @adi, @soyadi

-- Dikkat!!
-- 1. sorgu sonucu gelen satir sayisi 1 adet olmalidir.
-- 2. Kolonlardaki verilerin tipleri ne ise o verileri temsil edecek degiskenlerin tipleri de benzer olmalidir.