# Rapport du Groupe 4 #

## Sommaire ##
  1. [Exemple de rendu](Groupe4Exemple.md)
  1. [Prise des photos et retouches](Groupe4Photo.md)
  1. [Photos des avatars](Groupe4avatarPhoto.md)
  1. [Gestion des avatars](Groupe4avatar.md): Redimensionnement, orientation, placement, ...
  1. [Creation des objets](Groupe4objet.md): Idées et réflexions sur les objets (création du damier en perspective, dessin d'une table, transformation 3D)
  1. [Diagramme de classe](Groupe4classe.md)
  1. [Rapport](Groupe4rapport.md)

## Données ##
Taille de la fenetre 3D : **800x500**
(on part sur cette taille mais a rediscuté avec le groupe1 car ca depend un peu de la taille de l'image recu)

## Mission ##
### Ennoncé ###
Construction de la scène "3D' par intégration des images
Chaque client doit pouvoir voir ce qu'il y a en face de lui (dans une vue d'environ 140 defrés), c'est a dire :
  * les avatars en avant plan
  * recouvrant les avatar en arriere plan
  * recouvrant la vue panoramique du fond


### Taches ###
  * Photos des playmobils :
    * pour deux types de playmobils = Homme et Femme
    * pour deux positions = assis (sur une chaise playmobil) et debout
    * (eventuelement chaise vide a faire aussi)
    * pour chaques cas prendre une photo tout les 10 degrés = 36 photo x 4 (eventuelement prendre seulement les photos sur 180° et appliquer un effet mirroir au retouchage)
    * /!\ faire attention a la luminosité, avoir un angle tres précis, avoir un fond unis pour decoupage
    * retouche avec logiciel de graphisme pour decouper le fond et ne recuperer que le personnage, eventuelement retravailler la luminosité
  * Integration des photo des playmobils
    * Sous quel angle va t'on voir les avatars ?
    * Ou seront placé les avatars par rapport a ma position ?
    * Quel taille pour les avatars afin d'avoir une impression de 3D/perpective
  * Integration d'élément du decors :
    * Creation d'un damier en perpective qui tournera avec les fleches afin de voir comment sont appliqué les transformations sur les points
    * Creation d'une table en se basant sur le damier (le dessus de la table = un element du damier)
    * ajout d'autres objets sur la meme base que la table
  * Intégration globale :
    * Insertion de l'image du panorama correspondant a la vue du personnage (position + angle -> image=
    * Insertion des avatars
    * Insertion des objets
    * Insertion ecouteur clavier = touche pour tourner
    * Rafraichissement des avatars en demandant au server les nouvelles positions/angles
    * Insertion interface pour le retour a la vue 2D

### Questions pour les autres groupes ###
  * G1: taille de l'image recu ?

## Politique du Groupe ##
### Assignations ###
  * Chef de projet : GROLLEMUND Naitan
  * Photographe : HALOT Sébastion
  * Integration de l'avatar : ARNAUD Bérenger et GAILHAC Anthony en extreme programming
  * Intégration du décors : DISER Sorel et DUTEIL Julien en extreme programming