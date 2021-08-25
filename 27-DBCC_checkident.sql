USE Northwind

-- Identity Kolonuna Mudahele etme

-- artik identity'yi 45'den sonra devam ettir
DBCC Checkident(Personeller, reseed, 45)