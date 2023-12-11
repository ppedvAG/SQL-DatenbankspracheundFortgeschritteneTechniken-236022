--001 Logische Reihenfolge

--Alias as 


use Northwind;
GO

select top 10 o.orderid as BestNr, sum(Freight) as SummeLieferkosten 
from Orders o
				inner join customers c on o.CustomerID=od.
				inner join [Order Details] od on od.OrderID=o.OrderID 
where 
			o.Freight< 1
group by Lieferkosten
order by	Lieferkosten

--FROM --> JOIN--> WHERE --> GROUP BY --> SELECT (Alias)-->  Order by 
----> TOP /Distinct --> Ausgabe


select shipcountry, customerid, sum(freight) as Fracht
from orders
where shipcountry = 'USA'
group by shipcountry, customerid having sum(freight)  > 200


--doof besser im where
select shipcountry, customerid, sum(freight) as Fracht
from orders
--where shipcountry = 'USA'
group by shipcountry, customerid having shipcountry = 'USA'


