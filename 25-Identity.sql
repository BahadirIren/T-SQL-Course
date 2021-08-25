USE Northwind

-- @@identity Komutu

Insert Kategoriler(KategoriAdi, Tanimi) Values('x','x kategorisi')
Select @@IDENTITY  -- en son insert edilenin, identity degerini getirir.