--UNION 

/*

verknüpft zwei oder mehr SELECTS zu einem Ergebnis

*/

select 'A'
UNION 
select 'B'

select * into CustEU from customers where 
	country in ('UK','Italy', 'AUstria')


--eine Liste aller Kunden

select * from customers
union all --filtert nicht nach doppelten Ergtebnisteilen
select * from custEU

select 'A'
UNION ALL
select 'A'

--Bedingungen für UNION
--DAtentyp kompatibel
--und gleich viele Spalten
--die erste Ziele ist die ausschlaggebende (Spaltenname)
select companyname, customerid from customers
union
select lastname as Nachname, firstname from employees


--Aufgabe: 
--Orders (freight) > 500, dann 'C' Kunden
				-- < 100 dann 'A' 
				-- 100 bis 500 dann 'B'

--Ausgabe: BestNR, Customerid, freight, Kundentyp 


select	orderid, customerid, freight , 'C' as Ktyp
from	orders
where	freight > 500
UNION ALL
select	orderid, customerid, freight , 'B'
from	orders
where	freight between 100 and 500
UNION ALL
select	orderid, customerid, freight , 'A'
from	orders
where	freight < 100

--wie könnte man das schöner , einfacher...


--CASE when .. then .. END

select Customerid, country, 
		CASE
			when country = 'UK' then 'Noch EU'
			when country = 'Germany' then 'EU'
			else 'ka.'
		END as EOnotEU
from customers

--im when auch like , in between möglich
--ABC Analyse neu mit CASE...
select orderid, customerid,freight,
	case 
		when freight > 500 then 'C'
		when freight < 100 then 'A'
		else 'B'
	end as KTyp
from orders





--select * from orders

--welcher Kunde hat die höchsten Frachtkosten
--welcher die niedrigsten

--Ausgabe : orderid, customerid, freight

--2 Zeilen

--geht aber nicht....
select top 1 orderid, customerid,  freight
from orders
--order by freight desc
UNION ALL
select top 1 orderid, customerid,  freight
from orders
order by freight asc

--Im UNION dürfen die SELECT keinen order by haben

--entweder die einz Ergbenisse i temp Tabelle kopieren
--und dann ausgeben

--oder ein großes SELECT 
select * from 
(
select top 1 orderid, customerid,  freight
from orders order by freight desc
) t1
UNION ALL
select * from 
(
select top 1 orderid, customerid,  freight
from orders order by freight asc
) t2








select * from custeu
--einen ändern 
update custeu set city = 'Paderborn' 
	where customerid ='AROUT'

--einen einfügen

insert into custeu (Customerid, companyname, city, country)
values
				 ('PPEDV', 'ppedv ag', 'Bgh', 'Germany')


--Welche Zeilen sind zwischen diesen Tabellen
--Customers --custEU
-- identisch
--und welche nicht?

--identische
select * from customers
intersect
select * from custeu

select customerid from customers
intersect
select customerid from custeu

--unterschiedliche
--except
--hier macht die Reihenfolge einen Unterschied

select * from customers
except
select * from custeu

select * from customer

select * from custeu
except
select * from customers


select * from
 (select * from customers except select * from custeu) t1
UNION 
select * from
 (select * from custeu except select * from customers) t2


 select * from customers
 union
 select * from custeu




select * from custeu
union
select * from customers








