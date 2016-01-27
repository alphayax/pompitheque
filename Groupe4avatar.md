# Gestion des avatars #

## Redimensionnement ##
Application de thalès pour calculer le pourcentage de redimensionnement en fonction de la position sur la grille

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Dessin_redimenssionement.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Dessin_redimenssionement.jpg)

Taille de l'image = (Distance max - Distance entre les deux personnes) x (Taille originale) / (Distance Max);




## Placement ##


### Orientation ###

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Legende1.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Legende1.jpg)

Pour les schémas suivants, l'orientation de la vision est donnée par l'orientation du personnage, car on suppose que l'avatar a la tête droite et regarde en face de lui.
S'il veut changer la direction de sa vue, il tournera le corps et non pas la tête.



### Savoir si un avatar est dans le champ de vision ###

On suppose :
  * L'origine de la vue : x<sub>vue</sub> et y<sub>vue</sub>
  * La direction de la vision (en degré) : r
  * L'angle de vision : 140°
  * La position d'un avatar quelconque : x<sub>?</sub> et y<sub>?</sub>

Il faut respecter ces deux conditions pour qu'un avatar soi vu :

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/AvatarVuCond1.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/AvatarVuCond1.png)

et

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/AvatarVuCond2.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/AvatarVuCond2.png)



### Zone et plan de l'avatar ###

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Zones.jpg](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Zones.jpg)

Pour savoir dans quel plan est un avatar, on va déjà le classer dans une zone.
Chaque zone est large de 5 mètre. (_**à discuter et vérifier**_)

On peut prendre par exemple :
  * Premier plan : zone 1
  * Deuxième plan : zones 2 et 3
  * Dernier plan : zones 4 et plus

On suppose :
  * L'origine de la vue : x<sub>vue</sub> et y<sub>vue</sub>
  * La position d'un avatar quelconque : x<sub>?</sub> et y<sub>?</sub>

Pour déterminer la zone, voici une formule "simple" :

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/ZoneAvatar.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/ZoneAvatar.png)

De ce fait, on peut également déterminer les distances des avatars par rapport au point de vue et ainsi ordonner la pile d'affichage de ceux-ci du plus éloigné au plus proche grâce au calcul de la distance :

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/DistanceAvatar.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/DistanceAvatar.png)



### Quel angle afficher ? ###

Les avatars regardent dans une direction qui leur est propre. Du coup, quel est l'angle vue par notre point d'origine (l'avatar qui regarde) ?

En supposant que celui-ci ne change jamais, c'est-à-dire que l'on voit toujours la même chose, on peut le calculer grâce à cette formule :

![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/AngleAvatar.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/AngleAvatar.png)




### Quel image afficher ? ###

C'est très simple, il suffit de prendre l'angle calculé ci-dessus, de divisé par 10¹ (en prenant la partie entière) et d'afficher l'image portant ce numéro.

¹ : on divise par 10 car les avatars ont été pris en photo tous les 10°



## Panorama ##

### Général ###

Tout derrière est affiché le panorama, enfin, juste une partie qui constitue le fond de la scène.
Dans cette partie on va voir comment calculer le point le plus éloigner ainsi que les points gauche et droit du fond.

On suppose que :
  * le Groupe n°1 fournit les points du panorama dans l'ordre
  * l'on met en mémoire 10% de fond en plus
  * l'on connaît le point d'origine et l'angle de la vue
  * le point d'origine et les points du panorama sont dans le même plan avec des coordonnées cohérentes

### Couper le panorama ###

Déterminer le point gauche (respectivement droit) en coordonnées 2D :

**Équation n°1 :** ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Equation1.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Equation1.png)

et (si x est préalablement calculé)

**Équation n°2a :** ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Equation2a.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Equation2a.png)

sinon

**Équation n°2b :** ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Equation2b.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/Equation2b.png)


Où :
  * [x, y] = [x<sub>Gauche</sub>, y<sub>Gauche</sub>] (resp. [x<sub>Droite</sub>, y<sub>Droite</sub>])
  * [x<sub>1</sub>, y<sub>1</sub>] = [x<sub>Vue</sub>, y<sub>Vue</sub>]
  * thêta = r<sub>vue</sub> + 77° (resp. r<sub>vue</sub> - 77°)
  * [x<sub>4</sub>, y<sub>4</sub>] = [x<sub>Fond gauche - 1</sub>, y<sub>Fond gauche - 1</sub>] (resp. [x<sub>Fond droit</sub>, y<sub>Fond droit</sub>])
  * [x<sub>5</sub>, y<sub>5</sub>] = [x<sub>Fond gauche</sub>, y<sub>Fond gauche</sub>] (resp. [x<sub>Fond droit + 1</sub>, y<sub>Fond droit + 1</sub>])


### Prérequis des algos ###
  * Les points du panorama sont dans l'ordre

  * **EnsP** : l'ensemble des points du panorama
  * **EnsI** : l'ensemble des indices des points du panorama qui sont affichés à l'écran
  * **[x<sub>vue</sub>,y<sub>vue</sub>]** : les coordonnées du point de vue (origine ou pas)
  * **r<sub>vue</sub>** : angle de vue


### construire EnsI ###

```
for i de 0 à EnsP.taille()
  if EstDansLeChampsDeVision(EnsP.element(i)) then
    EnsI.ajouter(i);
```


### Calcule la distance max ###
**Attention, cet algo n'est pas complet !**

```
pointPanoramaMax := null;
distanceMax := 0;
distanceCourante := 0;

for j de 0 à ensI.taille()
  distanceCourante := DistanceDeLaVue(EnsP.element(EnsI.element(j)));
  
  if distanceCourante > distanceMaxLocale then
    distanceMax := distanceCourante;
    pointPanoramaMax := EnsP.element(EnsI.element(j));

########################################################################################
# Résultat
pointPanoramaMax  # => le point le plus éloigné
distanceMax       # => la distance maxi de l'origine de la vue au panorama le plus loin
########################################################################################
```


### Points gauche et droit du panorama ###
```
# Point gauche
P{Gauche}.x := CalculEquation1(EnsP, EnsI, P{vue}, r{vue}+77°, EstGauche);
P{Gauche}.Y := CalculEquation2(EnsP, EnsI, P{vue}, r{vue}+77°, EstGauche);

# Point gauche
P{Droit}.x := CalculEquation1(EnsP, EnsI, P{vue}, r{vue}-77°, EstDroite);
P{Droit}.Y := CalculEquation2(EnsP, EnsI, P{vue}, r{vue}-77°, EstDroite);


########################################################################################
# Résultat intermédiaire :
P{Gauche} # => point gauche du fond en coordonnée 2D
P{Droit}  # => point droit du fond en coordonnée 2D
########################################################################################


# Calcul des coordonnées depuis l'origine
L{Gauche} := 0;
L{Droit} := 0;

for i de 1 à EnsI.element(0) - 1 do
  L{Gauche} += Distance(EnsP.element(i), EnsP.element(i + 1));

L{Droit} := L{Gauche};

L{Gauche} += Distance(EnsI.element(Ens.element(0)), P{Gauche}); # ok

for j de EnsI.element(0) - 1 à EnsI.element(max) do
  L{Droit} += Distance(EnsP.element(j), EnsP.element(j + 1));

L{droit} += Distance(EnsI.element(Ens.element(max)), P{Droit}); # ok

########################################################################################
# Résultat intermédiaire :
L{Gauche} # => point de départ du fond par rapport à l'origine du panorama
L{Droit}  # => point d'arrivé du fond par rapport à l'origine du panorama
########################################################################################
```


### Fonctions ###
**Rappel :** Calcul de la distance depuis l'origine de la vue : ![http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/DistanceAvatar.png](http://pompitheque.googlecode.com/svn/trunk/Groupe4/ImagesWiki/DistanceAvatar.png)

```
function Distance(P1, P2) {
  return sqrt((P2.x - P1.x)^2 + (P2.y - P1.y)^2);
}
```