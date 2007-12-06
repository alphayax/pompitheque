package pompitheque
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
	
	//on a juste besoin de la taille de la piece (largeur, longueur, coordonnée)
	//et de la liste des personnes
	public class Vue3D extends Sprite
	{
		//propriaitaire de la vue 3D
		private var pers:Personne;
		//Liste des acteurs : contiendra des Personnes et des objet du mobilier
		private var ListeActeur:Array;
		//Distance max dans le plan (utile pour calculer le redimensionnement)
		private var DistanceMaxPlan:Number;
		// Serveur
        private var serveur:Client;

		//Position du point de vue 
		public static var xCenter:Number = 400;
		public static var yCenter:Number = 575;
		

		//on cree une vue 3D a partir d'un personnage
		public function Vue3D(pers:Personne,ListeActeur:Array,DistanceMaxPlan:Number)
		{
			super();
			
			/*****DEBUT TEST GROUPE2****/
			//pour les test on ajoute l'angle de vue de 140°
			// centre de la rotation			
			var angleVue:Number = 140;
			var largeurVue:Number = 250;
			graphics.lineStyle(1);
			graphics.moveTo(xCenter,yCenter);
			graphics.lineTo(xCenter+largeurVue,yCenter-Math.atan(30*Math.PI/180)*largeurVue);
			graphics.moveTo(xCenter,yCenter);
			graphics.lineTo(xCenter-largeurVue,yCenter-Math.atan(30*Math.PI/180)*largeurVue);
			/*****FIN TEST GROUPE2****/			
			
			//propriaitaire de la vue 3D
			this.pers=pers;
			//on recupere la distance max dans le plan
			this.DistanceMaxPlan=DistanceMaxPlan;
			//on recupere la liste des acteurs (personnes et mobilier) de la vue
			this.ListeActeur=ListeActeur;
			//pour chaque acteur on calcule les coordonnées 3D et l'angle vue
			for(var i:* in ListeActeur)
			{
				ListeActeur[i].CalculDistance(pers);
				ListeActeur[i].CalculRedimensionnement3D(DistanceMaxPlan);
				ListeActeur[i].CalculAnglePOX(pers);
				ListeActeur[i].CalculAngleVue(pers);
				ListeActeur[i].CalculCoordonnee3D(pers);
				/**trace("Distance :"+(Acteur)(ListeActeur[i]).getDistanceProprio());**/
			}	
			//On tri le tableau d'acteur par rapport a la distance entre le proprio et l'acteur
			//ListeActeur.sort(sortOnDist);
			
			
			/**trace("Sort on ");**/
			for(var i:* in ListeActeur)
			{
				/**trace("Distance :"+(Acteur)(ListeActeur[i]).getDistanceProprio());**/
				addChild(ListeActeur[i]);
			}	
			reOrderTab();
			//on affiche tout les acteurs			
			AfficheVue3D();
			
			//listener pour l'ecoute clavier
			this.addEventListener("enterFrame",enterFrame_handler);
			
		}	
		
		
		
		//on ne voit que les personnage dans notre champs de visions
		//pour chaque personnage affiché on recupere l'image correspondante a l'angle vue
		//et on la fait afficher a ces coordonnées 3D		
		public function AfficheVue3D():void
		{												
			/**DEBUT INTEGRATION GROUPE1
			afficher le fond (panorama, fausse3D)
			il faut calculer ici la taille du mur que l'on voit par rapport a la piece
			et executer la fonction prevu par le groupe 1 qui va nous renvoyer l'image de fond
			FIN INTEGRATION GROUPE1**/
			
			/**afficher un sol en damier (eventuelement)**/
			
			//afficher tout les acteurs					
			for(var i:* in ListeActeur)
			{
				if(!(Acteur)(ListeActeur[i]).isEnVue(pers)){
					(Acteur)(ListeActeur[i]).visible = false;
				}else{
					(Acteur)(ListeActeur[i]).visible = true;
				}
				(Personne)(ListeActeur[i]).affiche3D();
			} 
		}
		
		//afin d'eviter le rechargement de toute la vue 3D a chaque modification sur une personne
		//on actualise la personne qui a changer (angle, position)
		//le sprite est ajouter avec un effet de dispation (incrementation de l'alpha)
		private function AffichePers3D(newPers:Personne):void
		{
			if (newPers.isEnVue(pers))
			{
				newPers.affiche3D();	
			}						
		}
		
		//lorsqu'un perso change de position ou se deconnecte ou supprime son image de la vue 3D
		//le sprite est supprimer avec un effet de dispation (incrementation de l'alpha)
		private function SuppPers3D(newPers:Personne):void
		{
			ListeActeur.splice(ListeActeur.indexOf(newPers,0),1);
			this.removeChild(newPers);
			//on ne supprime l'image de la personne que si elle est afficher et donc en vue
			if (newPers.isEnVue(pers))
			{
				//on supprime le pers dans la vue3D (suppression du child)
			}						
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel droite
		public function TourneDroite():void
		{
			/**trace("Tourne à droite.");**/
			
			pers.setAngleAbsolu(pers.getAngleAbsolu()-2);
			for(var i:* in ListeActeur)
			{
				var angleTemp:Number = (Acteur)(ListeActeur[i]).getAnglePOX()+2;
				if(angleTemp > 0){
					angleTemp = angleTemp%360;
				}else if(angleTemp < 0){
					angleTemp = angleTemp%(-360);
				}
				if(!(Acteur)(ListeActeur[i]).isEnVue(pers)){
					(Acteur)(ListeActeur[i]).visible = false;
				}else{
					(Acteur)(ListeActeur[i]).visible = true;
				}
				(Acteur)(ListeActeur[i]).setAnglePOX((angleTemp));
				//(Acteur)(ListeActeur[i]).setAngleVue(((Acteur)(ListeActeur[i]).getAngleVue()-2));
				(Acteur)(ListeActeur[i]).CalculCoordonnee3D(pers);
			}
			AfficheVue3D();		
			//avertir le serveur que l'orientation de pers a changer
			var newPos:XML = new XML("<orientation  pseudo='"+pers.getName()+"'><angle>"+pers.getAngleAbsolu()+"</angle></orientation>");
			//parent.client.send(newPos); 
		}
		
		//fonction appelé lorsque l'utilisateur appuis sur la fleche directionnel gauche
		public function TourneGauche():void
		{
			/**trace("Tourne à gauche.");**/
			
				//(Acteur)(ListeActeur[i]).setAngleVue((angleTemp));
			pers.setAngleAbsolu(pers.getAngleAbsolu()-2);
			for(var i:* in ListeActeur)
			{
				var angleTemp:Number = (Acteur)(ListeActeur[i]).getAnglePOX()-2;
				if(angleTemp > 0){
					angleTemp = angleTemp%360;
				}else if(angleTemp < 0){
					angleTemp = angleTemp%(-360);
				}
				if(!(Acteur)(ListeActeur[i]).isEnVue(pers)){
					(Acteur)(ListeActeur[i]).visible = false;
				}else{
					(Acteur)(ListeActeur[i]).visible = true;
				}
				(Acteur)(ListeActeur[i]).setAnglePOX((angleTemp));
				//(Acteur)(ListeActeur[i]).setAngleVue(((Acteur)(ListeActeur[i]).getAngleVue()-2));
				(Acteur)(ListeActeur[i]).CalculCoordonnee3D(pers);
			}
			AfficheVue3D();
			//avertir le serveur que l'orientation de pers a changer
			var newPos:XML = new XML("<orientation  pseudo='"+pers.getName()+"'><angle>"+pers.getAngleAbsolu()+"</angle></orientation>");
			//parent.client.send(newPos); 
		}
		
		
		//qd un nouveau personnage est ajoute on calcule ces coordonnées 3D par rapport a la vue du personnage
		//et rafficher la vue actualisé
		public function CallBackAjoutPersonnage(newPers:Personne):void
		{
			ListeActeur.push(newPers);			
			newPers.CalculCoordonnee3D(pers);	
			newPers.CalculDistance(pers);
			newPers.CalculRedimensionnement3D(DistanceMaxPlan);
			newPers.CalculAngleVue(newPers);
			reOrderTab();			
			//on retri le tableau
			AffichePers3D(newPers);
		}
		
		public function CallBackSuppPersonnage(newPers:Personne):void
		{
			//on supprime le pers dans le tableau
			SuppPers3D(newPers);
			reOrderTab();
		}
		
		//qd un personnage change de position on doit recalculer ses coordonnées 3D 
		//et rafficher la vue actualisé
		public function CallBackPosition(newPers:Personne):void
		{
			SuppPers3D(newPers);
			newPers.CalculCoordonnee3D(pers);
			newPers.CalculDistance(pers);	
			newPers.CalculRedimensionnement3D(DistanceMaxPlan);
			//on retri le tableau
			reOrderTab();
			AffichePers3D(newPers);
		}				
		
		//qd un personnage change d'orientation il faut recalculer  l'angle vue
		//et rafficher la vue actualisé
		public function CallBackOrientation(newPers:Personne):void
		{
			newPers.CalculAngleVue(pers);
			AffichePers3D(newPers);
		}
		
		private function sortOnDist(a:Acteur, b:Acteur):Number{
   			 
   			var aDist:Number = a.getDistanceProprio();
    		var bDist:Number = b.getDistanceProprio();

    		if(aDist > bDist){
    		    return -1;
   			}else if(aDist < bDist){
    		    return 1;
    		}else{
       		 return 0;
    		}
		}
		
		private function reOrderTab():void{
			ListeActeur.sort(sortOnDist);
			for(var i:int = 0; i < ListeActeur.length; i++){
				this.setChildIndex(ListeActeur[i],i);
			}
		}
		
				
		public function enterFrame_handler(e:Event):void{
			
			stage.focus = this;
			addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);	
			addEventListener(MouseEvent.CLICK,reportClicDown);		
		}
		
		public function reportKeyDown(event:KeyboardEvent):void {
			// Fleche gauche 
			if ( event.keyCode == 37 ) {
				TourneGauche();
			}			
			// Fleche droite
			if ( event.keyCode == 39 ){
				TourneDroite();
			}
			if (event.keyCode == Keyboard.ESCAPE) {
				//parent.switch();
			}
		}	
		
		public function reportClicDown(event:MouseEvent):void {
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
			
			var iterator:int = this.numChildren;
			var imgTemp:BitmapData;
			//parcours de tout les fils
			for(var i:int = 0; i < iterator ; i++)
			{
				try{
					s = (Sprite)(getChildAt(i));										
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
				    	/**trace("OK");**/
				    	imgTemp = new BitmapData(s.getChildAt(0).width, s.getChildAt(0).height, true, 0xFFFFFF)
				    	imgTemp.draw(s.getChildAt(0), null, null, null, null, false);
				    	/**trace("Bitmap  Height:"+imgTemp.height+" Width:"+imgTemp.width);**/
				    	xInterne = Math.abs(event.stageX - (s.x - s.width/2));
						yInterne = Math.abs(event.stageY - s.y);
						/**trace("Position interne 1: X :"+xInterne+" Y :"+yInterne);**/
						xInterne = xInterne*375/s.height;
						yInterne = 375 - yInterne*235/s.width;
						
				    	/**trace("Position interne 2: X :"+xInterne+" Y :"+yInterne);**/
				    	var pixelValue:uint = imgTemp.getPixel32(xInterne, yInterne);
						var alphaValue:uint = pixelValue >> 24 & 0xFF;
						/**trace(alphaValue.toString(16));**/
						if(alphaValue.toString(16) == "ff"){
							trace("ON A TROUVE");
							
							/**INTEGRATION GROUPE5**/
							pers.saisieMessage((Personne)(s).getName());
							/**INTEGRATION GROUPE5**/
							break;
						}
				    }
				}
			}			
		}
	}
}
