USE Northwind

-- Bulk Insert 
-- Kaynaktan ekleme

Bulk Insert Kisiler
From 'C:\Users\bahadir\Desktop\DeveloperWin\T-SQL\Kisiler.txt'
With
(
	FieldTerminator = '\t',
	RowTerminator = '\n'

)