# Cartes 

Tests d'affichage de POIs sur une carte

## Initialisation

Démarrage de Postgis + Martin à l'aide de Docker compose : `docker compose up -d`

Import des POIs : 
Dans le dossier osm2pgsql, éventuellement mettre à jour les paramètres au début du script `import.ps1`, puis exécuter le script

Redémarrer le conteneur Martin

## Affichage

Un conteneur docker est lancé avec une page html d'exemple, accessible sur [http://localhost:8080/](http://localhost:8080/)
