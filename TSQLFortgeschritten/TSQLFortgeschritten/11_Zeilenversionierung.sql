begin tran 

update kunden set city = 'BGH' 
--where customerid = 'ALFKI'

select @@TRANCOUNT
select * from kunden

rollback

  --Zeilenversionierung
  --Verhalten bei Transaktionen wird dadurch grundsätzlich geändert
  --Ändern hindert Lesen nicht mehr und umgekehrt
  --auf Kosten der tempdb
  --man liest die Originalversion eines Datensatzes, der vor der Änderung bestand

USE [master]
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [Northwind] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
