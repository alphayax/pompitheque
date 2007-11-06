package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
	
	//on a juste besoin de la taille de la piece (largeur, longueur, coordonnée)
	//et de la liste des personnes
	public class Vue3D extends Sprite
	{
		//propriaitaire de la vue 3D
		private var pers:Personne;
		//Liste des acteurs : contiendra des Personnes et des objet du mobilier
		private var ListeActeur:Array;
		//Distance max dans le plan (utile pour calculer le redimensionnement)
		private var DistanceMaxPlan:Number;
		
		//on cree une vue 3D a partir d'un personnage
		public function Vue3D(pers:Personne,ListeActeur:Array,DistanceMaxPlan:Number)
		{
			super();
			//--------------------------------------------
			//pour les test on ajoute l'angle de vue de 140°
			// centre de la rotation
			var xCenter:Number = 400;
			var yCenter:Number = 500;
			var angleVue:Number = 140;
			var largeurVue:Number = 250;
			graphics.lineStyle(1);
			graphics.moveTo(xCenter,yCenter);
			graphics.lineTo(xCenter+largeurVue,yCenter-Math.atan(30*Math.PI/180)*largeurVue);
			graphics.moveTo(xCenter,yCenter);
			graphics.lineTo(xCenter-largeurVue,yCenter-Math.atan(30*Math.PI/180)*largeurVue);
			//---------------------------------------------
			
			
			//propriaitaire de la vue 3D
			this.pers=pers;
			//on recupere la distance max dans le plan
			this.DistanceMaxPlan=DistanceMaxPlan;
			//on recupere la liste des acteurs (personnes et mobilier) de la vue
			this.ListeActeur=ListeActeur;
			//pour chaque acteur on calcule les coordonnées 3D et l'angle vue
			for(var i:* in ListeActeur)
			{
				ListeActeur[i].CalculCoordonnee3D(pers);				
				ListeActeur[i].CalculDistance(pers);
				ListeActeur[i].CalculRedimensionnement3D(DistanceMaxPlan);
				ListeActeur[i].CalculAngleVue(pers); 
			}	
			//ListeActeur.sortOn("distanceProprio",Array.DESCENDING);			
			AfficheVue3D();
			
			this.addEventListener("enterFrame",enterFrame_handler);
		}	
		
		public function enterFrame_handler(e:Event):void{
			stage.focus=this;
			addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);			
		}
		
		public function reportKeyDown(event:KeyboardEvent):void {
			// Fleche gauche 
			if ( event.keyCode == 37 ) {
				this.TourneGauche()();
			}			
			// Fleche droite
			if ( event.keyCode == 39 ){
				this.TourneDroite();
			}
		}	
		
		//on ne voit que les personnage dans notre champs de visions
		//pour chaque personnage affiché on recupere l'image correspondante a l'angle vue
		//et on la fait afficher a ces coordonnées 3D		
		public function AfficheVue3D():void
		{									
			//on ne supprime rien (moins lourd) car on raffiche sur le meme niveau
			
			//afficher le fond (panorama, fausse3D)
			//il faut calculer ici la taille du mur que l'on voit par rapport a la piece
			//et executer la fonction prevu par le groupe 1 qui va nous renvoyer l'image de fond
			
			//afficher un sol en damier (eventuelement)
			
			//afficher tout les acteurs					
			for(var i:* in ListeActeur)
			{
				if (ListeActeur[i].isEnVue(pers)) //si la personne est ds le champ de vision
				{
					ListeActeur[i].affiche3D();
					this.addChild(ListeActeur[i]);
				}
			} 
		}
		
		//afin d'eviter le rechargement de toute la vue 3D a chaque modification sur une personne
		//on actualise la personne qui a changer (angle, position)
		private function AffichePers3D(newPers:Personne):void
		{
			if (newPers.isEnVue(pers))
			{
				newPers.affiche3D();	
			}						
		}
		
		//lorsqu'un perso change de position ou se deconnecte ou supprime son image de la vue 3D
		private function SuppPers3D(newPers:Personne):void
		{
			//on ne supprime l'image de la personne que si elle est afficher et donc en vue
			if (newPers.isEnVue(pers))
			{
				//on supprime le pers dans la vue3D (suppression du child)
			}						
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel droite
		private function TourneDroite():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()+10);
			// tester si l'angle vue change ou pas
			for(var i:* in ListeActeur)
			{
				ListeActeur[i].CalculAngleVue(pers);
			}	
			AfficheVue3D();			
			//avertir le serveur que l'orientation de pers a changer
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel gauche
		private function TourneGauche():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()-10);
			for(var i:* in ListeActeur)
			{
				ListeActeur[i].CalculAngleVue(pers);
			}
			AfficheVue3D();
			//avertir le serveur que l'orientation de pers a changer
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
			//on retri le tableau
			AffichePers3D(newPers);
		}
		
		public function CallBackSuppPersonnage(newPers:Personne):void
		{
			//on supprime le pers dans le tableau
			SuppPers3D(newPers);
			//on retri le tableau
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
			AffichePers3D(newPers);
		}				
		
		//qd un personnage change d'orientation il faut recalculer  l'angle vue
		//et rafficher la vue actualisé
		public function CallBackOrientation(newPers:Personne):void
		{
			newPers.CalculAngleVue(pers);
			AffichePers3D(newPers);
		}
		
		
	}
}