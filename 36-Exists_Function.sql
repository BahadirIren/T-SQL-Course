-- Exists Fonksiyonu
-- Tablonun bos mu dolu mu oldugunu bulabiliyoruz


If Exists(Select * from Personeller)
	print 'dolu'
Else
	print 'bos'
