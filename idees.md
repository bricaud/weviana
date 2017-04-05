
# Axes de développement

## Diacritiques et distance entre mots
Correction des mots mal orthographiés, permettra un meilleur classement. 

## Detection de mots clefs important dans le texte
Pour chaque document, faire une fiche (modifiable) avec les metadonnées + les mots clefs.
Choix des mots clefs:  
* expressions communes trouvées dans les documents d'un meme cluster: 
	"TF-IDF" des expressions.
* Nom propres (detection de majuscules)
* détection de chiffres
Extraction de dates

## Exploration interactive des documents avec un graphe et D3.js
Exploration des clusters
Exploration du résultat d'une recherche sous forme de graphe, avec suggestion de
documents: recommandation et guidage de l'utilisateur.

## Amélioration du classement de documents
Mettre un poid sur les connections entre documents, pénaliser les expressions trop connectées.