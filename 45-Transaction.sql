-- Transaction

-- Birden �ok i�lemin bir arada yap�ld��� durumlarda e�er par�ay� olu�turan i�lemlerden herhangi birinde sorun olursa
-- t�m i�lemi iptal ettirmeye yarar

-- �rne�in kredi kart� ile al��veri� i�lemlerinde transaction i�lemi vard�r. 
-- Siz marketten �r�n al�rken sizin hesab�n�zdan para d���recek, marketin hesab�na para aktar�lacakt�r.
-- Bu i�lemde hata olmamas� gerekir ve bundan dolay� bu i�lem bir transaction blogunda ger�ekle�tirilmelidir.
-- Bu esnada herhangi bir sorun olursa b�t�n i�lemler transaction taraf�ndan iptal edilebilecektir.

-- Begin Tran veya Begin Transaction : Transaction i�lemini ba�lat�r.

-- Commit Tran : Transaction ��leminin ba�ar�yla sona erdirir. ��lemleri ger�ekle�tirir.

-- Rollback Tran : Transaction ��lemini iptal eder. ��lemlere geri al�r.

-- Commit Tran yerine sadece Commit yaz�labilir
-- Rollback Tran yerine sadece Rollback yaz�labilir.

-- Normalde default olarak her �ey begin Tran ile ba�lay�p, Commit Tran ile biter. Biz bu yap�lar� kullanmasak bile!!!


-- === Transaction Tanimlama ===
-- Prototip
-- Begin Tran [Transaction Adi]
-- Islemler

-- Varsayilan olarak transaction kontrolunde bir islemdir. Netice olarak yine varsayilan olarak Commit Tran olarak bitmektedir.
Insert Bolge Values(5, 'Corum')

Begin Tran Kontrol
Insert Bolge Values(5, 'Corum') 
Commit Tran


-- Transactiona isim vermek zorunda degiliz
Begin Tran 
Insert Bolge Values(5, 'Corum') 
Commit Tran



-- Ornek 1

Begin Tran Kontrol
Declare @i int
Delete from Personeller Where PersonelID > 20
Set @i = @@ROWCOUNT
If @i = 1
	Begin
		print 'Kayit silindi.'
		Commit -- ya da Commit Tran
	End
Else
	Begin
		print 'Islemler geri alindi.'
		Rollback -- ya da Rollback Tran. Butun islemleri geri aldik.
	End
Commit Tran




-- Ornek 2
-- Iki adet banka tablosu olusturalim. Bankalar arasi havale islemi gerceklestirelim ve bu islemleri yaparken transaction kullanalim.

Create Database BankaDb
Go
USE BankaDb
Go
Create Table ABanka
(
	HesapNo int,
	Bakiye money
)
Go
Create Table BBanka
(
	HesapNo int,
	Bakiye money
)
Go
Insert ABanka Values(10, 1000), (20, 2500)
Insert BBanka Values(30, 2300), (40, 760)
Go
Create Proc sp_HavaleYap
(
	@BankaKimden nvarchar(MAX),
	@GonderenHesapNo int,
	@AlanHesapNo int,
	@Tutar money
)as
Begin Tran Kontrol
Declare @ABakiye int, @BBakiye int, @HesaptakiPara money
If @BankaKimden = 'ABanka'
	Begin
		Select @HesaptakiPara = Bakiye from ABanka Where HesapNo = @GonderenHesapNo
		If @Tutar > @HesaptakiPara
			Begin
				print CAST(@GonderenHesapNo as nvarchar(MAX)) + ' numarali hesapta, gonderilmek istenen tutardan az para mevcuttur.'
				Rollback -- Islemleri geri al
			End
		Else
			Begin
				Update ABanka Set Bakiye = Bakiye - @Tutar Where HesapNo = @GonderenHesapNo
				Update BBanka Set Bakiye = Bakiye + @Tutar Where HesapNo = @AlanHesapNo
				print 'ABankasindaki ' + CAST(@GonderenHesapNo as nvarchar(MAX)) + ' numarali hesaptan BBankasindaki ' +
					CAST(@AlanHesapNo as nvarchar(MAX)) + ' numarali hesaba ' + CAST(@Tutar as nvarchar(MAX)) + ' degerinde para havale edilmistir.'

				Select @ABakiye = Bakiye from ABanka Where HesapNo = @GonderenHesapNo
				Select @BBakiye = Bakiye from BBanka Where HesapNo = @AlanHesapNo
				print 'ABankasindaki ' + CAST(@GonderenHesapNo as nvarchar(MAX)) + ' numarali hesapta kalan bakiye : ' +
					CAST(@ABakiye as nvarchar(MAX))
				print 'BBankasindaki ' + CAST(@AlanHesapNo as nvarchar(MAX)) + ' numarali hesapta kalan bakiye : ' +
					CAST(@BBakiye as nvarchar(MAX))
				Commit
			End
		
	End
Else
	Begin
		Select @HesaptakiPara = Bakiye from BBanka Where HesapNo = @GonderenHesapNo
		If @Tutar > @HesaptakiPara
			Begin
				print CAST(@GonderenHesapNo as nvarchar(MAX)) + ' numarali hesapta, gonderilmek istenen tutardan az para mevcuttur.'
				Rollback -- Islemleri geri al
			End
		Else
			Begin
				Update BBanka Set Bakiye = Bakiye - @Tutar Where HesapNo = @GonderenHesapNo
				Update ABanka Set Bakiye = Bakiye + @Tutar Where HesapNo = @AlanHesapNo
				print 'BBankasindaki ' + CAST(@GonderenHesapNo as nvarchar(MAX)) + ' numarali hesaptan ABankasindaki ' +
					CAST(@AlanHesapNo as nvarchar(MAX)) + ' numarali hesaba ' + CAST(@Tutar as nvarchar(MAX)) + ' degerinde para havale edilmistir.'

				Select @BBakiye = Bakiye from BBanka Where HesapNo = @GonderenHesapNo
				Select @ABakiye = Bakiye from ABanka Where HesapNo = @AlanHesapNo
				print 'BBankasindaki ' + CAST(@GonderenHesapNo as nvarchar(MAX)) + ' numarali hesapta kalan bakiye : ' +
					CAST(@ABakiye as nvarchar(MAX))
				print 'ABankasindaki ' + CAST(@AlanHesapNo as nvarchar(MAX)) + ' numarali hesapta kalan bakiye : ' +
					CAST(@BBakiye as nvarchar(MAX))
				Commit
			End
	End


Exec sp_HavaleYap 'ABanka', 10, 30, 100
Exec sp_HavaleYap 'BBanka', 30, 10, 300
