--Seiten: 8192 bytes davon sind 8060 bytes Nutzlast
--pro Seiten max 700 Slots
--i.d.R muss ein DS in eine Seite passen
--i.d.R?? varchar(max), nvarchar(max), varbinary(max) 
--varchar(8000)

--Messen der Seitendichte
dbcc showcontig () --gesamte DB
dbcc showcontig ('tabelle')

--Messungen
set statistics io , time on --Anzahl der Seiten, 
	--Dauer in ms von CPU und Gesamtzeit

--Ausführungsplan: Routenplan für mein Statement
--manchmal lügt der auch...

--8 Seiten am Stück = Block (Extent)
