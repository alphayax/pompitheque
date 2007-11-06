package
{
	import flash.display.*;
	import flash.net.*;
	
	public class Personne extends Acteur
	{
		
		//type de l'avatar vue ('pocahontas'...)
		private var typeAvatar:String;
		
		//stature de l'avatar vue ('assis' ou 'debout')
		private var statureAvatar:String;	
		
		public function Personne(nom:String,x:Number,y:Number,angleAbsolu:Number,statureAvatar:String,typeAvatar:String){
			super(nom,x,y,angleAbsolu);
			this.typeAvatar=typeAvatar;	
			this.statureAvatar=statureAvatar;	
			
			
		}
		
		//affiche la personne au coordonnées 3D (vue3D)
		public override function affiche3D():void
		{
			
		}
		
		//affiche la personne au coordonnées 2D (vue2D)
		public override function affiche2D():void
		{
			
		}
		
		
		//renvoie l'adresse de l'image correspondant a la vue de la personne
		public function getImage():String
		{
			return "image";
		}
		
		//renvoie les 4 coordonnées correspondant a la zone texte de la photo image
		public function getZoneTexte():Array
		{
			//possibilité de les stocké ds un fichier XML
			//->
			//on recupere les coordonnées correspondant ds le fichier xml
			//on applique la reduction de taille dut la perspective pour coller a la photo
			return new Array();
		}		
		
		public function setStatureAvatar(statureAvatar:String):void {this.statureAvatar=statureAvatar;}
	}
}