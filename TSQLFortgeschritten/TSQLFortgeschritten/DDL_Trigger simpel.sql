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



create trigger ddlxml
on database
for create_view
as
begin
	SELECT EVENTDATA() --komplette Ausgabe der Nachricht
	--Arbeiten mit XML variable möglich
	declare @ausgabe as nvarchar(1000)
	declare @xml as xml
	set @xml = EVENTDATA()
	set @ausgabe = convert(nvarchar(1000), @xml.value('(/EVENT_INSTANCE/SPID)[1]', 'float'))
	select @ausgabe
	
	--(/EVENT_INSTANCE/SPID)[1].. XML ist hierarchisch.. ähnlich DOS Verzeichnisaufruf
	------daher: SPID liegt unter EVENT_INSTANCE  
	------[1] ist lediglich der erste Treffer in <SPID>.. gäbe es mehrere kannst du 
	-----mit 1 bis n die Inhalte per Zähler ausgeben.. 
	-----es beginnt immer bei 1

	--query holt immer Element raus
	select convert(nvarchar(1000), @xml.query('EVENT_INSTANCE/SPID'))
	--<SPID>56</SPID>

	select convert(nvarchar(1000), @xml.query('data(//CommandText)'))
	--mit data() kann man aber auch aus der query Abfrage Werte rausholen
	--create view v_xmlgugg&#x0D; as&#x0D; select * from customers

	
	select convert(nvarchar(1000), @xml.query('data(/EVENT_INSTANCE/*)'))
	--auch wildcard * für alle Elemente möglich die genau eine 
	--Etage unter EVENT_INSTANCE sind

END
GO