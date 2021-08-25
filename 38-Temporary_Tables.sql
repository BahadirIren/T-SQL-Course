-- Gecici Tablolar - Temporary Tables

-- Genellikle bir SQL Server uzerinde farkli lokasyonlarda birden fazla kisinin calistigi durumlarda ya da verilerin test amacli gecici
-- bir yerlerde tutulmasi, islenmesi amaciyla kullanilan yapilardir.

-- Bilinen tablo yapisinin aynisini saglarlar. Tek farklari fiziksel olarak olusmazlar. Sadece bellekte gecici olarak olusturulurlar.

-- Select, Insert, Update ve Delete Islemleri yapilabilir. Iliski kurulabilir.

-- Sonucu kapatildiginda ya da oturum sahibi oturumu kapattiginda bellekten silinirler.

-- Bir Tabloyu Fiziksel Olarak Kopyalama
Select * Into GeciciPersoneller from Personeller
-- Bu sekilde bit kullanimda sadece primary key ve foreign key constraintler olusturulmazlar. Geri kalan her sey birebir fiziksel olarak olusturulur.



-- Bir tabloyu # ifadesi ile bellege gecici olarak kopyalama
Select * Into #GeciciPersoneller from Personeller

Select * from #GeciciPersoneller
Insert #GeciciPersoneller(Adi,SoyAdi) Values('Bahadir', 'Iren')
Delete from #GeciciPersoneller Where PersonelID = 3
Update #GeciciPersoneller Set Adi = 'Hilmi', SoyAdi = 'Celayir' Where PersonelID = 5

-- Gecici tablo uzerinde her turlu islemi yapabiliyoruz
-- # ile olusturulan tablo, o an SQL Serverda oturum acmis kisinin sunucu belleginde olusur.
-- Sadece oturum acan sahis kullanabilir.
-- Eger oturum acan sahis SQL Serverdan disconnect olursa bu tablo bellekten silinir.




-- Bir tabloyu ## ifadesi ile Bellege gecici olarak kopyalama
Select * Into ##GeciciPersoneller2 from Personeller

Select * from ##GeciciPersoneller2
Insert ##GeciciPersoneller2(Adi,SoyAdi) Values('Bahadir', 'Iren')
Delete from ##GeciciPersoneller2 Where PersonelID = 3
Update ##GeciciPersoneller2 Set Adi = 'Hilmi', SoyAdi = 'Celayir' Where PersonelID = 5

-- ## ile olusturulan tablo, o an SQL Serverda oturum acmis kisinin sunucu belleginde olusur.
-- Bu tabloyu oturum acan sahis ve onun SQL Serverina disardan ulasan 3. sahislar kullanabilir
-- Sadece oturum acan sahis kullanabilir.
-- Eger oturum acan sahis SQL Serverdan disconnect olursa bu tablo bellekten silinir.
-- Diger butun ozellikleri # ile olusturulan tablo ile aynidir.