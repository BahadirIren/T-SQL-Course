-- View Yapisi

-- ==== Kullanim Amaci ====
-- Genellikle karmasik sorgularin tek bir sorgu uzerinden calistirilabilmesidir.
-- Bu amacla raporlama islemlerinde kullanilabilirler.
-- Ayni zamanda guvenlik ihtiyaci oldugu durumlarda herhangi bir sorgunun 2 ve 3. sahislardan gizlenmesi amaciyla da kullanilirlar.


-- ==== Genel Ozellikleri ====
-- Herhangi bir sorgunun sonucunu tablo olarak ele alip, ondan sorgu cekilebilmesini saglar.
-- Insert, Update, Delete yapabilirler. Bu islemleri fiziksel tabloya yansitirlar. **Onemli**
-- View yapilari fiziksel olarak olusturulan yapilardir,
-- View yapilari normal sorgulardan daha yavas calisirlar.


-- Dikkat!!
-- Database elemanlarini Create komutuyla olusturyorduk. View yapisinda bir database yapisi oldugu icin create komutu ile olusturacagiz.

Create View vw_Gotur
As
Select p.Adi + ' ' + p.SoyAdi [Adi Soyadi], k.KategoriAdi [Kategori Adi], COUNT(s.SatisID) [Toplam Satis] from Personeller p 
	Inner Join Satislar s on p.PersonelID = s.PersonelID
	Inner Join [Satis Detaylari] sd on s.SatisID = sd.SatisID
	Inner Join Urunler u on u.UrunID = sd.UrunID
	Inner Join Kategoriler k on k.KategoriID = u.KategoriID 
Group By p.Adi + ' ' + p.SoyAdi, k.KategoriAdi

Select * from vw_Gotur
Select * from vw_Gotur Where [Adi Soyadi] Like '%Robert%'

-- View olusturulurken kolonlara verilen aliaslar View'den sorgu cekilirken kullanilir.
-- Bir yandan da View'in kullandigi gercek tablolarin kolon isimler, view icinde alias tanimlanarak gizlenilmis olunur.
-- "Order By" view icinde degil, view calisirken sorgu esnasinda kullanilmalidir.

Select * from vw_Gotur order by [Toplam Satis]


-- Yok eger illaki ven view icinde "order by" kullanacagim diyorsak view icinde "top" komutunu kullanmaliyiz.
Create View vw_Gotur
As
Select Top 100 p.Adi + ' ' + p.SoyAdi [Adi Soyadi], k.KategoriAdi [Kategori Adi], COUNT(s.SatisID) [Toplam Satis] from Personeller p 
	Inner Join Satislar s on p.PersonelID = s.PersonelID
	Inner Join [Satis Detaylari] sd on s.SatisID = sd.SatisID
	Inner Join Urunler u on u.UrunID = sd.UrunID
	Inner Join Kategoriler k on k.KategoriID = u.KategoriID 
Group By p.Adi + ' ' + p.SoyAdi, k.KategoriAdi order by [Toplam Satis]
-- Bu durum cok tavsiye edilen bir durum degildir.

-- View uzerinde Insert, Delete ve update yapilabilir. Bu islemler fiziksel tabloya yansitilmaktadirlar.
Create View OrnekViewPersoneller
As
Select Adi, SoyAdi,Unvan from Personeller

Insert OrnekViewPersoneller Values('Bahadir', 'Iren','Yzlm. Muh.')
Update OrnekViewPersoneller Set Adi = 'bahadir' where Adi = 'Bahadir'
Delete from OrnekViewPersoneller Where Adi = 'Bahadir'





-- === With Encryption Komutu ===
-- Eger yazdigimiz view'in kaynak kodlarini, Object Explorer penceresinde "Views" kategorisinde sag tiklayarak Design Modda acip
-- goruntulenmesini istemiyorsak "With Encryption" komutu ile Viewi olusturmaliyiz.

-- Dikkat!!
-- "With Encryption" isleminden sonra View'i olusturan kisi de dahil kimse komutlari goremez. Geri donusu yoktur. Ancak view'i olusturan
-- sahsin komutlarin yedegini bulundurmasi gerekmektedir ya da "With Encryption" olmaksizin view yapisini yeniden alterlamaliyiz.

-- Dikkat!!
-- "With Encryption" ifadesini "as" keywordunden once yazmaliyiz.

Create View OrnekViewPersoneller
With Encryption
As
Select Adi, SoyAdi,Unvan from Personeller
-- Bu islemi yaptiktan sonra Design Modu kapatilmistir.






-- === With Schemabinding Komutu === 
-- Eðer viewin kullandýðý esas fiziksel tablolarýn kolon isimleri bir þekilde deðiþtirilir,
-- kolonlarý silinir ya da tablosu yapisi bir þekilde deðiþikliðe uðrar ise viewin çalýþmasý artýk mümkün olmayacaktýr.

-- Viewin kullandýgi tablolar ve kolonlarý bu tarz iþlemler yapabilmesi ihtimaline karþý koruma altýna alýnabilir
-- Bu koruma "With Schemabinding" Komutu ile yapýlabilir.

-- "With Schemabinding" Ýle View Create ya da alter edilirken, view'in kullandýðý tablo, schema adýyla birlikte verilmelidir.
-- Orneðin dbo(database owner) bir sema adidir. Semalar C#'taki namespaceler gibi dusunulebilir.

-- "With Schemabinding" komutu "As" keywordunden once yazilmalidir.

Create Table OrnekTablo
(
	Id int primary key identity(1,1),
	Kolon1 nvarchar(MAX)
)

Create View OrnekView
With Schemabinding
As
Select Id, Kolon1 from dbo.OrnekView

Alter Table OrnekTablo
Alter Column Kolon1 int






-- === With Check Option Komutu ===
-- Viewin icerisindeki sorguda bulunan sarta uygun kayitlarin Insert edilmesine musade edilip, uymayan kayitlarin musade edilmemesini
-- saglayan bit komuttur.

Create View OrnekView2
As
Select Adi, SoyAdi from Personeller Where Adi = 'a%'

Insert OrnekView2 Values('Ahmet', 'Bilmemneoglu')
-- bas harfi a disinda bir sey eklersem ben OrnekView2 yi cektigimde hicbir zaman goster bu veriyi gosteremeyecegim.
-- Bunun icin With Check Option kullaniyoruz.
Insert OrnekView2 Values('Bahadir', 'Iren') 

Select * from OrnekView2


-- "With Encryption" ve "With Schemabinding" komutlari "As" keywordunde once belirtilirken "With Check Option" komutu Where sartindan
-- sonra belirtilmelidir.

Create View OrnekView2
As
Select Adi, SoyAdi from Personeller Where Adi = 'a%'
With Check Option