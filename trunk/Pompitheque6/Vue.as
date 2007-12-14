package 
{	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
	import chat.Client;
	import flash.filters.BevelFilter;
	public class Vue extends Sprite
	{		
	
		//vue 3D
		private var vue3D:Vue3D;
		//vue 2D
		private var vue2D:Vue2D;		
		private var vueCourrante:Sprite;
		
		//data xml contenant toute les info du plan
		private var Plan:XML;		
		
		//distance maximale entre deux personnes
		private var DistanceMaxPlan:Number;
		
		//tableau des acteurs present dans le monde
		private var ListeActeur:Array = new Array(); 
		
		//personne client
		private var Proprio:Personne;
		
		private var IntervalXMLavatar:Number;
		private var IntervalVue3D:Number;
		
		public var client:Client;
		
		private var planXmlLoadFini:Boolean = false;
		
		private var listPersLoadFini:Boolean = false;
		
		public function Vue(proprio:Personne)
		{
			Proprio = proprio;
			
			//on cree la connection avec le serveur
			client = new Client("serv","nom");
			//ecouteur serveur, qui appel la fonction triMessage qd on recois un message
			client.getSocket().addEventListener(DataEvent.DATA,triMessage);
			//RAJOUTER DATA.CLOSE
			client.getSocket().addEventListener(Event.CLOSE,callDeconnecte);
			  
			//envoie demande au serveur (listepersonnage et plan.xml)
			var demande:XML = <demande nom="nomduserveur" />;
			client.send(demande);		
			
			//on pré-charge les images a partir du fichier XML
			new Avatar("ImagePersonnage.xml"); 
			IntervalXMLavatar = setInterval(isLoadedXMLavatar, 500);		
			this.addEventListener("enterFrame",enterFrame_handler);
		}
		
		public function enterFrame_handler(e:Event):void{
			
			stage.focus = this;
			addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);	
			addEventListener(MouseEvent.CLICK,reportClicDown);			
		}
		
		public function reportClicDown(event:MouseEvent):void {
			if(vueCourrante == vue3D){
			/**trace("---------------------------------");
			trace("  MouseX:"+event.stageX+" MouseY:"+event.stageY);**/
			var s:Sprite;
			//variable de test
			var xOk:Number;
			var yOk:Number;
			//position dans la personne
			var xInterne:Number;
			var yInterne:Number;
			//parametre de l'avatar
			var hauteur:Number=375;
			var largeur:Number=235;
			
			var iterator:int = vue3D.numChildren;
			var imgTemp:BitmapData;
			//parcours de tout les fils
			for(var i:int = 0; i < iterator ; i++)
			{
				try{
					s = (Sprite)(this.vue3D.getChildAt(i));										
				}catch(e:Error){
					trace(e.message);
				}
				/**trace("---------------------------------");
				trace("nom :"+(Personne)(s).nom+"  X:"+s.x+" Y:"+s.y);
				trace("  Height:"+s.height+" Width:"+s.width);**/
				//si le clic a eu lieu avant le x et y de la personne
				if(s.y >= event.stageY){
					/**trace("test car en clic au dessous du clip");**/
					xOk = Math.abs(event.stageX - s.x);
				    yOk = s.y - event.stageY;
				    //si le clic est dans la zone en x et en y
				    if(xOk <= s.width/2 && yOk <= s.height){
				    	//trace("OK");
				    	imgTemp = new BitmapData(s.getChildAt(0).width, s.getChildAt(0).height, true, 0xFFFFFF);
				    	imgTemp.draw(s.getChildAt(0), null, null, null, null, false);
				    	//trace("Bitmap  Height:"+imgTemp.height+" Width:"+imgTemp.width);
				    	xInterne = Math.abs(event.stageX - (s.x - s.width/2));
						yInterne = Math.abs(event.stageY - s.y);
						//trace("Position interne 1: X :"+xInterne+" Y :"+yInterne);
						xInterne = xInterne*375/s.height;
						yInterne = 375 - yInterne*235/s.width;
						
						//xInterne = event.stageX - s.x;
						//yInterne = event.stageY - s.y;
						//var tep:Bitmap = new Bitmap(imgTemp);
						//vue3D.addChild(tep);
						
				    	//trace("Position interne 2: X :"+xInterne+" Y :"+yInterne);
				    	var pixelValue:uint = imgTemp.getPixel32(xInterne, yInterne);
						var alphaValue:uint = pixelValue >> 24 & 0xFF;
						trace(alphaValue.toString(16));
						if(alphaValue.toString(16) == "ff"){
							//trace("ON A TROUVE");
							
							/**INTEGRATION GROUPE5**/
							Proprio.saisieMessage((Personne)(s).getName(), vue3D);
							/**INTEGRATION GROUPE5**/
							break;
						}
				    }
				}
			}
			}			
		}
		
		public function reportKeyDown(event:KeyboardEvent):void {
			// Fleche gauche 
			if(vueCourrante == vue3D){
				if ( event.keyCode == 37 ) {
					vue3D.TourneGauche();
				}			
				// Fleche droite
				if ( event.keyCode == 39 ){ 
					vue3D.TourneDroite();
				}
			}else{ //si c vue2d qui est actif
								if(vue2D.obj_sel != null){
					//vue2D.obj_sel.focusRect = 5;
					if ( event.keyCode == 37 ) {
						vue2D.rotate(vue2D.obj_sel,-20);
					}			
					// Fleche droite
					else if ( event.keyCode == 39 ){ 
						vue2D.rotate(vue2D.obj_sel,20);
					}
					else if(event.keyCode == 46){
						vue2D.suppImmeubilier(vue2D.obj_sel);
						//vue2D.up.removeChild();
					}
				}else{
					if ( event.keyCode == 37 ) {
						vue2D.rotate(vue2D.moi,-20);
					}else if ( event.keyCode == 39 ){ 
						vue2D.rotate(vue2D.moi,20);
						// Fleche haute (Groupe 2D)
					}else if ( event.keyCode == 38 ){
						var n:Number = 20;
						if(event.ctrlKey && event.shiftKey) { n = 2; }
						else if(event.ctrlKey == true){ n = 5; }
						else if(event.shiftKey == true) { n = 10; }
						
						vue2D.deplacer(vue2D.moi,vue2D.moi.x + n*Math.sin(vue2D.moi.angleVue*3.14/180),vue2D.moi.y - n*Math.cos(vue2D.moi.angleVue*3.14/180));
						//bas
					}/*else if ( event.keyCode == 40 ){ 
						vue2D.deplacer(vue2D.moi,vue2D.moi.x - 20*Math.sin(vue2D.moi.angleAbsolu*3.14/180),vue2D.moi.y + 20*Math.cos(vue2D.moi.angleAbsolu*3.14/180));
					}*/
				}
				
				if(event.keyCode == Keyboard.ENTER){
					var xml:XML =
		                <plan>
						  <salle>
						    <mur x1="2.00" y1="2.00" x2="18.00" y2="2.00" />
						    <mur x1="18.00" y1="2.00" x2="18.00" y2="17.00" />
						    <mur x1="18.00" y1="17.00" x2="2.00" y2="17.00" />
						    <mur x1="2.00" y1="17.00" x2="2.00" y2="2.00" />
						    <angle x="18" y="2" posPanorama="17" />
						    <angle x="18" y="17" posPanorama="726" />
						    <angle x="2" y="17" posPanorama="1436" />
						    <angle x="2" y="2" posPanorama="2145" />
						  </salle>
						  <mobilier>
						    <table x="4.50" y="5.00" orientation="0" />
						    <table x="10.77" y="4.97" orientation="0" />
						    <chaise x="4.70" y="3.93" orientation="0" />
						    <chaise x="2.77" y="5.20" orientation="0" />
						    <chaise x="4.90" y="6.63" orientation="0" />
						    <chaise x="11.20" y="3.87" orientation="0" />
						    <chaise x="13.20" y="5.30" orientation="0" />
						    <chaise x="11.43" y="6.87" orientation="0" />
						  </mobilier>
						</plan>     ;
					this.triMessage(xml);
					xml = <users>
							 <user pseudo="Sylvie">
							   <x>350</x>
							   <y>100</y>
							   <orientation>90</orientation>
							   <stature>debout</stature>
							   <type>pocahontas</type>
							 </user>
							 <user pseudo="Paulette">
							   <x>350</x>
							   <y>200</y>
							   <orientation>180</orientation>
							   <stature>debout</stature>
							   <type>pocahontas</type>
							 </user>
							</users>
					this.triMessage(xml);
					//ajoutTable("Table1",101,0,0,Proprio);   	                	 
				}			
			}
			
			if(event.keyCode == Keyboard.ESCAPE){
				switchVue();
			}
		}
		
		
		
		//on attends que le xml d'avatar soit chargé
		private function isLoadedXMLavatar(){
		    if (Avatar.isLoadXMLfini == true){
		        clearInterval(IntervalXMLavatar); 
		        afterLoadedXMLavatar(); 
		    }
		    else IntervalXMLavatar = setInterval(isLoadedXMLavatar, 500);
		}
		
		//le chargement des avatar est terminé on continu la creation des vues
		private function afterLoadedXMLavatar(){					
			//on cree la vue 2D
			vue2D = new Vue2D(400,400,20,ListeActeur,Proprio)
			vueCourrante = vue2D;
			addChild(vueCourrante);
			
			stage.focus = vueCourrante;
		}
						
				
		//ajout d'une personne a la liste des acteurs	
		public function ajoutPersonne(name:String,x:Number,y:Number,angle:Number,stature:String,typeavatar:String):void
		{
			ListeActeur.push(new Personne(name,x,y,angle,stature,typeavatar));
		}
		//ajout d'une table a la liste des acteurs
		public function ajoutTable(name:String,x:Number,y:Number,angle:Number,Proprio:Personne):void
		{
			ListeActeur.push(new Table(name, x, y, angle,Proprio));
		}	
		//ajout d'une chaise a la liste des acteurs
		public function ajoutChaise(name:String,x:Number,y:Number,angle:Number):void
		{
			//ListeActeur.push(new Chaise2D(name,x,y,angle));	
			ListeActeur.push(new Chaise2D(x,y));			
		}
		
				
		//echange les vues si elle sont créer
		public function switchVue():void
		{
			
			this.removeChild(vueCourrante);
			if(vueCourrante == vue3D)
			{
				this.afficheVue2D();				
			}
			else {
				if (vue3D == null)
				{
					IntervalVue3D = setInterval(isLoadedVue3D, 500);					
				}
				else this.afficheVue3D();
			}
			stage.focus = vueCourrante;
		}		
		
		private function isLoadedVue3D(){
		    if ((planXmlLoadFini == true) && (listPersLoadFini == true)){
		        clearInterval(IntervalXMLavatar); 
		        vue3D = new Vue3D(Proprio,ListeActeur,Plan); 
		        this.afficheVue3D();
		    }
		    else {
		    	trace("j'att que le serveur m'envoie le plan et la list de personne");
		    	IntervalVue3D = setInterval(isLoadedVue3D, 10000);
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
			vueCourrante = vue2D;
			//passer le vue courante en arriere plan
			addChild(vueCourrante);	 
		}		
		
	    //appel la fonction correspondant au message recu	
		private function triMessage(Data:XML):void
		{
			trace("je recoi un message de type : "+Data.localName())
			switch(Data.localName()) 
			{
				case "users": getListPersXml(Data); break;
				case "plan": getPlanXml(Data); break;
				case "newpers": getNouvellePersonne(Data); break;
				case "deco": getDecoPersonne(Data); break;
				case "position": getPositionPersonne(Data); break;
				case "orientation": getAnglePersonne(Data); break;
				case "message": Proprio.receiveMessage(Data); break;
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
				ajoutTable("Table"+x,Table.x,Table.y,Table.orientation,Proprio);		
				x++;
			}
			//on parcours toutes les chaises et on les ajoutes a la liste d'acteur
			x = 0;
			for each(var Chaise:XML in Data.mobilier..chaise) 
			{				
				ajoutChaise("Chaise"+x,Table.x,Table.y,Table.orientation);		
				x++;
			}
			trace("jai fini de charger le plan");
			planXmlLoadFini = true;
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
			trace("jai fini de charger la liste des perso");			
			listPersLoadFini = true;
		}
		
		//fonction qui recupere la nouvelle personne connecter au serveur au format xml
		//on met a jour la Vue3D et la Vue2D avec le nouveau personnage (callbackAjoutPersonnage)		
		public function getNouvellePersonne(Data:XML):void
		{  
			var pers:Personne = new Personne(Data.@pseudo ,Data.x,Data.y,Data.orientation,Data.stature,Data.type);
			ListeActeur.push(pers);
			vue2D.CallBackAjoutPersonnage(pers);
			vue3D.CallBackAjoutPersonnage(pers);	
		}
		
		//function qui recupere la personne qui s'est deconnecté afin de prevenir les vues
		public function getDecoPersonne(Data:XML):void
		{
			for(var i:Number = 0; i < ListeActeur.length; i++){
		       if(ListeActeur[i].nom == Data.@pseudo){
	               delete ListeActeur[i];
	
	               var act:Number = i;
	               break;
		       }
            }		
		    vue2D.CallBackSuppPersonnage(ListeActeur[act]);
			vue3D.CallBackSuppPersonnage(ListeActeur[act]);
		}

		//fonction qui recupere la personne qui s'est deplacer et met a jour sa position sur les vues
		public function getPositionPersonne(Data:XML):void
		{
			var act:Number
	        for(var i:Number = 0; i < ListeActeur.length; i++){
	           if(ListeActeur[i].nom == Data.@pseudo ){
	               ListeActeur[i].x2D =  Data.x;
	               ListeActeur[i].y2D =  Data.y;
	               act = i;
	               break;  
	           }
	        }
	        vue2D.CallBackPosition(ListeActeur[act]);
		    vue3D.CallBackPosition(ListeActeur[act]);
		}		
		
		//fonction qui recupere la personne qui a tourné et met a jour son angles sur les vues
		public function getAnglePersonne(Data:XML):void
		{
			
			var act:Number
	        for(var i:Number = 0; i < ListeActeur.length; i++){
	           if(ListeActeur[i].nom == Data.@pseudo ){
	               ListeActeur[i].angleAbsolu =  Data.orientation;
	               for(var j:Number = i; j < ListeActeur.length - 1; j++){
	   				ListeActeur[j] = ListeActeur[j+1];
	   			   }
	   			   ListeActeur.pop();
	               act = i;
	               break;  
	           }
	       }
	       vue2D.CallBackOrientation(ListeActeur[act]);
		   vue3D.CallBackOrientation(ListeActeur[act]);
		 }

		//fonction appele lorsque le client se deco
		//on previens le serveur
		public function callDeconnecte():void
		{
			client.send("<deco pseudo="+Proprio.getName()+" />");
			
		}
	
	}
}
