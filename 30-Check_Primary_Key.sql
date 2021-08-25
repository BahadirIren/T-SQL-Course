USE Northwind

-- Bir tablonun Primary Key'e sahip Olup olmadigini kontrol etme

Select OBJECTPROPERTY(OBJECT_ID('Personeller'), 'TableHasPrimaryKey')