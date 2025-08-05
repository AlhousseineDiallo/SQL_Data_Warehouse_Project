# Data Catalog pour notre Gold Layer

## Aperçu  
La Gold layer est la représentation des données au niveau métier, structurée pour supporter les cas d'usage analytiques et de reporting. Elle se compose de **tables de dimensions** et de **tables de faits** portant sur des indicateurs métier spécifiques.

---

### 1. **gold.dim_customers**
- **Objectif :** Stocker les détails clients enrichis avec des données démographiques et géographiques.  
- **Colonnes :**
  

| Nom des colonnes      | Type de donnée      | Description
|-----------------------|---------------------| ----------------------------------------------------------------------- 
| customer_key          | INT                 |  Surrogate key (Clé de substitution) identifiant de manière unique chaque enregistrement client dans la table de dimension |
| customer_id           | INT                 |  Identifiant numérique unique attribué à chaque client.                                                                    |
| customer_number       | NVARCHAR(50)        |  Identifiant alphanumérique représentant le client, utilisé pour le suivi et la référenciation.                            |
| first_name            | NVARCHAR(50)        |  Prénom du client, tel qu'enregistré dans le système.                                                                      |
| last_name             | NVARCHAR(50)        |  Nom de famille ou patronyme du client.                                                                                    |
| country               | NVARCHAR(50)        |  Pays de résidence du client (par exemple, 'Australie').                                                                   |
| marital_status        | NVARCHAR(50)        |  État civil du client (par exemple, 'Marié', 'Célibataire').                                                               |
| gender                | NVARCHAR(50)        |  Genre du client (par exemple, 'Homme', 'Femme', 'Non précisé').                                                           |
| birthdate             | DATE                |  Date de naissance du client, formatée en AAAA-MM-JJ (par exemple, 1971-10-06).                                            |
| create_date           | DATE                |  Date et heure de création de l'enregistrement client dans le système.                                                     |

---

### 2. **gold.dim_products**
- **Objectif :** Fournit des informations sur les produits et leurs attributs.
- **Colonnes :**


| Nom de la colonne         | Type de données  | Description                                                                                                     |
|---------------------------|------------------|----------------------------------------------------------------------------------------------------------------|
| product_key               | INT              | Clé substitut identifiant de façon unique chaque enregistrement de produit dans la table de dimension produit. |
| product_id                | INT              | Identifiant unique attribué au produit pour le suivi et la référence internes.                                 |
| product_number            | NVARCHAR(50)     | Code alphanumérique structuré représentant le produit, souvent utilisé pour la catégorisation ou l’inventaire. |
| product_name              | NVARCHAR(50)     | Nom descriptif du produit, incluant des détails clés comme le type, la couleur et la taille.                   |
| category_id               | NVARCHAR(50)     | Identifiant unique de la catégorie du produit, servant de lien vers sa classification de haut niveau.          |
| category                  | NVARCHAR(50)     | Classification générale du produit (par ex. : Vélos, Composants) pour regrouper des articles similaires.       |
| subcategory               | NVARCHAR(50)     | Classification plus détaillée du produit au sein de la catégorie, comme le type de produit.                    |
| maintenance_required      | NVARCHAR(50)     | Indique si le produit nécessite une maintenance (par ex. : 'Oui', 'Non').                                      |
| cost                      | INT              | Coût ou prix de base du produit, exprimé en unités monétaires.                                                 |
| product_line              | NVARCHAR(50)     | Ligne ou série spécifique à laquelle appartient le produit (par ex. : Route, Montagne).                        |
| start_date                | DATE             | Date à laquelle le produit a été mis en vente ou disponible à l’usage, stockée au format date.                 |


---

### 3. **gold.fact_sales**
- **Objectif :** Stocke les données transactionnelles des ventes à des fins d’analyse.
- **Colonnes :**

| Nom de la colonne   | Type de données  | Description                                                                                         |
|---------------------|------------------|-----------------------------------------------------------------------------------------------------|
| order_number        | NVARCHAR(50)     | Identifiant alphanumérique unique pour chaque commande de vente (par ex. : 'SO54496').              |
| product_key         | INT              | Clé substitut reliant la commande à la table de dimension produit.                                  |
| customer_key        | INT              | Clé substitut reliant la commande à la table de dimension client.                                   |
| order_date          | DATE             | Date à laquelle la commande a été passée.                                                           |
| shipping_date       | DATE             | Date à laquelle la commande a été expédiée au client.                                               |
| due_date            | DATE             | Date d’échéance de paiement de la commande.                                                         |
| sales_amount        | INT              | Valeur monétaire totale de la vente pour la ligne concernée, en unités monétaires entières (par ex. : 25). |
| quantity            | INT              | Nombre d’unités de produit commandées pour la ligne concernée (par ex. : 1).                        |
| price               | INT              | Prix unitaire du produit pour la ligne concernée, en unités monétaires entières (par ex. : 25).     |
