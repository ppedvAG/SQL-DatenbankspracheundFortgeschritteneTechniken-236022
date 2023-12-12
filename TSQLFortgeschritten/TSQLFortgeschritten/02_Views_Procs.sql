-- Sichten   Prozeduren
drop table slf
drop view vslf

create table slf(id int identity, stadt int, land int)

insert into slf
select 10,100
UNION ALL
select 20, 200
UNION ALL
select 30, 300

select * from slf

create view vslf with schemabinding --jetzt musste genau arbeiten!! ätsch
as
select id, stadt , land from dbo.slf

select * from vslf

alter table slf add Fluss int
update slf set fluss = id * 1000


select * from sys.views

select * from [INFORMATION_SCHEMA].[VIEWS]
where VIEW_DEFINITION like '%schemabinding%'




--Prozeduren.. Warum?
--ähnlich wie Windows Batchdateien
--Proz kann INS UP DEL SEL .. enthalten

--aufruf

exec procname 100

create or alter proc gpdemo @par1 int, @par2 int
as
Code
(INS UP DEL SEL SEL SEL..)



create or alter proc gpdemo @zahl1 int
as
select @zahl1 *100
GO

exec gpdemo 10

--Prozeduren sind schneller, weil Plan kompiliert vorliegt auch nach Neustart
--beim ersten Aufruf


select * from orders where orderid = 10250


select * from slf
select * from vslf --fluss

alter table slf drop column land

select * from vslf


create proc ProcName @par1 int, ... , @par2 int output
as
Code...(SEL INS UP DEL EXEC Proc)
GO


--Idee
set statistics io, time on
select * from kundeumsatz where id < 10;
GO

create proc gpdemox @zahl int
as
 select * from kundeumsatz where id < @zahl	;
 GO

 exec gpdemox 10


 dbcc freeproccache


select * from kundeumsatz where id < 500000;


exec gpKundenSuche 	  'A' --4
exec gpKundenSuche 	  'ALFKI' --1
exec gpKundenSuche 	  '%' -- alle		oder alternativ nichts angeben , dann auch alle


select * from customers where customerid 	--nchar(5)


 create or alter proc gpKundenSuche @CustId nvarchar(5)	  ='%'		  --default WERT
 as
 select * from customers where customerid like @CustId	+'%'	;
 GO

exec gpKundenSuche 	  'A%' --4
exec gpKundenSuche 	  'ALFKI' --1
exec gpKundenSuche 	  


create or alter proc gpKundenSuche @CustId nvarchar(5)	  ='%'		  --default WERT
 as
 if @CustId ='%' exec gpKundenSucheScan
 else
 exec gpKundenSucheSeek
 
 select * from customers where customerid like @CustId	+'%'	;
 GO


declare @var as varchar(150)
... 50%

select .. @var --> 1000 DS
order by 

create proc gpdemoy @par int
as
If @par = 1
	select * from orders where orderid < 100	 
else
 select * from customers where country = 'USA'



