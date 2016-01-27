# Création des objets vectoriel #

## Création d'un damier ##
Le damier peut servir de sol et donner une impression de perspective.
Mais aussi le damier est composé de rectangle qui peuvent servir de base pour un objet (haut de table : rectangulaire ou rond (coordonnée de l'ovale) )

**Plusieurs taches :**
  * dessiner un damier en perspective en vue de face
  * calculer les autres vue
  * ajouter des ecouteurs claviers et appliquer les calcul de vue en fonction des deplacement

**Quelques informations utiles :**
  * [Damier en perspective](http://www.crdp.ac-grenoble.fr/imel/jlj/persp/dessin/damier/infogene.htm)
  * [cube "fausse" 3D en flash](http://pompitheque.googlecode.com/svn/trunk/Groupe4/Cube3D/cube3d.swf) (source sur le SVN)
```
fond.createEmptyMovieClip("ligne" , 10);
i = 0;
go = setInterval(bouge,10)
bt.onRelease = function() {
	if (bt.id == 1) {
		bt.id = 0;
		go = setInterval(bouge,10)
	} else {
		clearInterval(go)
		bt.id = 1;
	};
};

function bouge() {
	fond.ligne.clear();
	ax = 120 + 80 * Math.cos(i * Math.PI / 180);
	ay = 50 + 20 * Math.sin(i * Math.PI / 180);
	bx = 120 + 80 * Math.cos((i+90) * Math.PI / 180);
	by = 50 + 20 * Math.sin((i+90) * Math.PI / 180);
	cx = 120 + 80 * Math.cos((i+180) * Math.PI / 180);
	cy = 50 + 20 * Math.sin((i+180) * Math.PI / 180);
	dx = 120 + 80 * Math.cos((i+270) * Math.PI / 180);
	dy = 50 + 20 * Math.sin((i+270) * Math.PI / 180);
	fond.ligne.lineStyle(2,0xFF0000,100);
	fond.ligne.moveTo(ax,ay);
	fond.ligne.lineTo(bx,by);
	fond.ligne.lineTo(cx,cy);
	fond.ligne.lineTo(dx,dy);
	fond.ligne.lineTo(ax,ay);
	fond.ligne.lineTo(ax,ay+100);
	fond.ligne.lineTo(bx,by+100);
	fond.ligne.lineTo(cx,cy+100);
	fond.ligne.lineTo(dx,dy+100);
	fond.ligne.lineTo(ax,ay+100);
	fond.ligne.moveTo(bx,by);
	fond.ligne.lineTo(bx,by+100);
	fond.ligne.moveTo(cx,cy);
	fond.ligne.lineTo(cx,cy+100);
	fond.ligne.moveTo(dx,dy);
	fond.ligne.lineTo(dx,dy+100);
	i++;
	if (i>90) {
		i = 0;
	};
};
```

## Création d'une table ##

en cours...