package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	//on a juste besoin de la taille de la piece (largeur, longueur, coordonnée)
	//et de la liste des personnes
	public class Vue3D extends Sprite
	{
		//propriaitaire de la vue 3D
		private var pers:Personne;
		//Liste des personnes
		private var ListePersonne:Array;
		//Liste des objet du mobilier
		private var ListeObjet:Array;
		//Distance max entre deux personnes (utile pour calculer le redimensionnement)
		private var DistanceMaxPlan:Number;
		
		//on cree une vue 3D a partir d'un personnage
		public function Vue3D(pers:Personne,ListePersonne:Array,ListeObjet:Array,DistanceMaxPlan:Number)
		{
			//propriaitaire de la vue 3D
			this.pers=pers;
			//on recupere la distance max entre deux personnes
			this.DistanceMaxPlan=DistanceMaxPlan;
			//on recupere la liste des personnages de la vue
			this.ListePersonne=ListePersonne;
			//on recupere la liste des objet du mobilier de la vue
			this.ListeObjet=ListeObjet;
			//pour chaque personnage on calcule les coordonnées 3D et l'angle vue
			for(var i:* in ListePersonne)
			{
				CalculCoordonnee3D(ListePersonne[i]);
				CalculRedimensionnement3D(ListePersonne[i]);
				CalculProfondeur(ListePersonne[i]);
				CalculAngleVue(ListePersonne[i]); 
			}	
			
			//pour chaque objet du mobilier on calcule les coordonnées et l'angle de vue
			for(var j:* in ListeObjet)
			{
				
			}
							
			AfficheVue3D();
		}		
		
		//on ne voit que les personnage dans notre champs de visions
		//pour chaque personnage affiché on recupere l'image correspondante a l'angle vue
		//et on la fait afficher a ces coordonnées 3D		
		public function AfficheVue3D():void
		{
			//supprimer tout les elements de la vue 3D
			
			//afficher le fond (panorama, fausse3D)
			//il faut calculer ici la taille du mur que l'on voit par rapport a la piece
			//et executer la fonction prevu par le groupe 1 qui va nous renvoyer l'image de fond
			
			//afficher un sol en damier (eventuelement)
			
			//afficher tout les objets du mobilier

			//on fait afficher tout les personnages							
			for(var i:* in ListePersonne)
			{
				if (CalculPersVue(ListePersonne[i])) //si la personne est ds le champ de vision
				{
					ListePersonne[i].affichePers3D();
					this.addChildAt(ListePersonne[i],0-ListePersonne[i].getProfondeurVue);
				}
			} 
		}
		
		//afin d'eviter le rechargement de toute la vue 3D a chaque modification sur une personne
		//on actualise la personne qui a changer (angle, position)
		private function AffichePers(pers:Personne):void
		{
			if (CalculPersVue(pers))
			{
				//on supprime le child a la pronfondeur de pers (0-pers.getProfondeurVue())				
				//puis on affiche la pers
				pers.affichePers3D();	
			}						
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel droite
		private function TourneDroite():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()+10);
			for(var i:* in ListePersonne)
			{
				CalculAngleVue(ListePersonne[i]);
			}			
			AfficheVue3D();			
			//avertir le serveur que l'orientation de pers a changer
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel gauche
		private function TourneGauche():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()-10);
			for(var i:* in ListePersonne)
			{
				CalculAngleVue(ListePersonne[i]);
			}
			AfficheVue3D();
			//avertir le serveur que l'orientation de pers a changer
		}
		
		
		//qd un nouveau personnage est ajoute on calcule ces coordonnées 3D par rapport a la vue du personnage
		//et rafficher la vue actualisé
		public function CallBackAjoutPersonnage(newPers:Personne):void
		{
			CalculCoordonnee3D(newPers);
			CalculRedimensionnement3D(newPers);
			CalculProfondeur(newPers);
			CalculAngleVue(newPers);			
			AffichePers(newPers);
		}
		
		//qd un personnage change de position on doit recalculer ses coordonnées 3D 
		//et rafficher la vue actualisé
		public function CallBackPosition(newPers:Personne):void
		{
			CalculCoordonnee3D(newPers);	
			CalculRedimensionnement3D(newPers);
			CalculProfondeur(newPers);
			AffichePers(newPers);
		}				
		
		//qd un personnage change d'orientation il faut recalculer  l'angle vue
		//et rafficher la vue actualisé
		public function CallBackOrientation(newPers:Personne):void
		{
			CalculAngleVue(newPers);
			AffichePers(newPers);
		}
		
		//calcul pour savoir si une personne est dans l'angle de vue (renvoie true) ou pas (renvoie false)
		//on se base sur les calculs de berenger
		private function CalculPersVue(persVue:Personne):Boolean
		{
				return true;
		}
		
		//calcul de l'angle du personnage vue par le personnage propriaitaire de la vue3D
		//on se base sur l'angle absolue du personnage vue (donc par rapport a la grille)
		//on trouve l'angle vue par rapport a l'angle absolu au propriaitaire de la vue3D
		private function CalculAngleVue(persVue:Personne):void
		{
			
		}

		//calcul des coordonnées 3D d'une personne de la vue
		//a partir des coordonnées 2D d'une personne de la vue,
		//de la distance entre le personnage proprio et le mur
		//et des coordonnées 2D du personnage propriaitaire de la vue3D
		private function CalculCoordonnee3D(persVue:Personne):void
		{
			
		}
		
		//calcul la taille de l'image recuperer
		//basé sur la perspective
		private function CalculRedimensionnement3D(persVue:Personne):void
		{
			
		}
		
		//calcul la profondeur du calque sur laquelle on va faire afficher la personne
		private function CalculProfondeur(persVue:Personne):void
		{
			
		}
		
	}
}