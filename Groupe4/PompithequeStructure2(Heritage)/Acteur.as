package
{
	import flash.display.Sprite;
	import flash.system.System;
	
	//On defini un acteur comme un objet a afficher
	//donc ce sera soit une Personne soit un objet du mobilier
	//les methode de calcul pour le placement dans la vue 3D sont les meme
	//seul l'affichage de l'objet va changer et donc sera overrider dans les sous classes
	
	public class Acteur extends Sprite
	{
		//nom de l'acteur (personne ou objet)
		private var nom:String;
		
		//position sur la grille (créé sur le serveur)
		private var x2D:Number;
		private var y2D:Number;		
		
		//position 3D (créé par la vue 3D)
		private var x3D:Number;
		private var y3D:Number;
		private var z3D:Number;
		
		//angle absolu, c'est a dire fixe par rapport a la grille
		//il ne changera pas pour un objet
		//il va changer qd la personne va tourner
		private var angleAbsolu:Number; 
		
		//angle de l'acteur vue par une personne			
		private var angleVue:Number;
		
		//profondeur du calque sur lequel on va faire afficher l'acteur
		//necessaire pour l'affichage dans l'ordre avec le addchild et pour le tri dans le tableau d'acteur de la vue
		private var profondeurVue:Number;
		
		//distance entre l'acteur et le proprio
		private var distanceProprio:Number;
		
		//pourcentage de la taille de l'acteur a afficher
		private var tailleImage:Number;		
		
		public function Acteur(nom:String,x2D:Number,y2D:Number,angleAbsolu:Number)
		{
			this.nom=nom;
			this.x2D=x;
			this.y2D=y;
			this.angleAbsolu=angleAbsolu;			
		}
		
		//affiche l'acteur au coordonnées 3D (vue3D)
		public function affiche3D():void
		{
			
		}
		
		//affiche l'acteur au coordonnées 2D (vue2D)
		public function affiche2D():void
		{
			
		}				

		//calcul des coordonnées 3D de l'acteur de la vue
		//a partir des coordonnées 2D de l'acteur de la vue,
		//de la distance maximale dans le plan
		//et des coordonnées 2D du personnage propriaitaire de la vue3D
		public function CalculCoordonnee3D(persProprio:Personne):void
		{
			
		}
		
		
		//calcul la distance entre l'acteur et le propriaitaire de la vue 3D
		public function CalculDistance(persProprio:Personne):void
		{
			this.distanceProprio=0;
		}
		
		//calcul du % de la taille de l'acteur a afficher
		//on a besoin de la distance entre le proprio et l'acteur et la distance max dans le plan
		public function CalculRedimensionnement3D(distanceMax:Number):void
		{
			
		}
		
		//calcul pour savoir si un acteur est dans l'angle de vue (renvoie true) ou pas (renvoie false)
		public function isEnVue(persProprio:Personne):Boolean
		{
				return true;
		}
		
		//calcul de l'angle de l'acteur vue par le personnage propriaitaire de la vue3D
		//on se base sur l'angle absolue de l'acteur vue (donc par rapport a la grille)
		public function CalculAngleVue(persProprio:Personne):void
		{
			
		}
		
		
		
		//accesseur
		public function getX2D():Number {return x2D;}
		public function getY2D():Number {return y2D;}
		public function setX2D(x2D:Number):void {this.x2D=x2D}
		public function setY2D(y2D:Number):void {this.y2D=y2D}
		
		public function getX3D():Number {return x2D;}
		public function getY3D():Number {return y2D;}
		public function getZ3D():Number {return y2D;}
		public function setX3D(x3D:Number):void {this.x3D=x3D}
		public function setY3D(y3D:Number):void {this.y3D=y3D}
		public function setZ3D(Z3D:Number):void {this.y3D=y3D}
		
		public function getAngleAbsolu():Number {return angleAbsolu;}
		public function setAngleAbsolu(angleAbsolu:Number):void {this.angleAbsolu=angleAbsolu;}
		
		public function setAngleVue(angleVue:Number):void {this.angleVue=angleVue;}
		
		public function getProfondeurVue():Number {return profondeurVue;}
		public function setProfondeurVue(profondeurVue:Number):void {this.profondeurVue=profondeurVue;}
	}
}