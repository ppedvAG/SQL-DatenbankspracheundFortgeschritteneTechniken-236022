--Pr�fen: Volltext installiert??
SELECT SERVERPROPERTY('IsFullTextInstalled')
GO
;
--####################################
--#### SemanticsDB installieren ######
--####################################

--SemantikDb DB extrahieren (\1031_DEU_LP\x64\Setup)
--und attachen.....msi-File

USE [master]
GO
CREATE DATABASE [semanticsdb] ON 
( FILENAME = N'C:\_BOOMDB\semanticsDB.mdf' ),
( FILENAME = N'C:\_BOOMDB\semanticsdb_log.ldf' )
 FOR ATTACH
GO




-- und registrieren  dbname= Name der Semantik DB
EXEC sp_fulltext_semantic_register_language_statistics_db 
	@dbname = N'semanticsdb';






--####################################
--#### Office 2010 Filter Pack #######
--####################################


--Welche Sprachen werden unterst�tzt
select * from sys.fulltext_semantic_languages

--Filterpackage installiert?? Existiert f�r Office 2007 und Office 2010 

--Aktivieren der iFilter f�r Volltextsuche
Sp_fulltext_service 'Load_os_resources', 1


--Neustart der Volltextsuche--am besten Server





--Anzeige der indizierbaren Dokumente
select * from sys.fulltext_document_types



--#################################################
--DEMO:  Neue DB mit Filestreaming
--#################################################

--Filestreaming auf Server aktivieren
EXEC sys.sp_configure N'filestream access level', N'2'
GO
RECONFIGURE WITH OVERRIDE
GO



create database Fulltextdemo

USE [master]
GO

--Filestreaming aktivieren: nicht transaktional.. kein Rollback!
USE MASTER

--Freigabe Verzeichnis
ALTER DATABASE [Fulltextdemo] 
	SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL, 
	DIRECTORY_NAME = N'FULLTEXT' ) 


--Dateigruppe f�r Filestream hinzuf�gen
ALTER DATABASE [Fulltextdemo]
	ADD FILEGROUP [FS] CONTAINS FILESTREAM 
GO


--Lokaler Dateipfad f�r Filstream
USE [master]
GO
ALTER DATABASE [Fulltextdemo]
	ADD FILE ( NAME = N'FulltextDB',
		FILENAME = N'C:\_BOOMDB\FulltextDB' ) TO FILEGROUP [FS]
GO

--Pfade ergeben sich aus: \\servername\Name der Freigabe pro Instanz\Freigabename der DB\Verzeichnis der Tabelle




--Tabelle f�r Files -- Filetable
Use fulltextdemo
Go

CREATE TABLE dbo.Dateitabelle AS FILETABLE
  WITH
  (
    FILETABLE_DIRECTORY = 'Dokumente',
    FILETABLE_COLLATE_FILENAME = database_default
  )
GO


select * from dateitabelle
--Datei reinkopieren
!!copy c:\demoDokus\*.* /Y \\boom\BOOM\FULLTEXT\Dokumente
!!dir \\boom\BOOM\FULLTEXT\Dokumente

!!dir *.*


--Tu das nicht.. ;-)-- file_Stream entpricht den Dateien ..und kann dauern
select name from dokus
select * from dokus

--spalte filestream ist der INhalt der DAteien



--##########################################
--Volltextkatalog einrichten
--##########################################


--Vollext per SQL Skripting oder per SSMS


USE [Fulltextdemo]
GO
CREATE FULLTEXT CATALOG [VOLLTEXT]WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
AUTHORIZATION [dbo]

GO

--Tabelle VolltextIndizieren in SSMS

--Sprache: german
--File_stream --German-- Filetype -- statistische Semantik 
--name -- German -- statistische Semantik



--#######################################
--Semantische Suche
--#######################################

--SEMANTICKEYPHRASETABLE
--SEMANTICSIMILARITYTABLE
--SEMANTICSIMILARITYDETAILSTABLE




--Wichtige Schl�sselw�rter


use fs_demo
select * from Dateitabelle


-------
DECLARE @DocID hierarchyid

SELECT @DocID = path_locator from Dateitabelle
 where name = 'Backup.docx';

SELECT top 200 KEYP_TBL.keyphrase
FROM SEMANTICKEYPHRASETABLE
    ( Dateitabelle,
      file_stream,
      @DocID
    ) AS KEYP_TBL
ORDER BY KEYP_TBL.score DESC;



--Suche nach Dokumenten, die ein bestimmtes Schl�sselwort aufweisen

SELECT TOP (100) DOC_TBL.path_locator.ToString() Locator, DOC_TBL.name,
 score, keyphrase
FROM Dateitabelle AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    ( Dateitabelle,
      file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'backup'
ORDER BY KEYP_TBL.Score DESC;



--Suche nach statistisch gewichteten Schl�sselw�rtern
--SEMANTICKEYPHRASETABLE





--dadurch auch Suche nach Dokumenten mit gleichen Schl�sselw�rtern
--------------

SELECT TOP (10) DOC_TBL.path_locator.ToString() Locator, DOC_TBL.name
FROM dateitabelle AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    ( dateitabelle,
      file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'backup' --cdc
ORDER BY KEYP_TBL.Score DESC;



---Suche nach �hnlichen Dokumenten
--SEMANTICSIMILARITYTABLE



DECLARE @DocID hierarchyid
SELECT @DocID = path_locator from Dateitabelle where name = 'Security.docx';
--SELECT @DocID = path_locator from MeineFiletable where name = 'SPS 2010 Suchen.txt';

SELECT   mft.name, sst.score 
FROM SEMANTICSIMILARITYTABLE
  ( Dateitabelle,
    file_stream,
    @DocID
  ) AS sst
INNER JOIN Dateitabelle mft
  ON path_locator = matched_document_key 
ORDER BY score DESC

--Warum ist dieses Dokument �hnlich?


DECLARE @DocID hierarchyid
DECLARE @DocIDMatch hierarchyid

SELECT @DocID = path_locator from Dateitabelle 
	where name = 'security.docx';

SELECT @DocIDMatch = path_locator FROM Dateitabelle 
	WHERE name = 'Workflow.docx';
 
SELECT TOP(20) V4.keyphrase, V4.score
FROM SEMANTICSIMILARITYDETAILSTABLE
  ( Dateitabelle,
    file_stream,
    @DocID,
    file_stream,
    @DocIDMatch
  ) AS V4
ORDER BY V4.score DESC;


--###########################################################
--Sucheigenschaftslisten --> Metdatensuche
--##########################################################
/*
Author   F29F85E0-4FF9-1068-AB91-08002B27B3D9 4
Tags F29F85E0-4FF9-1068-AB91-08002B27B3D9 5
Type 28636AA6-953D-11D2-B5D6-00C04FD918D0 9
Title F29F85E0-4FF9-1068-AB91-08002B27B3D9 2
*/

SELECT * FROM Demodokus
  WHERE CONTAINS(PROPERTY(file_stream,'Author'), 'ar1');




--ein paar Sichten zu Volltext

SELECT * FROM sys.dm_db_fts_index_physical_stats;
select * from sys.dm_fts_semantic_similarity_population
select * from sys.dm_fts_index_population