package Pompitheque
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
		private var DistanceMaxPlan:Number;
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
		public function Vue3D(pers:Personne,ListeActeur:Array,Plan:XML,serveur:Client)
		{
			super();
			this.serveur=serveur;
			
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
			/*****FIN TEST GROUPE4****/			
			
			//propriaitaire de la vue 3D
			this.pers=pers;
			//plan de la piece
			this.Plan=Plan;
			
			/**
			premiere (et unique) initialisation du plan
			InitialiserPlan()
			premiere initialisation des distances
			InitialiserVue();
			**/
			
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
			//ListeActeur.sort(sortOnDist);
			
			for(var i:* in ListeActeur)
			{
				addChild(ListeActeur[i]);
			}	
			reOrderTab();
			//on affiche tout les acteurs			
			AfficheVue3D();					
		}	
		
		
		// Initialisation de la piece		
		public function InitialiserPlan():void
		{
			var numPoints : Number = 0;
			ListPointsPano = new Array();
			
			// Récupère les points
			for each(var baliseMur:XML in Plan..mur)
			{
				ListPointsPano[numPoints] = {xX:baliseMur.attribute("x1"),yY:baliseMur.attribute("y1")};
				numPoints++;
			}
		}
		
		

		
		
		
		//on ne voit que les personnage dans notre champs de visions
		//pour chaque personnage affiché on recupere l'image correspondante a l'angle vue
		//et on la fait afficher a ces coordonnées 3D		
		public function AfficheVue3D():void
		{												
			// Lancement des calculs
			InitialiserVue();
			
			/**DEBUT INTEGRATION GROUPE1
			afficher le fond (panorama, fausse3D)
			il faut calculer ici la taille du mur que l'on voit par rapport a la piece
			et executer la fonction prevu par le groupe 1 qui va nous renvoyer l'image de fond
			FIN INTEGRATION GROUPE1**/
			Panorama.setDebut(PanoDistanceOrigine);
			Panorama.setLargeur(PanoLongueur);
			Panorama.Affiche();
			
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
			serveur.send(newPos); 
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
			serveur.send(newPos); 
		}
		
		
		//qd un nouveau personnage est ajoute on calcule ces coordonnées 3D par rapport a la vue du personnage
		//et rafficher la vue actualisé
		public function CallBackAjoutPersonnage(newPers:Personne):void
		{
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
							
		// Initialisation des distances pour le point de vu courant
		// A faire avant chaque vue 3D !!
		// Determine et enregistre :
		//   - la distance max
		//   - le point gauche et droit du panorama
		public function InitialiserVue():void
		{
			
			var listePointsPanoramaVus : Array = new Array();
			var nbPointsPanoVus : Number = 0;
			var distanceCourante:Number = 0;
			PointPanoGauche = new Array();
			PointPanoDroit = new Array();
			var xTemp : Number;
			var yTemp : Number;
			var positionI : Number;
			var pointcourant : Array;
			PanoDistanceOrigine = 0;
			PanoLongueur = 0;
			
			// Recherche les points visibles du panorama
			for(var i:Number in 0..(ListPointsPano.length - 1)) {
				if(EstDansLeChampDeVision(ListPointsPano[ListPointsPano].xX, ListPointsPano[ListPointsPano].yY)) {
					listePointsPanoramaVus[nbPointsPanoVus] = i;
					nbPointsPanoVus++;
				}
			}
			
			
			// Si des points sont trouvés, alors on lance les calculs
			if (listePointsPanoramaVus.length > 0) {
				
				// Recherche de la distance la plus éloignée
				for(var j:Number in listePointsPanoramaVus) {
					distanceCourrante = DistanceDuPointDeVue(ListPointsPano[listePointsPanoramaVus[j]].xX, ListPointsPano[listePointsPanoramaVus[j]].yY);
					
					if(DistanceMaxPlan < distanceCourrante) {
						DistanceMaxPlan = distanceCourrante;
						// Eventuellement, sauvegarder ici le point le plus éloigné
					}
				}
				
				// Calcul des points gauche et droit :
				// Calcul à la main du modulo (pour pas dépacer le tableau)
				if (listePointsPanoramaVus[0] - 1 < 0) {
					positionI = ListPointsPano.length - 1;
				} else {
					positionI = listePointsPanoramaVus[0] - 1
				}
				// Calcul du x gauche
				xTemp = Equation1(
							ListPointsPano[positionI].xX,
							ListPointsPano[positionI].yY,
							ListPointsPano[listePointsPanoramaVus[0]].xX,
							ListPointsPano[listePointsPanoramaVus[0]].yY,
							77);
				// Calcul du y gauche
				yTemp = Equation2a(
							ListPointsPano[positionI].xX,
							ListPointsPano[positionI].yY,
							ListPointsPano[listePointsPanoramaVus[0]].xX,
							ListPointsPano[listePointsPanoramaVus[0]].yY,
							xTemp);
				PointPanoGauche = {xX:xTemp, yY:yTemp};
				
				// Calcul à la main du modulo (pour pas dépacer le tableau)
				if (listePointsPanoramaVus[listePointsPanoramaVus.length] + 1 >= ListPointsPano.length) {
					positionI = 0;
				} else {
					positionI = listePointsPanoramaVus[listePointsPanoramaVus.length] + 1;
				}
				// Calcul du x droit
				xTemp = Equation1(
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].xX,
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].yY,
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length] + 1 ].xX,
							ListPointsPano[listePointsPanoramaVus[0]].yY,
							-77);
				// Calcul du y droit
				yTemp = Equation2a(
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].xX,
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length]].yY,
							ListPointsPano[listePointsPanoramaVus[listePointsPanoramaVus.length] + 1 ].xX,
							ListPointsPano[listePointsPanoramaVus[0]].yY,
							xTemp);
				PointPanoDroit = {xX:xTemp, yY:yTemp};
			}			
			// Si rien n'est trouvé, recherche des points les plus proches
			else {
				// Recherche les points visibles du panorama
				for(var k:Number in ListPointPano) {
					if (k + 1 >= ListPointPano.length) {
						positionI = 0;
					} else {
						positionI = k + 1;
					}
				
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
								// Segment 2 point 2 (point hypothétique
								pers.getX2D() + 1000000 * Math.cos(pers.getAngleVue() + 70),
								pers.getY2D() + 1000000 * Math.sin(pers.getAngleVue() + 70)
							).length > 1) {
						
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
											pers.getX2D() + 1000000 * Math.cos(pers.getAngleVue() + 70),
											pers.getY2D() + 1000000 * Math.sin(pers.getAngleVue() + 70)
										);
										
						PointPanoGauche = {xX:pointcourant.xX, yY:pointcourant.yY};
						
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
											pers.getX2D() + 1000000 * Math.cos(pers.getAngleVue() - 70),
											pers.getY2D() + 1000000 * Math.sin(pers.getAngleVue() - 70)
										);
										
										
						PointPanoDroit = {xX:pointcourant.xX, yY:pointcourant.yY};
						
						DistanceMaxPlan = Math.max(
												DistanceDuPointDeVue(PointPanoGauche.xX, PointPanoGauche.yY),
												DistanceDuPointDeVue(PointPanoDroit.xX, PointPanoDroit.yY)
											);
						
						// Correction de distance :
						PanoDistanceOrigine = 0 - DistanceEntreDeuxPoints(
										PointPanoGauche.xX,
										PointPanoGauche.yY,
										ListPointsPano[k].xX,
										ListPointsPano[k].yY);
					}
				}
				
			}
			
			// Conversion pour le groupe 1 :
			for(var l:Number in 0..(listePointsPanoramaVus[0] - 1)) {
				PanoDistanceOrigine = PanoDistanceOrigine +
						      DistanceEntreDeuxPoints(
								ListPointsPano[l].xX,
								ListPointsPano[l].yY,
								ListPointsPano[l + 1].xX,
								ListPointsPano[l + 1].yY
							);
			}
			PanoLongueur = DistanceEntreDeuxPoints(PointPanoGauche.xX, PointPanoGauche.yY, PointPanoDroit.xX, PointPanoDroit.yY);
			
			// Correction des coordonn�es par rapport aux dimensions des batonnets
			PanoDistanceOrigine = Math.round(PanoDistanceOrigine / 10) * 10;
			PanoLongueur = Math.round(PanoLongueur / 10) + 10;
			
		}
		
		public function EstDansLeChampDeVision(xR:Number,yR:Number):Boolean {
			return (
					(
						Math.cos(pers.getAngleVue() - 70) * yR - Math.sin(pers.getAngleVue() - 70) * xR
					)
					/
					(
						Math.cos(pers.getAngleVue() - 70) * pers.getY2D() - Math.sin(pers.getAngleVue() - 70) * pers.getX2D()
					)
				)
				> 0
				&&
				(
					(
						Math.cos(pers.getAngleVue() + 70) * yR - Math.sin(pers.getAngleVue() + 70) * xR
					)
					/
					(
						Math.cos(pers.getAngleVue() + 70) * pers.getY2D() - Math.sin(pers.getAngleVue() + 70) * pers.getX2D()
					)
				)
				< 0;
		}
		
		public function DistanceDuPointDeVue(xR:Number,yR:Number):Number {
			return Math.sqrt(Math.pow(xR - pers.getX2D(), 2) + Math.pow(xR - pers.getY2D(), 2));
		}
		
		public function DistanceEntreDeuxPoints(xR:Number,yR:Number,xA:Number,yA:Number):Number {
			return Math.sqrt(Math.pow(xR - xA, 2) + Math.pow(xR - yA, 2));
		}
		
		
		public function Equation1(x4:Number, y4:Number, x5:Number, y5:Number, theta:Number):Number {
			return
				(
					y4 - x4 * ((y5 -y4) / (x5 - x4)) + (pers.getY2D() / pers.getX2D()) * ((Math.cos(pers.getAngleVue() + theta) - 1) / (Math.sin(pers.getAngleVue() + theta) - 1))
				)
				/
				(
					((y5 - y4) / (x5 - x4)) - pers.getY2D() - pers.getY2D() * ((Math.cos(pers.getAngleVue() + theta) - 1) / (Math.sin(pers.getAngleVue() + theta) - 1))
				);
		}
		
		public function Equation2a(x4:Number, y4:Number, x5:Number, y5:Number, x2:Number):Number {
			return
				(
					((y5 - y4) / (x5 - x4)) * x2 + y4 - x4 * ((y5 - y4) / (x5 - x4))
				);
		}
		
		
		public function Intersection(Ax:Number, Ay:Number, Bx:Number, By:Number, Cx:Number, Cy:Number, Dx:Number, Dy:Number):Array{
			var Sx : Number;
			var Sy : Number;
			var pCD : Number;
			var pAB : Number;
			var oCD : Number;
			var oAB : Number;
 
			if(Ax==Bx)
			{
				if(Cx==Dx) return false;
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
			if( (Sx<Ax && Sx<Bx) |
				(Sx>Ax && Sx>Bx) |
				(Sx<Cx && Sx<Dx) |
				(Sx>Cx && Sx>Dx) |
				(Sy<Ay && Sy<By) |
				(Sy>Ay && Sy>By) |
				(Sy<Cy && Sy<Dy) |
				(Sy>Cy && Sy>Dy)) {
					return new Array();
				} else {
					return new Array(Sx, Sy);
				}
		}
		
	}
	
}
