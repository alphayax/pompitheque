package
{	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	
	public class Vue extends Sprite
	{		
	
		//vue 3D
		private var vue3D:Vue3D;
		//vue 2D
		//private var vue2D:Vue2D;		
		private var vueCourrante;
		
		//data xml contenant toute les info du plan
		private var Plan:XML		
		
		//distance maximale entre deux personnes
		private var DistanceMaxPlan:Number;
		
		//tableau des acteurs present dans le monde
		private var ListeActeur:Array = new Array(); 
		
		//personne client
		private var Proprio:Personne;
		
		private var IntervalXMLavatar:Number;
		
		public var client:Client;
		
		public function Vue(proprio:Personne)
		{
			Proprio = proprio;
			
			//on cree la connection avec le serveur
			client = new Client("serv","nom");
			//ecouteur serveur, qui appel la fonction triMessage qd on recois un message
		//client.getSocket().addEventListener(DataEvent.DATA,triMessage);  
			/*********pas besoin, c'est a faire dans la vue 2D*********/
   			//envoie de new pers (proprio) au serveur pour prevenir qu'une nouvelle personne se connecte
  			var newpers:XML = new XML("<user nom='"+proprio.getName()+"' ><x>"+proprio.getX2D()+"</x><y>"+proprio.getY2D()+"</y><orientation>"+proprio.getAngleAbsolu()+"</orientation><stature>"+proprio.getStature()+"</stature><type>"+proprio.getType()+"</type></user>");
		//client.send(newpers); 
			/***********************************************************/
			//envoie demande au serveur (listepersonnage et plan.xml)
			var demande:XML = <demande nom="nomduserveur" />;
		//client.send(demande);		
			
			//on pré-charge les images a partir du fichier XML
			new Avatar("ImagePersonnage.xml"); 
			IntervalXMLavatar = setInterval(isLoadedXMLavatar, 10);		
		}
		
		//on attends que le xml d'avatar soit chargé
		private function isLoadedXMLavatar(){
		    if (Avatar.isLoadXMLfini == true){
		        clearInterval(IntervalXMLavatar); 
		        afterLoadedXMLavatar(); 
		    }
		}
		
		//le chargement des avatar est terminé on continu la creation des vues
		private function afterLoadedXMLavatar(){		
			//on attend d'avoir recu et parser le plan et la liste des personnes
			
			
			//on cree la vue 2D
			//vue2D = new Vue2D(....);
			//vueCourrante = vue2D;
			//addChild(vueCourrante);
			
			/*****DEBUT TEST GROUPE2****/
			//pour les tests on ajoute manuelement les valeurs
			DistanceMaxPlan = 600;
			Proprio=new Personne("Bibi",350,0,0,"debout","pocahontas");
			ajoutPersonne("Sylvie",100,0,0,"debout","pocahontas");
			ajoutPersonne("Paulette",200,10,0,"debout","pocahontas");
			ajoutPersonne("Sandrine",300,0,180,"debout","pocahontas");
			ajoutPersonne("Marcelle",400,0,50,"debout","pocahontas");	
			ajoutPersonne("Marcelle",500,0,50,"debout","pocahontas");	
			ajoutPersonne("Marcelle",100,150,50,"debout","pocahontas");	
			ajoutPersonne("Marcelle",200,100,50,"debout","pocahontas");	
			vue3D = new Vue3D(Proprio,ListeActeur,DistanceMaxPlan);					
			afficheVue3D();
			/*****FIN TEST GROUPE2****/
		}
						
				
		//ajout d'une personne a la liste des acteurs	
		public function ajoutPersonne(name:String,x:Number,y:Number,angle:Number,stature:String,typeavatar:String):void
		{
			ListeActeur.push(new Personne(name,x,y,angle,stature,typeavatar));
		}
		//ajout d'une table a la liste des acteurs
		public function ajoutTable(name:String,x:Number,y:Number,angle:Number):void
		{
			ListeActeur.push();
		}	
		//ajout d'une chaise a la liste des acteurs
		public function ajoutChaise(name:String,x:Number,y:Number,angle:Number):void
		{
			ListeActeur.push();			
		}
		
				
		//echange les vues si elle sont créer
		private function switchVue():void
		{
			if(vueCourrante == vue3D)
			{
				this.afficheVue2D();				
			}
			else {
				if (vue3D == null)
				{
					vue3D = new Vue3D(Proprio,ListeActeur,DistanceMaxPlan);
				}
				this.afficheVue3D();
			}
		}									
		public function afficheVue3D():void
		{						
			vueCourrante = vue3D;
			//passer le vue courante en arriere plan
			addChild(vueCourrante);		
		}				
		public function afficheVue2D():void
		{	
  			//vueCourrante = vue2D;		
			//passer le vue courante en arriere plan
			addChild(vueCourrante);	 
		}		
		
	    //appel la fonction correspondant au message recu	
		private function triMessage(Data:XML):void
		{
			switch(Data.localName()) 
			{
				case "users": getListPersXml(Data); break;
				case "map": getListPersXml(Data); break;
				case "newpers": getNouvellePersonne(Data); break;
				case "deco": getDecoPersonne(Data); break;
				case "position": getPositionPersonne(Data); break;
				case "orientation": getAnglePersonne(Data); break;
			}
		}
		
		//fonction qui recupere le plan au format xml
		//le plan est envoyer a la vue 2D qui cree la grille
		//chaque objet du plan sera ajoute a ListeActeur
		//cette fonction sera appele quand on recevra le plan du par le serveur
		public function getPlanXml(Data:XML):void
		{
			Plan = Data;
			//on parcours toutes les tables et on les ajoutes a la liste d'acteur
			var x:Number = 0;
			for each(var Table:XML in Data.mobilier..table) 
			{				
				ajoutTable("Table"+x,Table.x,Table.y,Table.orientation);		
				x++;
			}
			//on parcours toutes les chaises et on les ajoutes a la liste d'acteur
			x = 0;
			for each(var Chaise:XML in Data.mobilier..chaise) 
			{				
				ajoutChaise("Chaise"+x,Table.x,Table.y,Table.orientation);		
				x++;
			}
		}
		
		//fonction qui recupere la liste des personnes au format xml
		//chaque personne est ajoute a ListeActeur
		//cette fonction sera appele quand on recevrai la liste des personne par le serveur
		public function getListPersXml(Data:XML):void
		{
			for each(var Pers:XML in Data..user) 
			{
				ajoutPersonne(Pers.@pseudo,Pers.x,Pers.y,Pers.orientation,Pers.stature,Pers.type);
			}
		}
		
		/***DEBUT INTEGRATION GROUPE3**/
		//fonction qui recupere la nouvelle personne connecter au serveur au format xml
		//on met a jour la Vue3D et la Vue2D avec le nouveau personnage (callbackAjoutPersonnage)		
		public function getNouvellePersonne(Data:XML):void
		{  
			//creation de newpers a partir du flux xml
			//vue2D.CallBackAjoutPersonnage(newpers);
			//vue3D.CallBackAjoutPersonnage(newpers);	
		}
		
		//function qui recupere la personne qui s'est deconnecté afin de prevenir les vues
		public function getDecoPersonne(Data:XML):void
		{
			//creation de endpers a partir du flux xml			
			//vue2D.CallBackSuppPersonnage(endpers);
			//vue3D.CallBackSuppPersonnage(endpers);
		}

		//fonction qui recupere la personne qui s'est deplacer et met a jour sa position sur les vues
		public function getPositionPersonne(Data:XML):void
		{
			//vue2D.CallBackPosition(pospers);
			//vue3D.CallBackPosition((pospers);
		}		
		
		//fonction qui recupere la personne qui a tourné et met a jour son angles sur les vues
		public function getAnglePersonne(Data:XML):void
		{
			//vue2D.CallBackOrientation(anglpers);
			//vue3D.CallBackOrientation(anglpers);
		}
		/***FIN INTEGRATION GROUPE3**/

		/***DEBUT INTEGRATION GROUPE6**/		
		//fonction appele lorsque le client se deco
		//on previens le serveur
		public function callDeconnecte():void
		{
			//client.deco ou un truc comme ca
		}
		/***FIN INTEGRATION GROUPE6**/		
	
	}
}