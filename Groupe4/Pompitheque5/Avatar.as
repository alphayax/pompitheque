 package
{
	import flash.display.*;
	import flash.net.*;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.System;
	import flash.system.ApplicationDomain;
	
	public class Avatar
	{
		static var tabPhoto:Array;
		
		static var isLoadXMLfini:Boolean = false;
		
		private var fileXML:XML;
		
		//constructeur qui est appeler dans la Vue (une seule et unique fois pas client donc)
		//Il lis le fichier XML decriavtn la liste des photos et cree un tableau (Array)
		//contenant les url des images ainsi que les zone texte
		
		//creation du tableau et chargement du fichier xml
		public function Avatar(infoImgXML:String)
		{
			tabPhoto = new Array();
			
			var chargXML:URLLoader = new URLLoader ();
			var adrXML:URLRequest = new URLRequest (infoImgXML);
			var formatXML = URLLoaderDataFormat.TEXT;
			chargXML.dataFormat = formatXML;
			chargXML.load(adrXML);
			chargXML.addEventListener(Event.COMPLETE, loadXMLcompleted);
		}
		//remplit le tableau avec les données du xml
		private function loadXMLcompleted(event:Event)
		{
			/**trace("je commence a lire le fichier xml");**/
			fileXML = new XML(event.currentTarget.data);
			//pour chaque noeud avatar on cree une colonne Type et une Stature
			for each(var Avatar:XML in fileXML..avatar) 
			{
				tabPhoto[Avatar.@typeAvatar] = new Array();
				tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar] = new Array();
				//pour chaque noeud orientation de bal, on cree une colonne degres
				for each(var Orientation:XML in Avatar..orientation)
				{
					/**trace(Orientation.@degres+":URL:"+Orientation.url);**/
					
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres] = new Array();
					//on ajoute le loader correspondant a l'url
					//var loadIMG:Loader = new Loader();
					//loadIMG.load(new URLRequest(Orientation.url));					
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres]["loader"] = Orientation.url;
					//on cree le tableau pour la zone texte
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres]["zonetexte"] = new Array();
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres]["zonetexte"]["x1"] = Orientation.zonetexte.x1;
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres]["zonetexte"]["x2"] = Orientation.zonetexte.x2;					
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres]["zonetexte"]["y1"] = Orientation.zonetexte.y1;
					tabPhoto[Avatar.@typeAvatar][Avatar.@statureAvatar][Orientation.@degres]["zonetexte"]["y2"] = Orientation.zonetexte.y2;																				
				}
			}
			isLoadXMLfini = true;
			/**trace("jai fini de charger le fichier xml");**/								
		}
		
		

		
		//fonction qui renvoie l'image (loader) de la photo correspondante 
		//aux paramatres dans le tableau
		public static function  getImage(type:String,stature:String,orientation:String):String	
		{
			//trace("je lis le tableau xml"); 
			//return null;
			return tabPhoto[type][stature][orientation]["loader"];
			
		}
		
		//fonction qui renvoie un tableau de 4 ligne contenant les quatre points
		//de la zone texte correspondant aux parametres dans le tableau
		public static function getZoneTexte(type:String,stature:String,orientation:String):Array
		{
			var ZoneTexte:Array = new Array();
			ZoneTexte[0] = tabPhoto[type][stature][orientation]["zonetexte"]["x1"];
			ZoneTexte[1] = tabPhoto[type][stature][orientation]["zonetexte"]["y1"];
			ZoneTexte[2] = tabPhoto[type][stature][orientation]["zonetexte"]["y2"];
			ZoneTexte[3] = tabPhoto[type][stature][orientation]["zonetexte"]["x2"];
			return ZoneTexte;
		}
		
		
	}
}