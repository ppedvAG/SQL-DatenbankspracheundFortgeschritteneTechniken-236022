create  trigger lachmichtot2
on database
for   DDL_Database_level_events
as
ROLLBACK;


drop trigger lachmichtot2

create table test5 (id int)








exec msdb.dbo.sp_send_DBMail
















declare @x as xml
select @x= EVENTDATA()
select @x
--Rollback


create table test (id int)

drop table test



exec msdb..sp_send_dbmail @recipients='chef@sql2012.local', @body=@x,
	@subject='wer hat hier gelöscht', @profile_name='SQL2012'


drop table parttab




select * from parttab

drop table parttab

declare @data as xml
set @data = eventdata()
insert into events(logging) Values(@data)
--endet trigger




create table events(id int identity, logging xml)



select * from events

--Auslösen des Triggers
create table test3 (testid int)
drop table test3

--Tabelle für Trigger Nachrichten
create table events (id int, logging xml)

--Nachrichten aus Triggertabelle auslesen
select * from events


drop trigger denydrop

alter trigger denydrop
on database
for Drop_table
as
print 'Ätsch.... ;-)'
SELECT EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
rollback;

drop table bestellungen