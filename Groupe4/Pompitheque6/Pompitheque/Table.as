package Pompitheque
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	
	public class Table extends Acteur {
		
		//Dimension de la table
		public var rayon:Number;
		public var nbPieds:Number; // 0 = 4 pieds, 1 = 1 pied central
		
		//Couleurs
		public var couleurPlateau:uint;
		public var couleurContour:uint;
		public var couleurPieds:uint;
		
		//Dessin en 2D
		//Coordonnees du coin avant gauche en 2D 
		public var coinAvG_x2D:Number;
		public var coinAvG_y2D:Number;	
		//Coordonnees du coin avant droit en 2D 
		public var coinAvD_x2D:Number;
		public var coinAvD_y2D:Number;		
		//Coordonnees du coin arriere gauche en 2D 
		public var coinArrG_x2D:Number;
		public var coinArrG_y2D:Number;		
		//Coordonnees du coin arriere droit en 2D 
		public var coinArrD_x2D:Number;
		public var coinArrD_y2D:Number;
		
		//Passage au 3D
		//Coordonnees du coin avant gauche en 3D
		public var coinAvG_x3D:Number;
		public var coinAvG_y3D:Number;
		public var coinAvG_z3D:Number;		
		//Coordonnees du coin avant droit en 3D
		public var coinAvD_x3D:Number;
		public var coinAvD_y3D:Number;
		public var coinAvD_z3D:Number;		
		//Coordonnees du coin arriere gauche en 3D
		public var coinArrG_x3D:Number;
		public var coinArrG_y3D:Number;
		public var coinArrG_z3D:Number;		
		//Coordonnees du coin arriere droit en 3D
		public var coinArrD_x3D:Number;
		public var coinArrD_y3D:Number;
		public var coinArrD_z3D:Number;

		
		/**********************************************/
		//Calque du plateau Plateau de la table en 2D
		public var shapeSurface2D:Shape;
		/*********************************************/
		
		//Calque du plateau Plateau de la table en 3D
		public var shapeSurface3D:Shape;	
		//Calque des pieds de table
		public var spritePieds:Sprite;
		
		private var proprio:Personne;

		//Constructeur
		public function Table(nom:String, x2D:Number, y2D:Number, angleAbsolu:Number,proprio:Personne) {
			super(nom, x2D, y2D, angleAbsolu);
			this.proprio=proprio;
			var dimension = 150; //on defini la largeur
			this.rayon = dimension/2;
			this.nbPieds = 0;
			this.couleurPlateau = 0xFFF000;
			this.couleurContour = 0x000000;
			this.couleurPieds = 0xF00FFF;
			
			//Instance des zones de dessin	
			shapeSurface3D  = new Shape();
			spritePieds = new Sprite();
			//Calcul des cooordonnées des points a partir de la position de X2D, Y2D
			initDessin2D();				
		}
		
		//Fonction qui calcul les coordonnees des coins de la table
		//en fonction du centre et de la longueur de la table
		//le rayon = longueur table/2 
		public function initDessin2D() : void {		
			//coin avant gauche en 2D			
			coinAvG_x2D = proprio.getX2D()-rayon;
			coinAvG_y2D = proprio.getY2D()+rayon*2;
			//coin avant droit en 2D 
			coinAvD_x2D = proprio.getX2D()+rayon;
			coinAvD_y2D = proprio.getY2D()+rayon*2;
			//coin arriere gauche en 2D 
			coinArrG_x2D = proprio.getX2D()-rayon;
			coinArrG_y2D = proprio.getY2D();
			//coin arriere droit en 2D 
			coinArrD_x2D = proprio.getX2D()+rayon;
			coinArrD_y2D = proprio.getY2D();		
			/**
			trace("---------2D---1-------");
			trace("centreA :"+proprio.getX2D()+" , "+proprio.getY2D());
 			trace("avG :"+coinAvG_x2D+" , "+coinAvG_y2D);
			trace("avD :"+coinAvD_x2D+" , "+coinAvD_y2D);
			trace("arrG :"+coinArrG_x2D+" , "+coinArrG_y2D);
			trace("arrD :"+coinArrD_x2D+" , "+coinArrD_y2D);	
			**/
		}
										
		
		//fonction qui sert a faire la transition entre Acteur et Table LOL
		//juste pour avoir la hierarchie de classe et l'ordre de calcul d'une table
		//a revoir!!!
		public override function CalculAngleVue(persProprio:Personne):void
		{
			super.CalculAngleVue(persProprio);						
			calculDessin2DAngleVue(super.getAngleVue());
		}	
		
		//Recalcul les coordonnées des point du dessin 2D a partir de l'angle vue
		public function calculDessin2DAngleVue(angle:Number) : void {
			//Translation pour avoir le centre de la table pour origine									
			var temp_coinAvG_x2D:Number = coinAvG_x2D - proprio.getX2D();
			var temp_coinAvG_y2D:Number = coinAvG_y2D - proprio.getY2D()-rayon;			
			var temp_coinAvD_x2D:Number = coinAvD_x2D - proprio.getX2D();
			var temp_coinAvD_y2D:Number = coinAvD_y2D - proprio.getY2D()-rayon;
			var temp_coinArrG_x2D:Number = coinArrG_x2D - proprio.getX2D();
			var temp_coinArrG_y2D:Number = coinArrG_y2D - proprio.getY2D()-rayon;
			var temp_coinArrD_x2D:Number = coinArrD_x2D - proprio.getX2D();
			var temp_coinArrD_y2D:Number = coinArrD_y2D - proprio.getY2D()-rayon;
			/**
			trace("---------2D---2-------");   		      		      	
	      	graphics.moveTo(temp_coinAvG_x2D,temp_coinAvG_y2D);	      	
	      	graphics.lineTo(temp_coinAvD_x2D,temp_coinAvD_y2D);	      		      	
	      	graphics.lineTo(temp_coinArrD_x2D,temp_coinArrD_y2D);	      		      	
	      	graphics.lineTo(temp_coinArrG_x2D,temp_coinArrG_y2D);  	    	
	      	graphics.lineTo(temp_coinAvG_x2D,temp_coinAvG_y2D);
			trace("centreA :"+proprio.getX2D()+" , "+proprio.getY2D());
 			trace("avG :"+temp_coinAvG_x2D+" , "+temp_coinAvG_y2D);
			trace("avD :"+temp_coinAvD_x2D+" , "+temp_coinAvD_y2D);
			trace("arrG :"+temp_coinArrG_x2D+" , "+temp_coinArrG_y2D);
			trace("arrD :"+temp_coinArrD_x2D+" , "+temp_coinArrD_y2D);
			**/
			//Rotation
			// On a besoin d'avoir l'angle en radians : angle_rad = angle_deg*PI/180
			// Formule pour la rotation :
			// x = x'*cos(angle) - y'*sin(angle)
			// y = x'*sin(angle) + y'*cos(angle)
			coinAvG_x2D = temp_coinAvG_x2D*Math.cos(angle*Math.PI/180) - temp_coinAvG_y2D*Math.sin(angle*Math.PI/180);
			coinAvG_y2D = temp_coinAvG_x2D*Math.sin(angle*Math.PI/180) + temp_coinAvG_y2D*Math.cos(angle*Math.PI/180);			
			coinAvD_x2D = temp_coinAvD_x2D*Math.cos(angle*Math.PI/180) - temp_coinAvD_y2D*Math.sin(angle*Math.PI/180);
			coinAvD_y2D = temp_coinAvD_x2D*Math.sin(angle*Math.PI/180) + temp_coinAvD_y2D*Math.cos(angle*Math.PI/180);			
			coinArrG_x2D = temp_coinArrG_x2D*Math.cos(angle*Math.PI/180) - temp_coinArrG_y2D*Math.sin(angle*Math.PI/180);
			coinArrG_y2D = temp_coinArrG_x2D*Math.sin(angle*Math.PI/180) + temp_coinArrG_y2D*Math.cos(angle*Math.PI/180);			
			coinArrD_x2D = temp_coinArrD_x2D*Math.cos(angle*Math.PI/180) - temp_coinArrD_y2D*Math.sin(angle*Math.PI/180);
			coinArrD_y2D = temp_coinArrD_x2D*Math.sin(angle*Math.PI/180) + temp_coinArrD_y2D*Math.cos(angle*Math.PI/180);
			/**
			trace("---------2D---3-------");
	      	graphics.moveTo(coinAvG_x2D,coinAvG_y2D);	      	
	      	graphics.lineTo(coinAvD_x2D,coinAvD_y2D);	      		      	
	      	graphics.lineTo(coinArrD_x2D,coinArrD_y2D);	      		      	
	      	graphics.lineTo(coinArrG_x2D,coinArrG_y2D);  	    	
	      	graphics.lineTo(coinAvG_x2D,coinAvG_y2D);
			trace("centreA :"+proprio.getX2D()+" , "+proprio.getY2D());
 			trace("avG :"+coinAvG_x2D+" , "+coinAvG_y2D);
			trace("avD :"+coinAvD_x2D+" , "+coinAvD_y2D);
			trace("arrG :"+coinArrG_x2D+" , "+coinArrG_y2D);
			trace("arrD :"+coinArrD_x2D+" , "+coinArrD_y2D);
			**/
						
			//Translation pour revenir avec une origine en 0,0
			coinAvG_x2D = coinAvG_x2D + proprio.getX2D();
			coinAvG_y2D = coinAvG_y2D + proprio.getY2D()+rayon;			
			coinAvD_x2D = coinAvD_x2D + proprio.getX2D();
			coinAvD_y2D = coinAvD_y2D + proprio.getY2D()+rayon;		
			coinArrG_x2D = coinArrG_x2D + proprio.getX2D();
			coinArrG_y2D = coinArrG_y2D + proprio.getY2D()+rayon;		
			coinArrD_x2D = coinArrD_x2D + proprio.getX2D();
			coinArrD_y2D = coinArrD_y2D + proprio.getY2D()+rayon;
			/**
			trace("---------2D---4-------");
			trace("centreA :"+proprio.getX2D()+" , "+proprio.getY2D());
 			trace("avG :"+coinAvG_x2D+" , "+coinAvG_y2D);
			trace("avD :"+coinAvD_x2D+" , "+coinAvD_y2D);
			trace("arrG :"+coinArrG_x2D+" , "+coinArrG_y2D);
			trace("arrD :"+coinArrD_x2D+" , "+coinArrD_y2D);
			**/
		}				
		
		//renvoie la distance entre le point de coordonnée 2D x,y avec le proprio
		private function distancePoint(persProprio:Personne,x2:Number,y2:Number):Number
		{
			return Math.sqrt(Math.pow((x2-persProprio.getX2D()),2)+Math.pow((y2-persProprio.getY2D()),2));			
		}
		//renvoie l'angle POX entre le point de coordonnée 2D x,y avec le proprio
		
		//faire un override	de getanglepox
		private function anglePointPOX(persProprio:Personne,x2:Number,y2:Number):Number {			
			var tempX:Number = x2-persProprio.getX2D();
			var tempY:Number = y2-persProprio.getY2D();
			var POX:Number = 180*Math.acos(tempY/distancePoint(persProprio,x2,y2))/Math.PI;
			return 180*Math.atan2(tempX,tempY)/Math.PI;
/* 			if (persProprio.getX2D()-x2 > 0)
				{return POX;}
			else {return -POX;}	 */					
		}


		
		//Angles des coins	pour le passage en 3D	
		private var angleCoinAvG:Number;
		private var angleCoinAvD:Number;
		private var angleCoinArrG:Number;
		private var angleCoinArrD:Number;
		private var angleTemp:Number;
		
		public override function CalculAnglePOX(persProprio:Personne):void {
			super.CalculAnglePOX(persProprio);
			angleCoinAvG = anglePointPOX(persProprio,coinAvG_x2D, coinAvG_y2D);
			angleCoinAvD = anglePointPOX(persProprio,coinAvD_x2D, coinAvD_y2D);
			angleCoinArrG = anglePointPOX(persProprio,coinArrG_x2D, coinArrG_y2D);
			angleCoinArrD = anglePointPOX(persProprio,coinArrD_x2D, coinArrD_y2D);
		}
		public override function setAnglePOX(proprio:Personne,angle:Number):void {
			super.setAnglePOX(proprio,angle);
			//
			angleTemp = angleCoinAvG+angle;			
			if(angleTemp > 0){
				angleTemp = angleTemp%360;
			}else if(angleTemp < 0){
				angleTemp = angleTemp%(-360);
			}
			angleCoinAvG = angleTemp;
			//
			angleTemp = angleCoinAvD+angle;			
			if(angleTemp > 0){
				angleTemp = angleTemp%360;
			}else if(angleTemp < 0){
				angleTemp = angleTemp%(-360);
			}
			angleCoinAvD = angleTemp;
			//
			angleTemp = angleCoinArrG+angle;			
			if(angleTemp > 0){
				angleTemp = angleTemp%360;
			}else if(angleTemp < 0){
				angleTemp = angleTemp%(-360);
			}
			angleCoinArrG = angleTemp;
			//
			angleTemp = angleCoinArrD+angle;			
			if(angleTemp > 0){
				angleTemp = angleTemp%360;
			}else if(angleTemp < 0){
				angleTemp = angleTemp%(-360);
			}
			angleCoinArrD = angleTemp;
		}
		
		//Calcul les coordonnees de la table en 3D
		public override function CalculCoordonnee3D(persProprio:Personne):void { 
			//centre
			super.CalculCoordonnee3D(persProprio);
			//coin avant gauche	
			/**							
			trace("distance coinAvG-prop="+distancePoint(persProprio,coinAvG_x2D, coinAvG_y2D));
			trace("distance coinAvD-prop="+distancePoint(persProprio,coinAvD_x2D, coinAvD_y2D));
			trace("distance coinArrG-prop="+distancePoint(persProprio,coinArrG_x2D, coinArrG_y2D));
			trace("distance coinArrD-prop="+distancePoint(persProprio,coinArrD_x2D, coinArrD_y2D));
			***/
			coinAvG_x3D = Math.cos((angleCoinAvG)*Math.PI/180)*distancePoint(persProprio,coinAvG_x2D, coinAvG_y2D)+Vue3D.xCenter;
			coinAvG_z3D = Math.sin((angleCoinAvG)*Math.PI/180)*distancePoint(persProprio,coinAvG_x2D, coinAvG_y2D);
			coinAvG_y3D = coinAvG_z3D*Math.sin(-30*Math.PI/180)+Vue3D.yCenter;
			//coin avant droit								
			coinAvD_x3D = Math.cos((angleCoinAvD)*Math.PI/180)*distancePoint(persProprio,coinAvD_x2D, coinAvD_y2D)+Vue3D.xCenter;
			coinAvD_z3D = Math.sin((angleCoinAvD)*Math.PI/180)*distancePoint(persProprio,coinAvD_x2D, coinAvD_y2D);
			coinAvD_y3D = coinAvD_z3D*Math.sin(-30*Math.PI/180)+Vue3D.yCenter;
			//coin arriere gauche	
			coinArrG_x3D = Math.cos((angleCoinArrG)*Math.PI/180)*distancePoint(persProprio,coinArrG_x2D, coinArrG_y2D)+Vue3D.xCenter;
			coinArrG_z3D = Math.sin((angleCoinArrG)*Math.PI/180)*distancePoint(persProprio,coinArrG_x2D, coinArrG_y2D);
			coinArrG_y3D = coinArrG_z3D*Math.sin(-30*Math.PI/180)+Vue3D.yCenter;
			//coin arriere droit								
			coinArrD_x3D = Math.cos((angleCoinArrD)*Math.PI/180)*distancePoint(persProprio,coinArrD_x2D, coinArrD_y2D)+Vue3D.xCenter;
			coinArrD_z3D = Math.sin((angleCoinArrD)*Math.PI/180)*distancePoint(persProprio,coinArrD_x2D, coinArrD_y2D);
			coinArrD_y3D = coinArrD_z3D*Math.sin(-30*Math.PI/180)+Vue3D.yCenter;								
		}					
					
		//Affiche une table en 2D (pour test)
		public override function affiche2D() : void {
									
			shapeSurface2D = new Shape();
			
			// Non obligatoire : efface toutes formes
			//shapeSurface2D.graphics.clear();	  
			
			shapeSurface2D.graphics.lineStyle(1, 0x333333, 100);	  
	     	shapeSurface2D.graphics.beginFill(0xF7F7F7, 100);						   

	      	// Definition du point d origine de la surface est
	      	//dans les parametres x et y de calculDimension()	      		      		      	
	      	shapeSurface2D.graphics.moveTo(coinAvG_x2D,coinAvG_y2D);	      	
	      	shapeSurface2D.graphics.lineTo(coinAvD_x2D,coinAvD_y2D);	      		      	
	      	shapeSurface2D.graphics.lineTo(coinArrD_x2D,coinArrD_y2D);	      		      	
	      	shapeSurface2D.graphics.lineTo(coinArrG_x2D,coinArrG_y2D);  	    	
	      	shapeSurface2D.graphics.lineTo(coinAvG_x2D,coinAvG_y2D);								   
     	 	 			     		
      		// Definit la fin de la forme
      		shapeSurface2D.graphics.endFill();
 
      		// Ajout
      		addChild(shapeSurface2D); 			
		}
		
		
		/** _________________________________________________________________________ 
		 * Dessin de la table entiere en 3D
		 */		
		public override function affiche3D() : void {
 			this.x=this.getX3D();
			this.y=this.getY3D(); 
			//retire les cercles magiques! voir grp3 idem
			//graphics.clear();
			
			//effacer les zones de dessins
			shapeSurface3D.graphics.clear();			
			spritePieds.graphics.clear();
			/**			
			trace("---------3D----------");
			trace("centreA :"+getX3D()+" , "+getY3D());
 			trace("avG :"+coinAvG_x3D+" , "+coinAvG_y3D);
			trace("avD :"+coinAvD_x3D+" , "+coinAvD_y3D);
			trace("arrG :"+coinArrG_x3D+" , "+coinArrG_y3D);
			trace("arrD :"+coinArrD_x3D+" , "+coinArrD_y3D);	 
			**/
			//decalage par rapport au centre
			var varX:Number = Vue3D.xCenter+rayon;
			var varY:Number = Vue3D.yCenter+rayon;			
			
			//dessin des pieds selon style de table
			if (this.nbPieds == 1) {
				spritePieds.graphics.lineStyle(3, this.couleurPieds, 100);						
				spritePieds.graphics.moveTo(this.getX3D()-varX,this.getY3D()-varY);	      	
		      	spritePieds.graphics.lineTo(this.getX3D()-varX,this.getY3D()+rayon-varY);	      	      	
			}
			else{
				
				spritePieds.graphics.lineStyle(2, this.couleurPieds, 100);						
				spritePieds.graphics.moveTo(coinAvG_x3D-varX,coinAvG_y3D-varY);	      	
		      	spritePieds.graphics.lineTo(coinAvG_x3D-varX,coinAvG_y3D+rayon-varY);	      	      	
		      	spritePieds.graphics.moveTo(coinAvD_x3D-varX,coinAvD_y3D-varY);
		      	spritePieds.graphics.lineTo(coinAvD_x3D-varX,coinAvD_y3D+rayon-varY);	     	      	
		      	spritePieds.graphics.moveTo(coinArrG_x3D-varX,coinArrG_y3D-varY);
		      	spritePieds.graphics.lineTo(coinArrG_x3D-varX,coinArrG_y3D+rayon-varY);  	  	
		      	spritePieds.graphics.moveTo(coinArrD_x3D-varX,coinArrD_y3D-varY);
		      	spritePieds.graphics.lineTo(coinArrD_x3D-varX,coinArrD_y3D+rayon-varY); 
	 		 }
											 
	      	// Definition du point d origine de la surface est
	      	//dans les parametres x et y de calculDimension()
	      	//shapeSurface.graphics.moveTo(100,400);	
	      	shapeSurface3D.graphics.lineStyle(2, this.couleurContour, 100);	  	
	     	shapeSurface3D.graphics.beginFill(this.couleurPlateau, 100);      		    		      		 	      		      		      	
	      	shapeSurface3D.graphics.moveTo(coinAvG_x3D-varX,coinAvG_y3D-varY);	      	
	      	shapeSurface3D.graphics.lineTo(coinAvD_x3D-varX,coinAvD_y3D-varY);	      	      	
	      	shapeSurface3D.graphics.lineTo(coinArrD_x3D-varX,coinArrD_y3D-varY);	      	      	
	      	shapeSurface3D.graphics.lineTo(coinArrG_x3D-varX,coinArrG_y3D-varY);  	  	
	      	shapeSurface3D.graphics.lineTo(coinAvG_x3D-varX,coinAvG_y3D-varY);		        	 	 			     		
      		// Definit la fin de la forme a remplir
      		shapeSurface3D.graphics.endFill();
      		
      		// Ajout
      		addChild(spritePieds); 
      		addChild(shapeSurface3D);
		}
		
		
		public override function getClass() : String {			
			var s:String = "Table";			
			return s;
		}

			
	}
}
