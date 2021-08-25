USE Northwind

-- T-SQL ile veritabanindaki Tum Tablolari Listeleme

Select * from sys.tables
-- veya
Select * from sysobjects Where xtype = 'U'