--Fehlerbahndlung

--Fehler können passieren, aber was! soll passieren..
--rote Meldung oder TSQL Code

--begin try
--Code ausführen
--catch


use Northwind;
GO

Begin try
	Begin Tran
	insert into customers (customerid, companyname)
		values	('ppedv', 'ppedv ag');

IF @@ERROR <> 0
	BEGIN 
		ROLLBACK TRAN	
		RAISERROR ('Fehler beim Einfügen!', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
	END

Update customers set companyname = companyname +'XY'
	where customerid = 'ALFKI'

IF @@ERROR <> 0
	BEGIN
		Rollback tran
		RAISERROR ('Fehler beim Aktualisieren', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );  
	END
End try
Begin Catch
	rollback
	select Error_line(), Error_Message(), Error_Severity()	
end catch




Begin try
	exec gpdemo10
end try
begin catch
   select Error_message(), ERROR_NUMBER()
end catch


create proc gpdemo5
as
select * from demo10






