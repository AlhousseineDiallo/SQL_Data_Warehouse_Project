/*
===============================================================================
Procédure stockée : Chargement de la couche Bronze (Source -> Bronze)
===============================================================================
Objectif du script :
    Cette procédure stockée charge les données dans le schéma 'bronze' à partir de fichiers CSV externes.
    Elle effectue les actions suivantes :
    - Tronque les tables bronze avant de charger les données.
    - Utilise la commande `BULK INSERT` pour charger les données des fichiers CSV vers les tables bronze.

Paramètres :
    Aucun.
    Cette procédure stockée n'accepte aucun paramètre et ne retourne aucune valeur.

Exemple d'utilisation :
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	SET @start_time = GETDATE()

	BEGIN TRY
		PRINT '====================================';
		PRINT 'Loading the Bronze Layer';
		PRINT '====================================';

		PRINT '------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\alseiny.DIALLO\OneDrive\Documents\Data_warehouse_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> -----------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> Inserting Data into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\alseiny.DIALLO\OneDrive\Documents\Data_warehouse_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\alseiny.DIALLO\OneDrive\Documents\Data_warehouse_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ------------------------';


		PRINT '------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> Inserting Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\alseiny.DIALLO\OneDrive\Documents\Data_warehouse_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>> Inserting Data into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\alseiny.DIALLO\OneDrive\Documents\Data_warehouse_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		PRINT '>> ------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '>> Inserting Data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\alseiny.DIALLO\OneDrive\Documents\Data_warehouse_project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ------------------------';


	END TRY

	BEGIN CATCH
		PRINT '===================================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT '===================================================='
		
	END CATCH
	SET @end_time = GETDATE()
	PRINT '===========================================================';
	PRINT 'Loading Bronze Layer is Completed';
	PRINT '			- Total Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
	PRINT '===========================================================';
	
	

END



