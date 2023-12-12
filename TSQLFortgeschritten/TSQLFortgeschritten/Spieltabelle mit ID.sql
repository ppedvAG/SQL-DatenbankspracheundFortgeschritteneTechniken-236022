SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Employees.LastName, Employees.FirstName, Orders.OrderDate, Orders.EmployeeID, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity,
                   Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock
INTO KundeUmsatz
FROM         Customers INNER JOIN
             Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
             Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
             [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
             Products ON [Order Details].ProductID = Products.ProductID;
GO


insert into KundeUmsatz
select * from kundeumsatz
GO 9 --keine Variable darin möglich


alter table kundeumsatz add ID int identity
GO

set statistics io, time on

select * from kundeumsatz where id = 17
--, CPU-Zeit = 1315 ms, verstrichene Zeit = 239 ms.  65655 Seiten

dbcc showcontig('kundeumsatz')

--- Gescannte Seiten.............................: 51649  crazy

select * from sys.dm_db_index_physical_stats(db_id(),object_id('kundeumsatz'),NULL,NULL, 'detailed')
--forward record count sollte immer 0 oder NULL, hier aber 14016















select * from sys.dm_db_index_usage_stats


