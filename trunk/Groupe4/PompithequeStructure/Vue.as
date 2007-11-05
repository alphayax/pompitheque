package
{
	public class Vue {		//-> groupe3
	
		//tableau des personnes presente dans le monde
		public var ListePersonne:Array = new Array(); 
		
		//largeur et longueur du monde
		private var largeurMonde:Number;
		private var longueurMonde:Number;		
		
		public function Vue(planXML:String)
		{
			//on recupere le plan en XML		
		}
				
		//ajout d'une personne sur la grille		
		public function ajoutPersonne(name:String,x:Number,y:Number,angle:Number,stature:String,typeavatar:String)
		{
			ListePersonne[ListePersonne.length]=pers;
			//avertir le serveur
		}
	
	}
}