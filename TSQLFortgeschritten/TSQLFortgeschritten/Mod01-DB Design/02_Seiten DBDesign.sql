--8 Seiten am Stück = Block  HDD 64 Kb Formatierung

set statistics io, time on
select * from t1 where id = 100 --+ 160MB im RAM wg 20000 Seiten
--, CPU-Zeit = 31 ms, verstrichene Zeit = 59 ms.


--Kompression: Zeilen, Seiten

set statistics io, time on
select * from t1 where id = 100

----Neustart des Server: RAM gleich !
--RAM nach Abfrage: mehr, weniger, oder gleich
--CPU: mehr
--Dauer: weniger

--normalerweise 40 bis 60% Kompression-- t1 von 156MB--> 250kb


--A 10000 DS 
--B 1000000 DS

--Abfrage, die immer 10 Ergebniszeilen
--A oder B 
--A

create table u2023(id int, jahr int, spx int)

create table u2022(id int, jahr int, spx int)


create table u2021(id int, jahr int, spx int)

create table u2020(id int, jahr int, spx int)

--Anwendung

select * from umsatz

create view Umsatz
as
select * from u2023
UNION ALL
select * from u2022
UNION ALL
select * from u2021
UNION ALL
select * from u2020



select * from umsatz where jahr = 2023




--f()

------------------100]--------------------------200]---------------------------int
--       1                     2                                    3


create partition function fzahl(int)
as
range left for values(100,200)

select $partition.fzahl(117) --2

--Dgruppen

create table tx(id int) on PRIMARY

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis100daten', FILENAME = N'C:\_SQLDATA\bis100daten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis200daten', FILENAME = N'C:\_SQLDATA\bis200daten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis5000', FILENAME = N'C:\_SQLDATA\bis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'restdaten', FILENAME = N'C:\_SQLDATA\restdaten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO


create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
--                      1    2     3



























