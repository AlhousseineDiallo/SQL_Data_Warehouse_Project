-- Create the Database 'Data Warehouse'
/*
=============================================================
Créer la base de données et les schémas
=============================================================
Objectif du script :
    Ce script crée une nouvelle base de données nommée 'DataWarehouse', après avoir vérifié si elle existe déjà.
    Si la base de données existe, elle est supprimée puis recréée. De plus, le script crée trois schémas 
    dans la base de données : 'bronze', 'silver' et 'gold'.
	
AVERTISSEMENT :
    L'exécution de ce script supprimera entièrement la base de données 'DataWarehouse' si elle existe.
    Toutes les données qu'elle contient seront définitivement perdues.
    Exécutez ce script avec précaution et assurez-vous d'avoir effectué des sauvegardes adéquates avant de le lancer.
*/

USE master;

GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')

BEGIN

	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;

END

GO

CREATE DATABASE DataWarehouse;

USE DataWarehouse;

-- Procédons à la création de nos schémas

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
