USE Northwind

-- Cross Join
-- Kartezyen carpim yapar. Where ile sart veremeyiz

Select COUNT(*) from Personeller
Select COUNT(*) from Bolge

Select p.Adi, b.BolgeID from Personeller p Cross Join Bolge b