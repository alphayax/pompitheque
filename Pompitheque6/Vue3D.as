package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
	import message.*;
	import panorama.*;
	import chat.*;
	
	
	//on a juste besoin de la taille de la piece (largeur, longueur, coordonnée)
	//et de la liste des personnes
	public class Vue3D extends Sprite
	{
		//propriaitaire de la vue 3D
		private var pers:Personne;
		//Liste des acteurs : contiendra des Personnes et des objet du mobilier
		private var ListeActeur:Array;
		//Liste des points panoramiques du plan
		//  autant que de points en param 1, 2 valeurs en param 2 :
		//  les coordonnées x et y
		private var ListPointsPano:Array;
		//Distance max dans le plan (utile pour calculer le redimensionnement)
		private var DistanceMaxPlan:Number=0;
		//Points gauche et droit du panorama (+10% non affichable) [x,y]
		private var PointPanoGauche:Array;
		private var PointPanoDroit:Array;
		private var PanoDistanceOrigine:Number;
		private var PanoLongueur:Number;
		//data xml contenant toute les info du plan
		private var Plan:XML
		//panorama
		private var Panorama:ChargeurDeBitmap;
		
		//Position du point de vue 
		public static var xCenter:Number = 400;
		public static var yCenter:Number = 575;	 
		
		// Serveur
        private var serveur:Client;
		
		//on cree une vue 3D a partir d'un personnage
		public function Vue3D(pers:Personne,ListeActeur:Array,Plan:XML)
		{
			super();
			
			//propriaitaire de la vue 3D
			this.pers=pers;
			//plan de la piece
			this.Plan=Plan;
			
			this.Panorama= new ChargeurDeBitmap();
			addChild(Panorama);
			//premiere (et unique) initialisation du plan
			InitialiserPlan()
			//premiere initialisation des distances
			InitialiserVue();
			
			/************/
			/*****DEBUT TEST GROUPE4****/
			//pour les test on ajoute l'angle de vue de 140°
			// centre de la rotation			
			var angleVue:Number = 140;
			var largeurVue:Number = 250;
			graphics.lineStyle(1);
			graphics.moveTo(xCenter,yCenter);
			graphics.lineTo(xCenter+largeurVue,yCenter-Math.atan(30*Math.PI/180)*largeurVue);
			graphics.moveTo(xCenter,yCenter);
			graphics.lineTo(xCenter-largeurVue,yCenter-Math.atan(30*Math.PI/180)*largeurVue);
			//DistanceMaxPlan = 600;
			/*****FIN TEST GROUPE4****/		
			/*************/
			
			//on recupere la liste des acteurs (personnes et mobilier) de la vue
			this.ListeActeur=ListeActeur;
			//pour chaque acteur on calcule les coordonnées 3D et l'angle vue
			for(var i:* in ListeActeur)
			{
				ListeActeur[i].CalculDistance(pers);
				ListeActeur[i].CalculRedimensionnement3D(DistanceMaxPlan);
				ListeActeur[i].CalculAnglePOX(pers);
				ListeActeur[i].CalculAngleVue(pers);
				ListeActeur[i].CalculCoordonnee3D(pers);
			}	
			
			//On tri le tableau d'acteur par rapport a la distance entre le proprio et l'acteur
			for(var i:* in ListeActeur)
			{
				addChild(ListeActeur[i]);
			}	
			reOrderTab();
			//on affiche tout les acteurs			
			AfficheVue3D();								
		}	
		
        public function getClient():Client{
            return serveur;
        }
		
		
		// Initialisation de la piece		
		public function InitialiserPlan():void
		{
			var distanceCourante:Number = 0;
			var numPoints : Number = 0;
			ListPointsPano = new Array();
			
			// Recupere les points
			for each(var baliseMur:XML in Plan..mur)
			{
				ListPointsPano[numPoints] = {xX:baliseMur.@x1,yY:baliseMur.@y1};
				trace("3D--1="+baliseMur.@x1+","+baliseMur.@y1);
				trace("3D--2="+ListPointsPano[numPoints].xX+", "+ListPointsPano[numPoints].yY);
				numPoints++;
			}

			// Recherche de la distance la plus éloignée
			for(var j:Number = 0; j < ListPointsPano.length; j++) {
				distanceCourante = DistanceDuPointDeVue(ListPointsPano[j].xX, ListPointsPano[j].yY);
				trace("3D--distanceCourante="+distanceCourante);	
				if(DistanceMaxPlan < distanceCourante) {
					DistanceMaxPlan = distanceCourante;
				}
			}
			trace("3D--3="+DistanceMaxPlan);
		}
		
		
		// Initialisation des distances pour le point de vu courant
		// A faire avant chaque vue 3D !!
		// Determine et enregistre :
		//   - la distance max
		//   - le point gauche et droit du panorama
		public function InitialiserVue():void
		{
			
			var listePointsPanoramaVus:Array = new Array();
			var nbPointsPanoVus:Number = 0;
			
			//PointPanoGauche = new Array();
			//PointPanoDroit = new Array();
			var xTemp:Number = 0;
			var yTemp:Number = 0;
			var positionI:Number = 0;
			
			var pointcourant:Array = new Array();
			var pointDebut:Number = 0;
			var pointFin:Number = 0;
			PanoDistanceOrigine = 0;
			PanoLongueur = 0;
			
			// Recherche les points visibles du panorama
			for(var i:Number = 0; i < ListPointsPano.length; i++ ) {
				pointcourant = Intersection(
						// Segment 1 point 1
						ListPointsPano[i].xX,
						ListPointsPano[i].yY,
						// Segment 1 point 2
						ListPointsPano[(i + 1) % ListPointsPano.length].xX,
						ListPointsPano[(i + 1) % ListPointsPano.length].yY,
						// Segment 2 point 1 : origine
						pers.getX2D(),
						pers.getY2D(),
						// Segment 2 point 2 (point hypothétique)
						pers.getX2D() + 1000 * Math.cos((pers.getAngleAbsolu()+70)*Math.PI/180),
						pers.getY2D() + 1000 * Math.sin((pers.getAngleAbsolu()+70)*Math.PI/180)
					);
				if (pointcourant.length > 0) {
					pointDebut = i;
					PointPanoDroit = new Array(pointcourant[0], pointcourant[1]);
				}
				
				pointcourant = Intersection(
						// Segment 1 point 1
						ListPointsPano[i].xX,
						ListPointsPano[i].yY,
						// Segment 1 point 2
						ListPointsPano[(i + 1) % ListPointsPano.length].xX,
						ListPointsPano[(i + 1) % ListPointsPano.length].yY,
						// Segment 2 point 1 : origine
						pers.getX2D(),
						pers.getY2D(),
						// Segment 2 point 2 (point hypothétique)
						pers.getX2D() + 1000 * Math.cos((pers.getAngleAbsolu()-70)*Math.PI/180),
						pers.getY2D() + 1000 * Math.sin((pers.getAngleAbsolu()-70)*Math.PI/180)
					);
				if (pointcourant.length > 0) {
					pointFin = i;
					PointPanoGauche = new Array(pointcourant[0], pointcourant[1]);
				}
			}
			
			trace("Point gauche:" + PointPanoGauche[0] + "   " + PointPanoGauche[1]);
			trace("Point droit:" + PointPanoDroit[0] + "   " + PointPanoDroit[1]);
			
			for(var j:Number = 0; j <= pointDebut; j++ ) {
				PanoDistanceOrigine = PanoDistanceOrigine + DistanceEntreDeuxPoints(
						// Segment 1 point 1
						ListPointsPano[j].xX,
						ListPointsPano[j].yY,
						// Segment 1 point 2
						ListPointsPano[(j + 1) % ListPointsPano.length].xX,
						ListPointsPano[(j + 1) % ListPointsPano.length].yY);
			}
			PanoDistanceOrigine = PanoDistanceOrigine + DistanceEntreDeuxPoints(
						// Segment 1 point 1
						ListPointsPano[pointDebut].xX,
						ListPointsPano[pointDebut].yY,
						// Segment 1 point 2
						PointPanoGauche[0],
						PointPanoGauche[1]);
			
			trace("PanoDistanceOrigine: "+PanoDistanceOrigine);
			
			
			for(var k:Number = (pointDebut + 1); k <= pointFin; k++ ) {
				PanoLongueur = PanoLongueur + DistanceEntreDeuxPoints(
						// Segment 1 point 1
						ListPointsPano[k].xX,
						ListPointsPano[k].yY,
						// Segment 1 point 2
						ListPointsPano[(k + 1) % ListPointsPano.length].xX,
						ListPointsPano[(k + 1) % ListPointsPano.length].yY);
			}
			PanoLongueur = PanoLongueur + DistanceEntreDeuxPoints(
						// Segment 1 point 1
						ListPointsPano[pointFin].xX,
						ListPointsPano[pointFin].yY,
						// Segment 1 point 2
						PointPanoDroit[0],
						PointPanoDroit[1]);
			
			trace("PanoLongueur: "+PanoLongueur);
			
			// Correction des coordonnees par rapport aux dimensions des batonnets
			PanoDistanceOrigine = Math.round(PanoDistanceOrigine/10) * 10;
			PanoLongueur = Math.round(PanoLongueur/10) + 10;
			trace("PanoDistanceOrigine2:"+PanoDistanceOrigine);
			trace("Panolongueur2:"+PanoLongueur);
			
			/**€
			
			
			// Recherche les points visibles du panorama
			for(var i:Number = 0; i < ListPointsPano.length; i++ ) {
				if(EstDansLeChampDeVision(ListPointsPano[i].xX, ListPointsPano[i].yY)) {
					listePointsPanoramaVus[nbPointsPanoVus] = i;
					nbPointsPanoVus++;
				}
			}
			trace("ListPointsPano.length:"+ListPointsPano.length);
			trace("nbPointsPanoVus:"+nbPointsPanoVus);
			trace("Perso : "+pers.getX2D()+"  "+pers.getY2D());
			// Si des points sont trouvés, alors on lance les calculs
			if (listePointsPanoramaVus.length > 0) {
				
				// Calcul des points gauche et droit :
				// Calcul à la main du modulo (pour pas dépacer le tableau)
				if ((listePointsPanoramaVus[0] - 1) < 0) {
					positionI = ListPointsPano.length - 1;
				} else {
					positionI = listePointsPanoramaVus[0] - 1;
				}
				trace("1positionI:"+positionI);
				// Calcul du x gauche
				xTemp = Equation1(
							ListPointsPano[positionI].xX,
							ListPointsPano[positionI].yY,
							ListPointsPano[listePointsPanoramaVus[0]].xX,
							ListPointsPano[listePointsPanoramaVus[0]].yY,
							77);
				trace("1xTemp:"+xTemp);
				// Calcul du y gauche
				yTemp = Equation2a(
							ListPointsPano[positionI].xX,
							ListPointsPano[positionI].yY,
							ListPointsPano[listePointsPanoramaVus[0]].xX,
							ListPointsPano[listePointsPanoramaVus[0]].yY,
							xTemp);
				trace("1yTemp:"+yTemp);			
				var dmc = {xX:xTemp, yY:yTemp};
				trace("1dmc:"+dmc);
				PointPanoGauche = new Array(xTemp, yTemp);
				trace("PointPanoGauche:"+PointPanoGauche);
				
				// Calcul à la main du modulo (pour pas dépacer le tableau)
				if (listePointsPanoramaVus[listePointsPanoramaVus.length] + 1 >= ListPointsPano.length) {
					positionI = 0;
				} else {
					positionI = listePointsPanoramaVus[listePointsPanoramaVus.length] + 1;
				}
				trace("2positionI:"+positionI);
				// Calcul du x droit
				xTemp = Equation1(
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].xX,
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].yY,
							ListPointsPano[positionI].xX,
							ListPointsPano[positionI].yY,
							-77);
				trace("2xTemp:"+xTemp);
				// Calcul du y droit
				yTemp = Equation2a(
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].xX,
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].yY,
							ListPointsPano[positionI].xX,
							ListPointsPano[positionI].yY,
							xTemp);
				trace("2yTemp:"+yTemp);
				var dmc2 = {xX:xTemp, yY:yTemp};
				trace("dmc2:"+dmc2);			
				PointPanoDroit = new Array(xTemp, yTemp);
				trace("PointPanoDroit:"+PointPanoDroit);
			}			
			// Si rien n'est trouvé, recherche des points les plus proches
			else {
				// Recherche les points visibles du panorama
				for(var k:Number=0; k < ListPointsPano.length; k++) {
					positionI = (k + 1)%ListPointsPano.length;
					trace("3positionI:"+positionI);
					if(Intersection(
								// Segment 1 point 1
								ListPointsPano[k].xX,
								ListPointsPano[k].yY,
								// Segment 1 point 2
								ListPointsPano[positionI].xX,
								ListPointsPano[positionI].yY,
								// Segment 2 point 1 : origine
								pers.getX2D(),
								pers.getY2D(),
								// Segment 2 point 2 (point hypothétique)
								pers.getX2D() + 1000 * Math.cos((pers.getAngleAbsolu() + 70)*Math.PI/180),
								pers.getY2D() + 1000 * Math.sin((pers.getAngleAbsolu() + 70)*Math.PI/180)
							).length > 1) {
						trace("est dans l'intersection 3");
						listePointsPanoramaVus[0] = k;
						listePointsPanoramaVus[1] = positionI;
						
						pointcourant = Intersection(
											// Segment 1 point 1
											ListPointsPano[k].xX,
											ListPointsPano[k].yY,
											// Segment 1 point 2
											ListPointsPano[positionI].xX,
											ListPointsPano[positionI].yY,
											// Segment 2 point 1 : origine
											pers.getX2D(),
											pers.getY2D(),
											// Segment 2 point 2 (point hypothétique)
											pers.getX2D() + 1000 * Math.cos((pers.getAngleAbsolu()+70)*Math.PI/180),
											pers.getY2D() + 1000 * Math.sin((pers.getAngleAbsolu()+70)*Math.PI/180)
										);
						trace("pointcourant1:"+pointcourant);
						//var dmc3 = {xX:pointcourant.xX, yY:pointcourant.yY};			
						PointPanoGauche = new Array(pointcourant[0], pointcourant[1]);
						
						pointcourant = Intersection(
											// Segment 1 point 1
											ListPointsPano[k].xX,
											ListPointsPano[k].yY,
											// Segment 1 point 2
											ListPointsPano[positionI].xX,
											ListPointsPano[positionI].yY,
											// Segment 2 point 1 : origine
											pers.getX2D(),
											pers.getY2D(),
											// Segment 2 point 2 (point hypothétique)
											pers.getX2D() + 10 * Math.cos((pers.getAngleAbsolu()-70)*Math.PI/180),
											pers.getY2D() + 10 * Math.sin((pers.getAngleAbsolu()-70)*Math.PI/180)
										);
						trace("pointcourant2:"+pointcourant);
						//trace("pointcourant2:"+pointcourant[0] +"  "+pointcourant[1]);									
						//var dmc4 = {xX:pointcourant.xX, yY:pointcourant.yY};
						
						
						PointPanoDroit = new Array(pointcourant[0], pointcourant[1]);
						
						trace("Point gauche:" + PointPanoGauche[0] + "   " + PointPanoGauche[1]);
						trace("Point droit:" + PointPanoDroit[0] + "   " + PointPanoDroit[1]);
						
						/**DistanceMaxPlan = Math.max(
												DistanceDuPointDeVue(PointPanoGauche.xX, PointPanoGauche.yY),
												DistanceDuPointDeVue(PointPanoDroit.xX, PointPanoDroit.yY)
											);
						trace("DistanceMaxPlan4:"+DistanceMaxPlan);
						trace(PointPanoGauche[0]);
						trace(PointPanoGauche[1]);
						trace(ListPointsPano[k].xX);
						trace(ListPointsPano[k].yY);
						// Correction de distance :
						PanoDistanceOrigine = 0 - DistanceEntreDeuxPoints(
										PointPanoGauche[0],
										PointPanoGauche[1],
										ListPointsPano[k].xX,
										ListPointsPano[k].yY);
						trace("PanoDistanceOrigine2-2:"+PanoDistanceOrigine);
					}else{
						trace("pas d'intersection");
					}
				}
				
			}
			
						
			// Conversion pour le groupe 1 :
			for(var l:Number=0; l < listePointsPanoramaVus[0]; l++) {
				PanoDistanceOrigine = PanoDistanceOrigine + DistanceEntreDeuxPoints(ListPointsPano[l].xX,ListPointsPano[l].yY,ListPointsPano[l + 1].xX,ListPointsPano[l + 1].yY);
			}
			trace("DistanceEntreDeuxPoints("+PointPanoGauche[0]+", "+PointPanoGauche[1]+", "+PointPanoDroit[0]+", "+PointPanoDroit[1]+")");
			PanoLongueur = DistanceEntreDeuxPoints(PointPanoGauche[0], PointPanoGauche[1], PointPanoDroit[0], PointPanoDroit[1]);
			trace("Panolongueur:"+PanoLongueur);
			
			**/
			
		}
		
		
		
		//on ne voit que les personnage dans notre champs de visions
		//pour chaque personnage affiché on recupere l'image correspondante a l'angle vue
		//et on la fait afficher a ces coordonnées 3D		
		public function AfficheVue3D():void
		{												
			// Lancement des calculs
			InitialiserVue();
			
			/**DEBUT INTEGRATION GROUPE1**/
			trace("PanoDistanceOrigine  : "+PanoDistanceOrigine);
			trace("PanoLongueur  : "+PanoLongueur);			
			trace("panorama : "+Panorama);
			Panorama.setDebut(PanoDistanceOrigine);
			Panorama.setLargeur(PanoLongueur);
			Panorama.Affiche();
			/**FIN INTEGRATION GROUPE1**/
						
			/**afficher un sol en damier (eventuelement)**/
			
			//afficher tout les acteurs					
			for(var i:* in ListeActeur)
			{
				if(!(Acteur)(ListeActeur[i]).isEnVue(pers)){
					(Acteur)(ListeActeur[i]).visible = false;
				}else{
					(Acteur)(ListeActeur[i]).visible = true;
				}
				(ListeActeur[i]).affiche3D();
			} 
		}
		
		//afin d'eviter le rechargement de toute la vue 3D a chaque modification sur une personne
		//on actualise la personne qui a changer (angle, position)
		//le sprite est ajouter avec un effet de dispation (incrementation de l'alpha)
		private function AffichePers3D(newPers:Personne):void
		{
			trace("affiche 3D : proprio ("+pers.getName()+") pers ("+newPers.getName()+") isEnVue="+newPers.isEnVue(pers));
			if (newPers.isEnVue(pers))
			{				
				newPers.affiche3D();	
			}						
		}
		
		//lorsqu'un perso change de position ou se deconnecte ou supprime son image de la vue 3D
		//le sprite est supprimer avec un effet de dispation (incrementation de l'alpha)
		private function SuppPers3D(newPers:Personne):void
		{
			ListeActeur.splice(ListeActeur.indexOf(newPers,0),1);
			this.removeChild(newPers);
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel droite
		public function TourneDroite():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()-2);
			for(var i:* in ListeActeur)
			{				
				(Acteur)(ListeActeur[i]).setAnglePOX(pers,2);
				//(Acteur)(ListeActeur[i]).setAngleVue(((Acteur)(ListeActeur[i]).getAngleVue()-2));
				(Acteur)(ListeActeur[i]).CalculCoordonnee3D(pers);
			}
			AfficheVue3D();		
			//avertir le serveur que l'orientation de pers a changer
			var newPos:XML = new XML("<orientation  pseudo='"+pers.getName()+"'><angle>"+pers.getAngleAbsolu()+"</angle></orientation>");
			(Vue)(parent).client.send("<orientation  pseudo='"+pers.getName()+"'><angle>"+pers.getAngleAbsolu()+"</angle></orientation>"); 
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel gauche
		public function TourneGauche():void
		{
				//(Acteur)(ListeActeur[i]).setAngleVue((angleTemp));
			pers.setAngleAbsolu(pers.getAngleAbsolu()-2);
			for(var i:* in ListeActeur)
			{
				(Acteur)(ListeActeur[i]).setAnglePOX(pers,-2);
				//(Acteur)(ListeActeur[i]).setAngleVue(((Acteur)(ListeActeur[i]).getAngleVue()-2));
				(Acteur)(ListeActeur[i]).CalculCoordonnee3D(pers);
			}
			AfficheVue3D();
			//avertir le serveur que l'orientation de pers a changer
			var newPos:XML = new XML("<orientation  pseudo='"+pers.getName()+"'><angle>"+pers.getAngleAbsolu()+"</angle></orientation>");
			(Vue)(parent).client.send("<orientation  pseudo='"+pers.getName()+"'><angle>"+pers.getAngleAbsolu()+"</angle></orientation>"); 
		}
		
		
		//qd un nouveau personnage est ajoute on calcule ces coordonnées 3D par rapport a la vue du personnage
		//et rafficher la vue actualisé
		public function CallBackAjoutPersonnage(newPers:Personne):void
		{
			this.addChild(newPers);
			ListeActeur.push(newPers);						
			newPers.CalculCoordonnee3D(pers);	
			newPers.CalculDistance(pers);
			newPers.CalculRedimensionnement3D(DistanceMaxPlan);
			newPers.CalculAngleVue(newPers);
			reOrderTab();			
			//on retri le tableau
			AffichePers3D(newPers);
		}
		
		public function CallBackSuppPersonnage(newPers:Personne):void
		{
			//on supprime le pers dans le tableau
			SuppPers3D(newPers);
			reOrderTab();
		}
		
		//qd un personnage change de position on doit recalculer ses coordonnées 3D 
		//et rafficher la vue actualisé
		public function CallBackPosition(newPers:Personne):void
		{
			SuppPers3D(newPers);
			newPers.CalculCoordonnee3D(pers);
			newPers.CalculDistance(pers);	
			newPers.CalculRedimensionnement3D(DistanceMaxPlan);
			//on retri le tableau
			reOrderTab();
			AffichePers3D(newPers);
		}				
		
		
		//qd un personnage change d'orientation il faut recalculer  l'angle vue
		//et rafficher la vue actualisé
		public function CallBackOrientation(newPers:Personne):void
		{
			trace("NEWPERS ORIENTATION:"+newPers);
			newPers.CalculAngleVue(pers);
			AffichePers3D(newPers);
		}
		
		private function sortOnDist(a:Acteur, b:Acteur):Number{
   			 
   			var aDist:Number = a.getDistanceProprio();
    		var bDist:Number = b.getDistanceProprio();

    		if(aDist > bDist){
    		    return -1;
   			}else if(aDist < bDist){
    		    return 1;
    		}else{
       		 return 0;
    		}
		}
		
		private function reOrderTab():void{
			ListeActeur.sort(sortOnDist);
			for(var i:int = 0; i < ListeActeur.length; i++){
				this.setChildIndex(ListeActeur[i],i);
			}
		}
		
		
		public function EstDansLeChampDeVision(xR:Number,yR:Number):Boolean {
			var eq1:Number = 0;
			var eq2:Number = 0;
			
			eq1 = (Math.cos((pers.getAngleVue() - 70)*Math.PI/180) * yR - Math.sin((pers.getAngleVue() - 70)*Math.PI/180) * xR)/(Math.cos((pers.getAngleVue() - 70)*Math.PI/180) * pers.getY2D() - Math.sin((pers.getAngleVue() - 70)*Math.PI/180) * pers.getX2D());
			
			eq2 = (Math.cos((pers.getAngleVue() + 70)*Math.PI/180) * yR - Math.sin((pers.getAngleVue() + 70)*Math.PI/180) * xR)/(Math.cos((pers.getAngleVue() + 70)*Math.PI/180) * pers.getY2D() - Math.sin((pers.getAngleVue() + 70)*Math.PI/180) * pers.getX2D());
			
			return (eq1 > 0 && eq2 < 0) ;
		}
		
		public function DistanceDuPointDeVue(xR:Number,yR:Number):Number {
			return DistanceEntreDeuxPoints(xR, yR, pers.getX2D(), pers.getY2D());
		}
		
		public function DistanceEntreDeuxPoints(xR:Number,yR:Number,xA:Number,yA:Number):Number {
			return Math.sqrt(Math.pow(xR - xA, 2) + Math.pow(yR - yA, 2));
		}
		
		
		public function Equation1(x4:Number, y4:Number, x5:Number, y5:Number, theta:Number):Number {
			return (y4 - x4 * ((y5 -y4)/(x5 - x4)) + (pers.getY2D()/pers.getX2D())*((Math.cos((pers.getAngleVue() + theta) - 1)*Math.PI/180)/(Math.sin((pers.getAngleVue() + theta) - 1)*Math.PI/180)))/(((y5 - y4)/(x5 - x4)) - pers.getY2D() - pers.getY2D()*((Math.cos((pers.getAngleVue() + theta) - 1)*Math.PI/180)/(Math.sin((pers.getAngleVue() + theta) - 1)*Math.PI/180)));
		}
		
		public function Equation2a(x4:Number, y4:Number, x5:Number, y5:Number, x2:Number):Number {
			var tp_var:Number = (((y5 - y4)/(x5 - x4)) * x2 + y4 - x4 * ((y5 - y4)/(x5 - x4)))
			return tp_var;
		}
		
		
		public function Intersection(Ax:Number, Ay:Number, Bx:Number, By:Number, Cx:Number, Cy:Number, Dx:Number, Dy:Number):Array{
			
			trace("  A :"+Ax+" "+Ay+"  B :"+Bx+" "+By+"  C :"+Cx+" "+Cy+"  D :"+Dx+" "+Dy);
			var Sx : Number = 0;
			var Sy : Number = 0;
			var pCD : Number = 0;
			var pAB : Number = 0;
			var oCD : Number = 0;
			var oAB : Number = 0;
 
			if(Ax==Bx)
			{
				if(Cx==Dx) return new Array();
				else
				{
					pCD = (Cy-Dy)/(Cx-Dx);
					Sx = Ax;
					Sy = pCD*(Ax-Cx)+Cy;
				}
			}
			else
			{
				if(Cx==Dx)
				{
					pAB = (Ay-By)/(Ax-Bx);
					Sx = Cx;
					Sy = pAB*(Cx-Ax)+Ay;
				}
				else
				{
					pCD = (Cy-Dy)/(Cx-Dx);
					pAB = (Ay-By)/(Ax-Bx);
					oCD = Cy-pCD*Cx;
					oAB = Ay-pAB*Ax;
					Sx = (oAB-oCD)/(pCD-pAB);
					Sy = pCD*Sx+oCD;
				}
			}
			if( (Sx<Ax && Sx<Bx) ||
				(Sx>Ax && Sx>Bx) ||
				(Sx<Cx && Sx<Dx) ||
				(Sx>Cx && Sx>Dx) ||
				(Sy<Ay && Sy<By) ||
				(Sy>Ay && Sy>By) ||
				(Sy<Cy && Sy<Dy) ||
				(Sy>Cy && Sy>Dy)) {
					return new Array();
				} else {
					trace("intersection trouvé: "+ Sx +"   " + Sy);
					return new Array(Sx, Sy);
				}
		}
		
	}
	
}
