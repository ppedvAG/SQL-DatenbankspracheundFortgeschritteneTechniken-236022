--Evtl muss der plan korrigiert werden
--anderen join wählen etc..

--Grund: falsche Statistiken bzgl der Verteilung der Daten in Spalten
--statt 10 zeilen doch 100000zb..
--Diff tats Plan (Zeilen9 vs gwschätzter Plan

set statistics io, time on
  select * from kundeumsatz where freight = 1

  dbcc showcontig('kundeumsatz')

  --beide tabellen werden in einem! paralell stattfindenen  Durchlauf durchsucht
  --Sortiert
 select * from customers c inner merge join orders o 
 on c.CustomerID=o.CustomerID

 --für beide tabellen werden Hashwerte erzeugt
 --kein Index vorhanden? große tabellen
  select * from customers c inner hash join orders o 
 on c.CustomerID=o.CustomerID

 --die "kleine!" tabelle wird zeilenweise durchlaufen und pro Datensatz 
 --wird die "große" tabelle einmal durchlaufen
  select * from customers c inner loop join orders o 
 on c.CustomerID=o.CustomerID

--sql kann sich anpassen  adaptiv join--< entscheeidet
--im gleichem plan zwischen hash und Loop join

 select * into ku2 from kundeumsatz

 select * from ku2 where id = 2
 select * from ku2 where freight = 0.02
 select * from ku2 where customerid = 'ALFKI'	and City = 'berlin'

 --



