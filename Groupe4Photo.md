# Photos des personnages #

## Prise des photos ##

Les avatars sont des photos de personnage de Lego sous differents angles (tous les dix degrés) et sous différentes positions (assis/debout). Nous aurons dans un premier temps deux modeles d'avatar soit 35\*2\*2=140photos. Afin de nous eviter des efforts inutiles nous avons pris seulement 18 photos de chaque modele/position et avons inversé les images pour avoir les 36 angles de vues.

_Les modeles_ :
> ![![](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioStar_TN.jpg)](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioStar.jpg)

Nous avons donc construit un systeme qui simule un studio photo et qui permet de prendre precisement les personnages sous les divers angles.

_Notre studio photo_ :
> | ![![](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto1_TN.jpg)](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto1.jpg) | ![![](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto2_TN.jpg)](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto2.jpg) |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
> | ![![](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto3_TN.jpg)](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto3.jpg) | ![![](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto4_TN.jpg)](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/StudioPhoto4.jpg) |


## Traitement ##

Ensuite il faut pour chaque image supprimer le fond et le recadrer, nous utilisons pour cela le logiciel de retouche d'image Photoshop qui permet d'executer et de réaliser des traitements par lot via de simples scripts.

_Création du script de decoupage_:
> | ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_scriptdecoupage.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_scriptdecoupage.jpg) | ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_scriptdecoupage2.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_scriptdecoupage2.jpg) |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  1. On recadre l'image
  1. A l'aide de l'outil "Baguette magique" on selectionne le fond (blanc uni)
  1. Avec un rectangle de selection on rajoute à la selection le bas de l'image (piece lego servant de support)
  1. on inverse la selection afin de ne recuperer que le personnage
  1. on copie la nouvelle selection dans un nouveau fichier image avec un fond transparent
  1. on enregistre

Une fois le script creer, il faut l'appliquer sur toutes nos photos, on fait cette etape manuellement car la "Baguette magique" produit parfois des resultats legerement differents par rapport a ce que l'on attend, donc on applique le script sur chaque image séparement afin de controler le resultat.

On fait par la meme occasion un script pour inverser les images (une image vu a 120° sera l'image inversé de 240°).

_Création du script d'inversement_:

> ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_scriptinversement.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_scriptinversement.jpg)

_Traitement par lot_ :
> ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_traitementparlot.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/rapport_traitementparlot.jpg)


On obtiens ainsi notre serie d'avatar vu sous chaque angle, decouper et pres a etre utilise dans le logiciel