USE Northwind

-- Subquery (Ic Ice Sorgular)
-- Subquery'den sadece bir tane sonuc donmelidir. (Birden fazla deger donmemeli)

Select s.SatisID, s.SatisTarihi from Personeller p Inner Join Satislar s on p.PersonelID = s.PersonelID Where p.Adi = 'Nancy'
-- veya
Select SatisID, SatisTarihi from Satislar Where PersonelID = (Select PersonelID from Personeller Where Adi = 'Nancy')


Select Adi from Personeller Where UnvanEki = 'Dr.'
-- veya
Select * from Personeller Where Adi = (Select Adi from Personeller Where UnvanEki = 'Dr.')