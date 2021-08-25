USE Deneme

-- Outer Join

-- Outer Joinde eslesmeyen kayitlar getirilmektedir.


-- Left Join
-- Join ifadesinin solundaki tablodan tum kayitlari getirir. Sagindaki tablodan eslesenleri yan yana, eslesmeyenleri null olarak getirir.
Select * from Oyuncular o Left Join Filmler f on o.FilmId = f.FilmId
Select * from Filmler f Left Join Oyuncular o on o.FilmId = f.FilmId


-- Right Join
-- Joinin sagindaki tablonun tamamini getirecek, solundakinden eslesenleri ayni satirda, eslesmeyenleri de null olarak getirecek
Select * from Oyuncular o Right Join Filmler f on o.FilmId = f.FilmId
Select * from Filmler f Right Join Oyuncular o on o.FilmId = f.FilmId


-- Full Join
-- Joinin iki tarafindaki tablolardan eslesen eslesmeyen hepsini getirir
Select * from Oyuncular o Full Join Filmler f on o.FilmId = f.FilmId

