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






select APP_NAME(), HOST_NAME(),SUSER_NAME(), Getdate()



---dml  DDL

--IS UP DEL  DML
--CR AL DR   DDL

select  app_name(), getdate(), host_name() , suser_name()



alter table orders add Rngsumme money

select * from [Order Details]

create trigger	trgRngSumme on [order details]
for insert, update, delete
as
	BEGIN

	select isnull
	update orders set RngSumme 	 =
				 				 (select sum(unitprice*quantity) 
								  from [Order Details]
								  where orderid = (select top 1 orderid 
								                   from inserted )
							      )  where orderid= 	 (select top 1 orderid 
								                          from inserted )


	END

Begin tran
update [order details] set Quantity = 10 
	where orderid = 10248
			and 	
	 	productid = 42

rollback

select * from orders



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

