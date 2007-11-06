package
{	
	public class Vue {		
	
		//vue 3D
		private var vue3D:Vue3D;
		//vue 2D
		//private var vue2D:Vue2D;
		
		//distance maximale entre deux personnes
		private var DistanceMaxPlan:Number;
		
		//tableau des personnes presente dans le monde
		private var ListePersonne:Array = new Array(); 
		
		//tableau des objets du mobilier presents sur le plan
		private var ListeObjet:Array = new Array();
		
		//personne client
		private var Proprio:Personne;
		
		public function Vue(planXML:String)
		{
			//on recupere le plan en XML		
			
			//on recupere la distance max possible sur le plan
			//on recupere la liste des objet sur le plan
			
			//on recupere la liste des personnes sur le serveur
			
			//-----------------------------------------
			//pour les tests on ajoute manuelement les valeurs
			DistanceMaxPlan = 600;
			Proprio=new Personne("Bibi",20,20,0,"debout","pocahontas");
			ajoutPersonne("Sylvie",50,50,0,"debout","pocahontas");
			ajoutPersonne("Paulette",50,60,10,"debout","pocahontas");
			ajoutPersonne("Sandrine",50,70,180,"debout","pocahontas");
			ajoutPersonne("Marcelle",90,90,50,"debout","pocahontas");						
			afficheVue3D();
			//-----------------------------------------
		}
				
		//ajout d'une personne sur la grille		
		public function ajoutPersonne(name:String,x:Number,y:Number,angle:Number,stature:String,typeavatar:String):void
		{
			ListePersonne[ListePersonne.length]=new Personne(name,x,y,angle,stature,typeavatar);
			//avertir le serveur
		}
								
		public function afficheVue3D():void
		{
			vue3D = new Vue3D(Proprio,ListePersonne,ListeObjet,DistanceMaxPlan);		
		}
		
		//ajouter les callback
	
	}
}