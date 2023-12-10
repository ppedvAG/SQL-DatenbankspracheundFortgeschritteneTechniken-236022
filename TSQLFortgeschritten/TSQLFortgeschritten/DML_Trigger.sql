--DML und DDL Trigger

create trigger demo on tabx
for insert, update, delete -- instead of Update
as
select * from inserted
select * from deleted

update tabx set city = 'BGH' where id = 1


--Trigger  DML DDL

--DML reagiert auf INS , UP , DEL
--insert: die DS , die reinkommen, werden auch in Tabelle inserted geschrieben
--delete: die DS, die gelöscht werden, kommen in Tabelle deleted
--update: wie insert und delete
--
alter table orders add  RechSumme  money;
GO
--Trigger zum Aktualisieren der RechSumme
create trigger trgdemoxy on ku1
for insert, update, delete
as
select * from inserted
select * from deleted

create trigger trgRsumme on [order details]
FOR insert , update, delete
as
	begin
		select sum(unitprice*quantity) from [order details]
			where orderid = (select  orderid from inserted)
		select * from inserted
		...
		update orders set ... where order
	 end
GO

select * from orders

rollback
begin tran 



update orders set rechsumme = 
select sum(un

update [order details] set unitprice = 100 where orderid = 10248 and Productid = 11



select * from [order details]




update ku1 set city = 'BGH' where id = 10

select APP_NAME(), HOST_NAME(),SUSER_NAME(), Getdate()




begin tran 
update orders set shipcity = 'BGH'
select * from orders
rollback


--trgRngSumme
--alter table orders add column RechSumme money

--
---DDL (create, drop und alter)

create trigger trgDDLdemo on database
for ddl_database_level_events
as
select eventdata() --Nachricht in XML Format (wer, wann , was, wo, wie)

create view v1
as
select * from orders

