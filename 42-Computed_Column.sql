-- === Otomatik Hesaplanabilir Kolonlar - (Computed Column) ===
-- Herhangi bir kolonda fonksiyon kullanilarak otomatik hesaplanabilir kolonlar (Computed Column) olusturmak mumkundur.

-- Ornek
-- Cikti olarak "____ kategorisindeki ____ urununun toplam fiyati: ___'dir."
-- Seklinde cikti veren fonksiyon yazalim.
Create Function Rapor(@Kategori nvarchar(MAX), @UrunAdi nvarchar(MAX), @BirimFiyati int, @Stok int) Returns nvarchar(MAX)
As
	Begin
		Declare @Cikti nvarchar(MAX) = @Kategori + ' kategorisindeki ' + @UrunAdi + ' urununun toplam fiyati : ' + 
		CAST(@BirimFiyati * @Stok As nvarchar(MAX)) + 'dir.'
		return @Cikti
	End

Select dbo.Rapor(k.KategoriAdi, u.UrunAdi, u.BirimFiyati, u.HedefStokDuzeyi) from Urunler u Inner Join Kategoriler k on u.KategoriID = k.KategoriID