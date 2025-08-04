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
