-- Transaction

-- Birden çok iþlemin bir arada yapýldýðý durumlarda eðer parçayý oluþturan iþlemlerden herhangi birinde sorun olursa
-- tüm iþlemi iptal ettirmeye yarar

-- Örneðin kredi kartý ile alýþveriþ iþlemlerinde transaction iþlemi vardýr. 
-- Siz marketten ürün alýrken sizin hesabýnýzdan para düþürecek, marketin hesabýna para aktarýlacaktýr.
-- Bu iþlemde hata olmamasý gerekir ve bundan dolayý bu iþlem bir transaction blogunda gerçekleþtirilmelidir.
-- Bu esnada herhangi bir sorun olursa bütün iþlemler transaction tarafýndan iptal edilebilecektir.

-- Begin Tran veya Begin Transaction : Transaction iþlemini baþlatýr.

-- Commit Tran : Transaction Ýþleminin baþarýyla sona erdirir. Ýþlemleri gerçekleþtirir.

-- Rollback Tran : Transaction Ýþlemini iptal eder. Ýþlemlere geri alýr.

-- Commit Tran yerine sadece Commit yazýlabilir
-- Rollback Tran yerine sadece Rollback yazýlabilir.

-- Normalde default olarak her þey begin Tran ile baþlayýp, Commit Tran ile biter. Biz bu yapýlarý kullanmasak bile!!!


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
