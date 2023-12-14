--Thorw ab 50000 bis 2,1 Mrd
--THROW 50000, 'The record does not exist.', 1;
set statistics profile on

begin try
THROW 5000, 'The record does not exist.', 1;
end try
Begin catch
print 'hier kommt Fehler ' +  ' ' + Error_message();
Throw;
End catch

