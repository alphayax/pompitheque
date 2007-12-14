package {
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	
	public class Table extends Acteur {
		
		//Dimension de la table
		public var rayon:Number;
		public var nbPieds:Number; 
		// 0 = 4 pieds, 1 = 1 pied central
		
		//Couleurs
		public var couleurPlateau:uint;
		public var couleurContour:uint;
		public var couleurPieds:uint;
		
		//2D
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
		
		//3D
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
				
		//Angles des coins	pour le passage en 3D	
		public var angleCentre:Number;
		public var angleCoinAvG:Number;
		public var angleCoinAvD:Number;
		public var angleCoinArrG:Number;
		public var angleCoinArrD:Number;
		
		//Distances des coins pour le passage en 3D
		public var distanceCentre:Number;
		public var distanceAvG:Number;
		public var distanceAvD:Number;
		public var distanceArrG:Number;
		public var distanceArrD:Number;
		
		//Calque du plateau Plateau de la table en 2D
		public var shapeSurface2D:Shape;
		
		//Calque du plateau Plateau de la table en 3D
		public var shapeSurface3D:Shape;
		
		//Calque des pieds de table
		public var spritePieds:Sprite;
		


		//_____________________________Constructeur__________________________________
		public function Table(nom:String, x2D:Number, y2D:Number, angleAbsolu:Number, dimension:Number, couleurPlateau:uint, couleurContour:uint, couleurPieds:uint,nbPieds:Number) {
			//constructeur d'Acteur
			super(nom, x2D, y2D, angleAbsolu);
			
			//attributs
			this.rayon = dimension/2;
			this.nbPieds = nbPieds;
			this.couleurPlateau = couleurPlateau;
			this.couleurContour = couleurContour;
			this.couleurPieds = couleurPieds;
			
			//Instance des zones de dessin	
			shapeSurface3D  = new Shape();
			spritePieds = new Sprite();
			
			//Calcul des dimensions et position de la table	en 2D				
			//calculCoord2D();	
			
			//trace("fin table");
		}
		
		
		
					
		//_______________________________Fonctions___________________________________
										
		/************************************************************ 
		 * Fonction qui calcul les coordonnées des coins de la table
		 * en fonction du centre et de la longueur de la table
		 * le rayon = longueur table/2 
		 ***********************************************************/
		public function calculCoord2D() : void {
			//		
			coinAvG_x2D = this.getX2D()-rayon;
			coinAvG_y2D = this.getY2D()+rayon;
			//
			coinAvD_x2D = this.getX2D()+rayon;
			coinAvD_y2D = this.getY2D()+rayon;
			//
			coinArrG_x2D = this.getX2D()-rayon;
			coinArrG_y2D = this.getY2D()-rayon;
			//
			coinArrD_x2D = this.getX2D()+rayon;
			coinArrD_y2D = this.getY2D()-rayon;			
		}
		
		

		/***********************************************
		* calcul du % de la taille de l'acteur a afficher
		* on a besoin de la distance entre le proprio et l'acteur et la distance max * dans le plan
		********************************/
		public override function CalculRedimensionnement3D(distanceMax:Number):void
		{
			this.rayon =   (rayon*((distanceMax - getDistanceProprio())/distanceMax));	
			
			//
			calculCoord2D();		
		}


		
		/***************************************************************
		 * Fonction Générique qui sert a mettre la table sous le bon angle 
		 * initial, puis transpose les coordonnées 2d en 3d
		 ****************************************************************/
		public override function CalculAngleVue(persProprio:Acteur):void{		
			//CalculAngleAbsolu()-------------------------------------
			//Translation pour avoir le centre de la table pour origine									
			var temp_coinAvG_x2D:Number = coinAvG_x2D - this.getX2D();
			var temp_coinAvG_y2D:Number = coinAvG_y2D - this.getY2D();
			//
			var temp_coinAvD_x2D:Number = coinAvD_x2D - this.getX2D();
			var temp_coinAvD_y2D:Number = coinAvD_y2D - this.getY2D();
			//
			var temp_coinArrG_x2D:Number = coinArrG_x2D - this.getX2D();
			var temp_coinArrG_y2D:Number = coinArrG_y2D - this.getY2D();
			//
			var temp_coinArrD_x2D:Number = coinArrD_x2D - this.getX2D();
			var temp_coinArrD_y2D:Number = coinArrD_y2D - this.getY2D();
			
			//Rotation
			// On a besoin d'avoir l'angle en radians : angle_rad = angle_deg*PI/180
			// Formule pour la rotation :
			// x = x'*cos(angle) - y'*sin(angle)
			// y = x'*sin(angle) + y'*cos(angle)
			coinAvG_x2D = temp_coinAvG_x2D*Math.cos(this.getAngleAbsolu()*Math.PI/180) - temp_coinAvG_y2D*Math.sin(this.getAngleAbsolu()*Math.PI/180);
			coinAvG_y2D = temp_coinAvG_x2D*Math.sin(this.getAngleAbsolu()*Math.PI/180) + temp_coinAvG_y2D*Math.cos(this.getAngleAbsolu()*Math.PI/180);
			//
			coinAvD_x2D = temp_coinAvD_x2D*Math.cos(this.getAngleAbsolu()*Math.PI/180) - temp_coinAvD_y2D*Math.sin(this.getAngleAbsolu()*Math.PI/180);
			coinAvD_y2D = temp_coinAvD_x2D*Math.sin(this.getAngleAbsolu()*Math.PI/180) + temp_coinAvD_y2D*Math.cos(this.getAngleAbsolu()*Math.PI/180);
			//
			coinArrG_x2D = temp_coinArrG_x2D*Math.cos(this.getAngleAbsolu()*Math.PI/180) - temp_coinArrG_y2D*Math.sin(this.getAngleAbsolu()*Math.PI/180);
			coinArrG_y2D = temp_coinArrG_x2D*Math.sin(this.getAngleAbsolu()*Math.PI/180) + temp_coinArrG_y2D*Math.cos(this.getAngleAbsolu()*Math.PI/180);
			//
			coinArrD_x2D = temp_coinArrD_x2D*Math.cos(this.getAngleAbsolu()*Math.PI/180) - temp_coinArrD_y2D*Math.sin(this.getAngleAbsolu()*Math.PI/180);
			coinArrD_y2D = temp_coinArrD_x2D*Math.sin(this.getAngleAbsolu()*Math.PI/180) + temp_coinArrD_y2D*Math.cos(this.getAngleAbsolu()*Math.PI/180);
					
			//Translation pour revenir avec une origine en 0,0
			coinAvG_x2D = coinAvG_x2D + this.getX2D();
			coinAvG_y2D = coinAvG_y2D + this.getY2D();	
			//
			coinAvD_x2D = coinAvD_x2D + this.getX2D();
			coinAvD_y2D = coinAvD_y2D + this.getY2D();	
			//
			coinArrG_x2D = coinArrG_x2D + this.getX2D();
			coinArrG_y2D = coinArrG_y2D + this.getY2D();
			//
			coinArrD_x2D = coinArrD_x2D + this.getX2D();
			coinArrD_y2D = coinArrD_y2D + this.getY2D();	
					
														
			//passerEn3D()----------------------------------------
			//Calcul des dimensions et positions de la table en 3D	
			//trace("3d tab");	
			distanceCentre= Math.sqrt(Math.pow((this.getX2D()-persProprio.getX2D()),2)+Math.pow((this.getY2D()-persProprio.getY2D()),2));			
			distanceAvG= Math.sqrt(Math.pow((coinAvG_x2D-persProprio.getX2D()),2)+Math.pow((coinAvG_y2D-persProprio.getY2D()),2));
			distanceAvD= Math.sqrt(Math.pow((coinAvD_x2D-persProprio.getX2D()),2)+Math.pow((coinAvD_y2D-persProprio.getY2D()),2));
			distanceArrG= Math.sqrt(Math.pow((coinArrG_x2D-persProprio.getX2D()),2)+Math.pow((coinArrG_y2D-persProprio.getY2D()),2));
			distanceArrD= Math.sqrt(Math.pow((coinArrD_x2D-persProprio.getX2D()),2)+Math.pow((coinArrD_y2D-persProprio.getY2D()),2));
			//
			angleCentre = calculAngleVue(this.getX2D(),this.getY2D(),persProprio.getX2D(),persProprio.getY2D(), distanceCentre);
			angleCoinAvG = calculAngleVue(coinAvG_x2D,coinAvG_y2D,persProprio.getX2D(),persProprio.getY2D(), distanceAvG);
			angleCoinAvD= calculAngleVue(coinAvD_x2D,coinAvD_y2D,persProprio.getX2D(),persProprio.getY2D(), distanceAvD);
			angleCoinArrG = calculAngleVue(coinArrG_x2D,coinArrG_y2D,persProprio.getX2D(),persProprio.getY2D(), distanceArrG);
			angleCoinArrD = calculAngleVue(coinArrD_x2D,coinArrD_y2D,persProprio.getX2D(),persProprio.getY2D(), distanceArrD);	
		}	


	
		/********************************************************** 
		 *  sous routine calculAngleVue pour chaque angle
		 * 	intervenant dans la fonction CalculAngleVue ci-dessus
		 *********************************************************/ 
		public function calculAngleVue( coinX:Number , coinY:Number , proprioX2D:Number, proprioY2D:Number, distance:Number ) :  Number {
			var temp:Number = coinX-proprioY2D;		
			var angle:Number = 180*Math.acos(temp/distance)/Math.PI;		
			return angle;
			
		/*	var tempX:Number = coinX-proprioX2D;
			var tempY:Number = coinY-proprioY2D;
			var POX:Number = 180*Math.acos(tempY/distancePoint(persProprio,coinX,coinY))/Math.PI;
 			return 180*Math.atan2(tempX,tempY)/Math.PI; */
		}
		
		
		
		/*********************************************
		 * Calcul les coordonnées de la table en 3D
		 *********************************************/
		public override function CalculCoordonnee3D(persProprio:Personne):void {
			//trace("cal coord tab");			
			//										
			this.setX3D(Math.cos((angleCentre)*Math.PI/180)*distanceCentre+Vue3D.xCenter);
			this.setZ3D(Math.sin((angleCentre)*Math.PI/180)*distanceCentre);
			this.setY3D(this.getZ3D()*Math.sin(-15*Math.PI/180)+Vue3D.yCenter);
			//										
			coinAvG_x3D = Math.cos((angleCoinAvG)*Math.PI/180)*distanceAvG+Vue3D.xCenter;
			coinAvG_z3D = Math.sin((angleCoinAvG)*Math.PI/180)*distanceAvG;
			coinAvG_y3D = coinAvG_z3D*Math.sin(-15*Math.PI/180)+Vue3D.yCenter;
			//
			coinAvD_x3D = Math.cos((angleCoinAvD)*Math.PI/180)*distanceAvD+Vue3D.xCenter;
			coinAvD_z3D = Math.sin((angleCoinAvD)*Math.PI/180)*distanceAvD;
			coinAvD_y3D = coinAvD_z3D*Math.sin(-15*Math.PI/180)+Vue3D.yCenter;
			//
			coinArrG_x3D = Math.cos((angleCoinArrG)*Math.PI/180)*distanceArrG+Vue3D.xCenter;
			coinArrG_z3D = Math.sin((angleCoinArrG)*Math.PI/180)*distanceArrG;
			coinArrG_y3D = coinArrG_z3D*Math.sin(-15*Math.PI/180)+Vue3D.yCenter;
			//
			coinArrD_x3D = Math.cos((angleCoinArrD)*Math.PI/180)*distanceArrD+Vue3D.xCenter;
			coinArrD_z3D = Math.sin((angleCoinArrD)*Math.PI/180)*distanceArrD;
			coinArrD_y3D = coinArrD_z3D*Math.sin(-15*Math.PI/180)+Vue3D.yCenter;
		}
			
					
		/**************************************************
		 * Affiche une table en 2D   (Useless ici)
		 **************************************************/
		 public override function affiche2D() : void {
			//			
			shapeSurface2D = new Shape();
			
			// Non obligatoire : efface toutes formes
			shapeSurface2D.graphics.clear();	  		
			shapeSurface2D.graphics.lineStyle(1, 0x333333, 100);	  
	     	shapeSurface2D.graphics.beginFill(0xF7F7F7, 100);						   

	      	// Définition du point d’origine de la surface est
	      	//dans les paramètres x et y de calculDimension()	      		      		      	
	      	shapeSurface2D.graphics.moveTo(coinAvG_x2D,coinAvG_y2D);	      	
	      	shapeSurface2D.graphics.lineTo(coinAvD_x2D,coinAvD_y2D);	      		      	
	      	shapeSurface2D.graphics.lineTo(coinArrD_x2D,coinArrD_y2D);	      		      	
	      	shapeSurface2D.graphics.lineTo(coinArrG_x2D,coinArrG_y2D);  	    	
	      	shapeSurface2D.graphics.lineTo(coinAvG_x2D,coinAvG_y2D);								   
     	 	 			     		
      		// Définit la fin de la forme
      		shapeSurface2D.graphics.endFill();
 
      		// Ajout
      		addChild(shapeSurface2D); 			
		}
		
		
		
		/*********************************************** 
		 * Affiche3D : Dessin de la table entiere en 3D
		 ***********************************************/		
		public override function affiche3D() : void {
						
			//TRES IMPORTANT 
			//retire les cercles magiques! 
			//voir grp3 idem
			graphics.clear();
			
			//effacer les zones de dessins
			shapeSurface3D.graphics.clear();			
			spritePieds.graphics.clear();
			//trace("dessin table - affiche 3D");
		
			//Dessin des pieds selon style de table
			if (this.nbPieds == 1) {
				spritePieds.graphics.lineStyle(3, this.couleurPieds, 100);						
				spritePieds.graphics.moveTo(this.getX3D(),this.getY3D());	      	
		      	spritePieds.graphics.lineTo(this.getX3D(),this.getY3D()+rayon);	      	      	
			}
			else{				
				spritePieds.graphics.lineStyle(2, this.couleurPieds, 100);						
				spritePieds.graphics.moveTo(coinAvG_x3D,coinAvG_y3D);	      	
		      	spritePieds.graphics.lineTo(coinAvG_x3D,coinAvG_y3D+rayon);	      	      	
		      	spritePieds.graphics.moveTo(coinAvD_x3D,coinAvD_y3D);
		      	spritePieds.graphics.lineTo(coinAvD_x3D,coinAvD_y3D+rayon);	     	      	
		      	spritePieds.graphics.moveTo(coinArrG_x3D,coinArrG_y3D);
		      	spritePieds.graphics.lineTo(coinArrG_x3D,coinArrG_y3D+rayon);  	  	
		      	spritePieds.graphics.moveTo(coinArrD_x3D,coinArrD_y3D);
		      	spritePieds.graphics.lineTo(coinArrD_x3D,coinArrD_y3D+rayon); 
		      	//trace("fin dessin sprite");
	 		 }
											 
	      	//Dessin du plateau de la table	
	      	shapeSurface3D.graphics.lineStyle(2, this.couleurContour, 100);	  
	     	shapeSurface3D.graphics.beginFill(this.couleurPlateau, 100);      		    		      		 	      		      		      	
	      	shapeSurface3D.graphics.moveTo(coinAvG_x3D,coinAvG_y3D);	      	
	      	shapeSurface3D.graphics.lineTo(coinAvD_x3D,coinAvD_y3D);	      	      	
	      	shapeSurface3D.graphics.lineTo(coinArrD_x3D,coinArrD_y3D);	      	      	
	      	shapeSurface3D.graphics.lineTo(coinArrG_x3D,coinArrG_y3D);  	  	
	      	shapeSurface3D.graphics.lineTo(coinAvG_x3D,coinAvG_y3D);					        	 	 			     		
      		// Définit la fin de la forme à remplir
      		shapeSurface3D.graphics.endFill();
      		//trace("fin dessin shape");
      		
      		// Ajout
      		addChild(spritePieds); 
      		addChild(shapeSurface3D);
      		//trace("addchild dessin sprite");	
		}
		
		
		
		/***********************************
		 * Get Classe
		 ***********************************/
		public function getClass() : String {			
			var s:String = "Table";			
			return s;
		}
	
	
		
		/********************************************************	
		 * Angle de vue pour tourner la tete à gauche ou à droite
		 *********************************************************/
		public override function getAngleVue():Number {return 0;}
		public override function setAngleVue(nbDegre:Number):void {
			angleCentre +=nbDegre;				
			angleCoinAvG +=nbDegre;
			angleCoinAvD +=nbDegre;
			angleCoinArrG +=nbDegre;
			angleCoinArrD +=nbDegre;
			//trace("tourner tab");
		}
			
	}
}
