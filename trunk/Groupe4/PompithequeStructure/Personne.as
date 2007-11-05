package
{
	public class Personne
	{
		
		//nom de la personne
		private Nom:String;
		
		//position sur la grille (créé sur le serveur)
		private x2D:Number;
		private y2D:Number;		
		
		//position 3D (créé par la vue 3D)
		private x3D:Number;
		private y3D:Number;
		private z3D:Number;
		
		//pourcentage de la taille de la photo de l'avatar
		//il sera different pour chaque Client 
		private tailleImage:Number;
		
		//angle absolu, c'est a dire fixe par rapport a la grille
		//il va changer qd la personne va tourner
		private angleAbsolu:Number; 
		
		//angle de la personne vue par une autre personne
		//il va changer qd une personne va regarder ce personnage
		//il sera different pour chaque Client
		private angleVue:Number;
		
		//type de l'avatar vue ('pocahontas'...)
		private typeAvatar:String;
		
		//stature de l'avatar vue ('assis' ou 'debout')
		private statureAvatar:String;	
		
		public function Personne(nom:String,x:Number,y:Number,angleAbsolu:Number,statureAvatar:String,typeAvatar:String){
			this.nom=nom;
			this.angleAbsolu=angleAbsolu;
			this.typeAvatar=typeAvatar;	
			this.statureAvatar=statureAvatar;	
			this.posX=x;
			this.posY=y;
		}
		
		//affiche l'image au coordonnées 3D (vue3D)
		public function affichePers3D():void
		{
			
		}
		
		//affiche la personne au coordonnées 2D (vue2D)
		public function affichePers2D():void
		{
			
		}
		
		//renvoie l'adresse de l'image correspondant a la vue
		public function getImage():String
		{
			
		}
		
		//renvoie les 4 coordonnées correspondant a la zone texte de la photo image
		public function getZoneTexte():Array
		{
			//possibilité de les stocké ds un fichier XML
			//->
			//on recupere les coordonnées correspondant ds le fichier xml
			//on applique la reduction de taille dut la perspective pour coller a la photo
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
		public function setAngleAbsolu(angleAbsolu:Number):void {this.angleAbsolu=angleAbsolu:Number;}
		
		public function setAngleVue(angleVue:Number):void {this.angleVue=angleVue;}
		
		public function setStatureAvatar(statureAvatar:String):void {this.statureAvatar=statureAvatar;}
	}
}