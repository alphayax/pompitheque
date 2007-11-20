package
{	
	import flash.display.*;
	import flash.utils.*;
	
	public class Vue extends Sprite
	{		
	
		//vue 3D
		private var vue3D:Vue3D;
		//vue 2D
		//private var vue2D:Vue2D;
		
		//distance maximale entre deux personnes
		private var DistanceMaxPlan:Number;
		
		//tableau des acteurs present dans le monde
		private var ListeActeur:Array = new Array(); 
		
		//personne client
		private var Proprio:Personne;
		
		private var IntervalXMLavatar:Number;
		
		
		public function Vue(planXML:String)
		{
			//on pré-charge les images a partir du fichier XML
			new Avatar("ImagePersonnage.xml"); 
			IntervalXMLavatar = setInterval(isLoadedXMLavatar, 10);
						
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
		
		//on attends que le xml d'avatar soir chargé
		private function isLoadedXMLavatar(){
		    if (Avatar.isLoadXMLfini == true){
		        clearInterval(IntervalXMLavatar); 
		        afterLoadedXMLavatar(); 
		    }
		}
		
		//le chargement est fini on continue peut y mettre les fonction qui vont utilisé Avatar
		private function afterLoadedXMLavatar(){
		    this.addChild(Avatar.getImage("pocahontas","debout","0"));
			trace(Avatar.getZoneTexte("pocahontas","debout","0")[0]);
		}
				
		//ajout d'une personne sur la grille		
		public function ajoutPersonne(name:String,x:Number,y:Number,angle:Number,stature:String,typeavatar:String):void
		{
			ListeActeur.push(new Personne(name,x,y,angle,stature,typeavatar));
			//avertir le serveur
		}
								
		public function afficheVue3D():void
		{			
			vue3D = new Vue3D(Proprio,ListeActeur,DistanceMaxPlan);
			addChild(vue3D);		
		}
				
		public function afficheVue2D():void
		{
			
		}
		
		
		//fonction qui recupere le plan au format xml
		//le plan est envoyer a la vue 2D qui cree la grille
		//chaque objet du plan sera ajoute a ListeActeur
		//cette fonction sera appele quand on recevra le plan du par le serveur
		public function getPlanXml(messageServ:*):void
		{

		}
		
		//fonction qui recupere la liste des personnes au format xml
		//chaque personne est ajoute a ListeActeur
		//cette fonction sera appele quand on recevrai la liste des personne par le serveur
		public function getListPersXml(messageServ:*):void
		{
			
		}
		
		//fonction qui recupere la nouvelle personne connecter au serveur au format xml
		//on met a jour la Vue3D et la Vue2D avec le nouveau personnage (callbackAjoutPersonnage)		
		public function getConnecPersonne(messageServ:*):void
		{
			
		}
		
		//function qui recupere la personne qui s'est deconnecté afin de prevenir les vues
		public function getDecoPersonne(messageServ:*):void
		{
	
		}

		//fonction qui recupere la personne qui s'est deplacer et met a jour sa position sur les vues
		public function getPositionPersonne(messageServ:*):void
		{
			
		}		
		
		//fonction qui recupere la personne qui a tourné et met a jour son angles sur les vues
		public function getAnglePersonne(messageServ:*):void
		{
			
		}
		
		//fonction appele lorsque le client se deco
		//on previens le serveur
		public function callDeconnecte():void
		{
			
		}
	
	}
}