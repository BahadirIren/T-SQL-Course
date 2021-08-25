-- If - Else

-- <> : Esit degilse
-- =  : Esitse
-- <  : Kucukse
-- >  : Buyukse


-- Tek satirli calisma

Declare @Isim nvarchar(MAX)
Set @Isim = 'Bahadir'

If @Isim = 'Bahadir'
	print 'Evet'
Else
	print 'Hayir' 




-- Begin End Yapisi (Scope)

Declare @sayi1 int = 3
Declare @sayi2 int = 5

If @sayi1 < @sayi2
	Begin
		print 'Evet Sayi1 Sayi2''den kucuktur.'
		Select @sayi1 [Sayi 1], @sayi2 [Sayi 2]
	End
Else
	Begin
		print 'Hayir Sayi1 Sayi2''den kucuk degildir.'
		Select @sayi1 [Sayi 1], @sayi2 [Sayi 2]
	End


-- Ornek 1
-- Musteriler tablosunda Amerikali(USA) musteri var mi?
Select * from Musteriler Where Ulke = 'USA'

If @@ROWCOUNT > 0 -- kac tane satirin etkilendigini soyluyor. Eger sorguya uygun bir sey yoksa ROCOUNT 0 olacak bu da USA'li yok demektir.
	print 'Evet'
Else
	print 'Hayir'



-- Ornek 2
-- Adi 'Bahadir', soyadi 'Iren' olan Personel var mi? Varsa evet var desin. Yoksa kaydetsin.
Declare @adi nvarchar(MAX) = 'Baha', @soyadi nvarchar(MAX) = 'Iren'
Select * from Personeller Where Adi = @adi and SoyAdi = @soyadi

IF @@ROWCOUNT = 0
	Begin
		print 'Hayir yok.. ama eklendi!'
		Insert Personeller(Adi,SoyAdi) Values(@adi,@soyadi)
	End
Else
	print 'Evet var'






-- IF - Else If - Else Yapisi

Declare @Adi nvarchar(MAX) = 'Bahadir', @yas int = 25

If @Adi = 'Mahmut'
	print 'Evet Mahmut'

Else If @yas > 24
	print 'Yasi 24''den buyuk'
Else
	print 'abc'

