--Salamitaktik


--grosse Tabellen werden kleiner

--Tabelle Umsatz 

---Abfrage mit 10 Zeilen als Ergebnis
--Tab A  10000
--Tab B  100000

create table u2024(id int identity, jahr int, spx int)

create table u2023(id int identity, jahr int, spx int)

create table u2022(id int identity, jahr int, spx int)

create table u2021(id int identity, jahr int, spx int)


select * from umsatz

create view Umsatz
as
select * from u2022 
UNION ALL
select * from u2023
UNION ALL
select * from u2024 
UNION ALL
select * from u2021 

select * from umsatz where id = 2022
select * from umsatz where jahr = 2022


--auch bei NULL bzw NOT null


ALTER TABLE dbo.u2023 ADD CONSTRAINT
	CK_u2023 CHECK (jahr=2023)

ALTER TABLE dbo.u2024 ADD CONSTRAINT
	CK_u2024 CHECK (jahr=2024)

ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)




--Problem der Sicht...
--Sicht wie Tabellen .. also auch Rechte , INS UP DEL SEL

insert into umsatz (id,jahr,spx) values (next value for seqID,2022, 100)
select * from umsatz
--wie würde man die nächste Id bekommen..?
USE [Northwind]

GO

CREATE SEQUENCE [dbo].[seqID] 
 START WITH 2
 INCREMENT BY 1

GO

select next value for seqID

--Part..

--#1: Dateigruppe
USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwhotdata', FILENAME = N'C:\_SQLDATA\nwhotdata.ndf' , SIZE = 10240KB , FILEGROWTH = 65536KB ) TO FILEGROUP [HOT]
GO


create table test2 (id int) on HOT


--Dateigruppen: bis100, bis200, bs5000, rest


USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis100daten', FILENAME = N'C:\_SQLDATA\bis100daten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis200daten', FILENAME = N'C:\_SQLDATA\bis200daten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'bis5000', FILENAME = N'C:\_SQLDATA\bis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bs100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'restdaten', FILENAME = N'C:\_SQLDATA\restdaten.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO

-- - 2,1 Mrd----- 100---------------200]--------------------------  + 2,1 Mrd
--  1            2                               3

--f(117) --> 2 
select dbo.fzahl(117) --- 1  oder 2 oder 3

create partition function fzahl(int)
as
RANGE LEFT FOR VALUES(100,200)

select $partition.fzahl(1170) ---2  max 15000 Bereiche

/*

create function fzahl(@zahl int) returns int
as
BEGIN
	return (select case
							when @zahl < 100 then 1
							when @zahl between 101 and 200 then 2
					end
END
*/


create partition scheme schemaZahl
as
partition fzahl to (bs100, bis200, rest)
----                  1       2       3
drop table if exists parttab

create table parttab
		(id int identity, nummer int, spx char(4100))
		ON schemaZahl(nummer)
--Schleife für Insert

--Dnkee daran : jede TX muss ins Logfile notiert werden

declare @i as int = 1
begin tran
while @i <= 20000
	begin
	--break
	--continue
		insert into parttab (nummer, spx) values (@i, 'XY')
		set @i+=1 --set @i=@i+1
	end
commit




set statistics io, time on

select * from parttab where id = 117
select * from parttab where nummer = 117


-----100-----200----------------5000--------
select * from parttab where nummer = 333

--neue Grenze bei 5000
--Dgruppen: neue Dgruppe bis5000
--Tabelle: nie never 
--F(): ja  brauche 4
--schema: ja.. was ist 4 


alter partition scheme schemaZahl  next used bis5000

select $partition.fzahl(nummer) , max(nummer), min(nummer), count(*)
from parttab
group by $partition.fzahl(nummer)

1	100	1	100
2	200	101	100
3	20000	201	19800

----100----200---------------5000-------------------

alter partition function fZahl() split range (5000)

1	100	1	100
2	200	101	100
3	5000	201	4800
4	20000	5001	15000

select * from parttab where nummer = 333---

-- Grenze entfernen
-------------------------100----200--------5000------------

alter partition function fzahl() merge range (100)

select * from parttab where nummer = 117



--

--Vorsicht
-- AbisM   NbisR  SbisZ
create partition function fzahl(varchar(50))
as
RANGE LEFT FOR VALUES('M','S')

---------------------N]Nai-----------------------------x--------------------


create partition function fzahl(datetime)
as
RANGE LEFT FOR VALUES('31.12.2023 23:59:59.997','',...,..)

-----


create partition scheme schemaZahl
as
partition fzahl all to (HOT)

--geht das (ja) und machts Sinn(ja)?

--partitionen sind effektiv Tabellen auf der Physik


select * from parttab where nummer = 5015


--SEEK   SCAN




































