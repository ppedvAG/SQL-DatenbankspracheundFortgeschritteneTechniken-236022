--DBDesign.. 
--DB Design

/*

PK ---> Beziehung-->   FK
--best Index

Normalisierung  Normalformen vs Redundanz

1. 2. 3. 4. 5. 

1.  in einer Spalte nur ein Wert!
2. PK.. der DS muss eindeutig sein
3. alle Seiten ausser dem PK dürfen keine wechselseitige Beziehung

--Kunden (kdNr, Land, Stadt....)  1 MIO
--Bestell(BestNr, KundenNr, fracht.., Bestelldatum) 2MIO -Rsumme + BJahr + Quartal
--Positionen (BestNr, ArtNr, Preis, Menge)  4 MIO 
je meher normalisiert wird, desto mehr joins, desto höher der Aufwand

--evtl gezielt Redundanz einsetzen

-Spalte Rechnungssumme, Jahr zusätzlich zu bestelldatum (datetime)

--Umsatz proLand.. 7 MIO


--Gegenteil der Normalisierung = Redundanz

--Problem der Redundanz: muss man pflegen..Trígger (langsam)

--n für Unicode doppelte Menge


--Datentypen: Merke : was auf der Festplatte liegt, muss 1:1 in RAM!!

--Otto
--char(50):  'otto                               ' 50  bei  nchar(50) = 100
--varchar(50): 'otto' 4   bei nvarchar(50)  2* 4 = 8

fixe Länge char bei fixen Längen
varchar bei flexiblen Längen

Datum : kein Datetime, wenn die Zeit egal ist..

datetime (ms) wird als ganze Zahl gespeichert (2 bis3 ms.. aso etwas ungenau)
datetime2 (ns)
date 
time
datetimeoffset (ms + Zeitzone)
smalldatetime (sek)

*/
--Bsp:
--alle DS aus dem Jahr 1997
select * from orders where year(orderdate) = 1997 --korrekt aber langsam
select * from orders where orderdate like '%1997%' -- korrekt aber langsam
select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.999' --falsch, aber richtig, und schnell
select * from orders where orderdate >= '1.1.1997'   and orderdate < '1.1.1998' --korrekt und schnell


--DB  Design phsikalisch

create table test1(id int identity, spx char(4100))--müsste 80MB sein

insert into test1
select 'XY'
GO 20000

select count(*) from test1



set statistics io, time on --Anzahl der Seiten (IO) , Dauer in ms, CPU Zeit in ms
--nur messen wenn notwendig.. vorsicht bei Schleifen

--Ausführungspläne


create table test2 (id int identity, psx char(4100), spy char(4100))

select * from test1 where id = 100
--20000 Seiten * 8 KB = 160MB


--einfache Möglichkeit das zu messen
dbcc showcontig('test1')
--- Mittlere Seitendichte (voll).....................: 91.79%-- 100-% * 8kb* Seiten
--- Gescannte Seiten.............................: 2343420643



dbcc showcontig()


--Normalerweise 40-60%kompression (text besser als Zahlen)

--Kompression ist transparent zu Client
--CRM : Fax1 Fax2 Fax3 Frau1 Frau2 Frau3 Frau4 Religion 
--NULL kostet auch Platz  NULL ist nicht 0 oder ''

--Kunden ..--> Kundenstamm und Kundensonstiges

USE [Northwind]
ALTER TABLE [dbo].[test1] REBUILD PARTITION = ALL
WITH
(DATA_COMPRESSION = PAGE
)






















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
