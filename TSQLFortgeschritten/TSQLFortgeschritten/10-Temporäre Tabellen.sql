---tempor�re Tabellen

--#t   ##t
--# lokale temp Tabelle
--## globale temp tabellen

--Lebenszeit
--lebt bis sie gel�scht wird
--oder der Ersteller die Session schliesst

select * into #t1 from orders
select * into ##t1 from orders

select * from #t1


--warum tempor�re tabellen
 --suche nach den h�chste Frachtkosten pro ang
select * from orders

select avg(maxfracht) from
(
select employeeid , max(freight)  as MaxFracht
from orders 
group by employeeid
 ) t


 select employeeid , max(freight)  as MaxFracht
into #result from orders 
group by employeeid


select avg(maxfracht) from #result		

