select AngID, [1996], [1997], [1998]
from 
(
	select EmployeeID as AngID, YEAR(orderdate) as Jahr,
		sum(freight) as aktFracht 
		--,LAG(sum(Freight),1,0) over (partition by employeeid 
		--							order by year(orderdate)) 
		--							as VorJahr	,

		--  sum(freight) - LAG(sum(Freight),1,0) over (partition by employeeid 
		--							order by year(orderdate))	as DiffzumVorjahr
from orders 
group by EmployeeID, YEAR(OrderDate)
)	as Source
PIVOT
( 
sum(aktFracht)
for Jahr in ( [1996], [1997], [1998])
) as PT