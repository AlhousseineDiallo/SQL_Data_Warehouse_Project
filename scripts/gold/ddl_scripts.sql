/*
===============================================================================
Script DDL : Création des vues de la couche Gold
===============================================================================
But du script :
    Ce script crée des vues pour la couche Gold dans l'entrepôt de données.
    La couche Gold représente les tables de dimensions et de faits finales 
    (Schéma en étoile).

    Chaque vue effectue des transformations et combine des données depuis 
    la couche Silver afin de produire un jeu de données propre, enrichi 
    et prêt pour l’analyse métier.

Utilisation :
    - Ces vues peuvent être interrogées directement pour l’analyse et les rapports.
===============================================================================
*/


-- =============================================================================
-- Creation de la  Dimension: gold.dim_customers
-- =============================================================================

IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL
    DROP VIEW gold.dim_customers;

GO

CREATE VIEW gold.dim_customers AS (

    SELECT
        ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
        ci.cst_id AS customer_id,
        ci.cst_key AS customer_number,
        ci.cst_first_name AS first_name,
        ci.cst_last_name AS last_name,
        cl.cntry AS country,
        ci.cst_marital_status AS marital_status,
        CASE
            WHEN cst_gender <> 'n/a' THEN ci.cst_gender
            ELSE COALESCE(ca.gen, 'n/a')
        END AS gender,
        ca.bdate AS birthdate,
        ci.cst_create_date AS create_date
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca
        ON ca.cid = ci.cst_key
    LEFT JOIN silver.erp_loc_a101 cl
        ON cl.cid = ci.cst_key

);

GO

-- =============================================================================
-- Create de la Dimension: gold.dim_products
-- =============================================================================

IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
    DROP VIEW gold.dim_products;

GO

CREATE VIEW gold.dim_products AS (

    SELECT
        ROW_NUMBER() OVER(ORDER BY pr.prd_start_dt, pr.prd_key) AS product_key,
        pr.prd_id AS product_id,
        pr.prd_key AS product_number,
        pr.prd_nm AS product_name,
        pr.cat_id AS category_id,
        pc.cat AS category,
        pc.subcat AS subcategory,
        pc.maintenance,
        pr.prd_cost AS cost,
        pr.prd_line AS product_line,
        pr.prd_start_dt AS start_date
    FROM silver.crm_prd_info pr
    LEFT JOIN silver.erp_px_cat_g1v2 pc
        ON pr.cat_id = pc.id
    WHERE pr.prd_end_dt IS NULL -- Ce filtre va nous permettre d'éliminer les données historiques.

);

GO

-- =============================================================================
-- Creation de la Dimension: gold.fact_sales
-- =============================================================================

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;

GO

CREATE VIEW gold.fact_sales AS (

    SELECT
        sd.sls_ord_num AS order_number,
        pr.product_key,
        cu.customer_key,
        sd.sls_order_dt AS order_date,
        sd.sls_ship_dt AS shipping_date,
        sd.sls_due_dt AS due_date,
        sd.sls_sales AS sales_amount,
        sd.sls_quantity AS quantity,
        sd.sls_price AS price
    FROM silver.crm_sales_details sd
    LEFT JOIN gold.dim_products pr
        ON pr.product_number = sd.sls_prd_key
    LEFT JOIN gold.dim_customers cu
        ON cu.customer_id = sd.sls_cust_id
    
);

