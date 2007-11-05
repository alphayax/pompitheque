package
{
	import flash.display.LineScaleMode;
	
	//on a juste besoin de la taille de la piece (largeur, longueur, coordonnée)
	//et de la liste des personnes
	public class Vue3D 	
	{
		//propriaitaire de la vue 3D
		private pers:Personne;				
		
		//on cree une vue 3D a partir d'un personnage
		public function Vue3D(personne:Personne)
		{
			//pour chaque personnage on calcule les coordonnées 3D et l'angle vue
			for(int i = 0;i<ListePersonne;i++)
			{
				CalculCoordonnee3D(ListePersonne[i]);
				CalculRedimensionnement3D(ListePersonne[i]);
				CalculAngleVue(ListePersonne[i]);
			}
		}		
		
		//on ne voit que les personnage dans notre champs de visions
		//pour chaque personnage affiché on recupere l'image correspondante a l'angle vue
		//et on la fait afficher a ces coordonnées 3D		
		public function AfficheVue3D():void
		{
			for(int i = 0;i<ListePersonne;i++)
			{
				if (CalculPersVue(ListePersonne[i])) //si la personne est ds le champ de vision
				{
					ListePersonne[i].affichePers3D();
					addchild(ListePersonne[i]);
				}
			} 
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel droite
		public function TourneDroite():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()+10);
			for(int i = 0;i<ListePersonne;i++)
			{
				CalculAngleVue(ListePersonne[i]);
			}
			AfficheVue3D();
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel gauche
		public function TourneGauche():void
		{
			pers.setAngleAbsolu(pers.getAngleAbsolu()-10);
			for(int i = 0;i<ListePersonne;i++)
			{
				CalculAngleVue(ListePersonne[i]);
			}
			AfficheVue3D();
		}
		
		
		//qd un nouveau personnage est ajoute on calcule ces coordonnées 3D par rapport a la vue du personnage
		//et rafficher la vue actualisé
		public function CallBackAjoutPersonnage(newPers:Personne):void
		{
			CalculCoordonnee3D(newPers);
			CalculRedimensionnement3D(newPers);
			CalculAngleVue(newPers);			
			AfficheVue3D();
		}
		
		//qd un personnage change de position on doit recalculer ses coordonnées 3D 
		//et rafficher la vue actualisé
		public function CallBackPosition(newPers:Personne):void
		{
			CalculCoordonnee3D(newPers);	
			CalculRedimensionnement3D(newPers);
			AfficheVue3D();
		}				
		
		//qd un personnage change d'orientation il faut recalculer  l'angle vue
		//et rafficher la vue actualisé
		public function CallBackOrientation(newPers:Personne):void
		{
			CalculAngleVue(newPers);
			AfficheVue3D();
		}
		
		//calcul pour savoir si une personne est dans l'angle de vue (renvoie true) ou pas (renvoie false)
		//on se base sur les calculs de berenger
		public function CalculPersVue(persVue:Personne):Boolean
		{
				
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
		
	}
}