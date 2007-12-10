package Pompitheque
{
	import flash.display.Sprite;
	import flash.system.System;
	
	//On defini un acteur comme un objet a afficher
	//donc ce sera soit une Personne soit un objet du mobilier
	//les methode de calcul pour le placement dans la vue 3D sont les meme
	//seul l'affichage de l'objet va changer et donc sera overrider dans les sous classes
	
	public class Acteur extends Sprite
	{
		
		//pour enchainement des objets en multi sélections
		public var next:Object = null;
		public var prev:Object = null;
		
		//nom de l'acteur (personne ou objet)
		public var nom:String;
		
		//position sur la grille (créé sur le serveur)
		private var x2D:Number;
		private var y2D:Number;		
		
		//position 3D (créé par la vue 3D)
		public var x3D:Number;
		public var y3D:Number;
		private var z3D:Number;
		
		//Angle PÔX entre la personne, l'origine et l'axe des X
		private var anglePOX:Number = 0;
		
		//angle absolu, c'est a dire fixe par rapport a la grille
		//il ne changera pas pour un objet
		//il va changer qd la personne va tourner
		
		//ANGLE DE ROTATION DE L'ACTEUR SUR LUI MEME
		private var angleAbsolu:Number; 
		
		//angle de l'acteur par rapport au point de vue			
		public var angleVue:Number;
		
		//profondeur du calque sur lequel on va faire afficher l'acteur
		//necessaire pour l'affichage dans l'ordre avec le addchild et pour le tri dans le tableau d'acteur de la vue
		private var profondeurVue:Number;
		
		//distance entre l'acteur et le proprio
		private var distanceProprio:Number;
		
		//pourcentage de la taille de l'acteur a afficher
		private var tailleImage:Number;		
		
		public function Acteur(nom:String,x2D:Number,y2D:Number,angleAbsolu:Number)
		{
			graphics.lineStyle(1);
			graphics.beginFill(0xffffff);
			graphics.drawCircle(0,0,10);
			
			this.nom=nom;
			this.x2D=x2D;
			this.y2D=y2D;
			this.angleAbsolu=angleAbsolu;			
		}
		
		//affiche l'acteur au coordonnées 3D (vue3D)
		public function affiche3D():void
		{	
			this.x = this.x3D;
			this.y = this.y3D;
			//trace(this.x3D+"  3D  "+this.y3D);
		}
		
		//affiche l'acteur au coordonnées 2D (vue2D)
		public function affiche2D():void
		{
			this.x = this.x2D;
			this.y = this.y2D;
		}				

		//calcul des coordonnées 3D de l'acteur de la vue
		//a partir des coordonnées 2D de l'acteur de la vue,
		//de la distance maximale dans le plan
		//et des coordonnées 2D du personnage propriaitaire de la vue3D
		public function CalculCoordonnee3D(persProprio:Personne):void
		{
			/**trace("POx  :"+anglePOX);**/
			x3D = Math.cos((anglePOX)*Math.PI/180)*distanceProprio+Vue3D.xCenter;
			z3D = Math.sin((anglePOX)*Math.PI/180)*distanceProprio;
			y3D = z3D*Math.sin(-30*Math.PI/180)+Vue3D.yCenter;
			/**trace(nom+': coord 3D='+x3D+'  ;   '+y3D);**/
			//trace('angle : '+angleVue+'   dist :'+distanceProprio);
		}
		
		
		//calcul la distance entre l'acteur et le propriaitaire de la vue 3D
		public function CalculDistance(persProprio:Personne):void
		{
			this.distanceProprio= Math.sqrt(Math.pow((this.x2D-persProprio.getX2D()),2)+Math.pow((this.y2D-persProprio.getY2D()),2));
			
		}
		
		//calcul du % de la taille de l'acteur a afficher
		//on a besoin de la distance entre le proprio et l'acteur et la distance max dans le plan
		public function CalculRedimensionnement3D(distanceMax:Number):void
		{
			this.width = (distanceMax - distanceProprio)*20/distanceMax;
			this.height = (distanceMax - distanceProprio)*20/distanceMax;
			
		}
		
		//calcul pour savoir si un acteur est dans l'angle de vue (renvoie true) ou pas (renvoie false)
		public function isEnVue(persProprio:Personne):Boolean
		{
			if(anglePOX > 10 && anglePOX < 170){
				return true;
			}
			if(anglePOX > -350 && anglePOX < -190){
				return true;
			}
			return false;	
		}
		
		//calcul de l'angle de l'acteur vue par le personnage propriétaire de la vue3D
		//on se base sur l'angle absolue de l'acteur vue (donc par rapport a la grille)
		public function CalculAngleVue(persProprio:Personne):void
		{
			this.angleVue = (180 - persProprio.getAngleAbsolu() - this.angleAbsolu) % 360;			
		}
		
		public function CalculAnglePOX(persProprio:Personne):void
		{
			//180 * (angle en radian) / pi
			var tempX:Number = x2D-persProprio.getX2D();
			var tempY:Number = y2D-persProprio.getY2D();
			//trace('x :'+180*Math.acos(tempX/distanceProprio)/Math.PI+'   ---   y :'+180*Math.asin(tempY/distanceProprio)/Math.PI);
			anglePOX = 180*Math.atan2(tempX,tempY)/Math.PI;
			this.anglePOX = (anglePOX+persProprio.getAngleAbsolu()+90)%360
			//angleVue = angleAbsolu;
		}
		
		
		
		//accesseur
		public function getName():String {return nom;}
		public function getX2D():Number {return x2D;}
		public function getY2D():Number {return y2D;}
		public function setX2D(x2D:Number):void {this.x2D=x2D}
		public function setY2D(y2D:Number):void {this.y2D=y2D}
		
		public function getX3D():Number {return x3D;}
		public function getY3D():Number {return y3D;}
		public function getZ3D():Number {return z3D;}
		public function setX3D(x3D:Number):void {this.x3D=x3D}
		public function setY3D(y3D:Number):void {this.y3D=y3D}
		public function setZ3D(Z3D:Number):void {this.y3D=y3D}
		
		public function getAngleAbsolu():Number {return angleAbsolu;}
		public function setAngleAbsolu(angleAbsolu:Number):void {this.angleAbsolu=angleAbsolu;}
		
		public function getAngleVue():Number {return angleVue;}
		public function setAngleVue(angleVue:Number):void {this.angleVue=angleVue;}
		
		public function getAnglePOX():Number {return anglePOX;}
		public function setAnglePOX(poprio:Personne,angle:Number):void {
				var angleTemp:Number = this.getAnglePOX()+angle;
				if(angleTemp > 0){
					angleTemp = angleTemp%360;
				}else if(angleTemp < 0){
					angleTemp = angleTemp%(-360);
				}
				if(!this.isEnVue(poprio)){
					this.visible = false;
				}else{
					this.visible = true;
				}this.anglePOX=angleTemp;
		}
		
		
		public function getProfondeurVue():Number {return profondeurVue;}
		public function setProfondeurVue(profondeurVue:Number):void {this.profondeurVue=profondeurVue;}
		
		
		public function getDistanceProprio():Number {return distanceProprio;}
		public function setDistanceProprio(distanceProprio:Number):void {this.distanceProprio = distanceProprio;}
		
		public function getClass():String{
			return "Acteur";
		}
		
		/************************************************************/
		//groupe2d les fonctions créées
		//cree losange pour représenter l'avatar
		   public function creer_losange(obj:Object,x:Number,y:Number,h:Number,w:Number):Object{
			
			var gra:Object = obj.graphics;	
			gra.lineStyle(1,0,1);
			gra.moveTo(w/2,0);
			gra.lineTo(w,h/2);
			gra.lineTo(w/2,h);
			gra.lineTo(0,h/2);
			gra.lineTo(w/2,0);
			
		
			return obj;
		   }
		
		
		   public function creer_losange_plein(obj:Object,x:Number,y:Number,h:Number,w:Number,co:Number):Object {
			var obj2:Object = obj.graphics;
			obj2.beginFill(co,1);
			creer_losange(obj,x,y,h,w);
			obj2.endFill();
		
			return obj;
		   }
		
		
		   public function deplacer(obj:Object,x:Number,y:Number):void{
			obj.x = x;
			obj.y = y;
		   }
		   
		   public function rotate(obj:Object,a:Number):void {
		   	obj.rotation = obj.rotation + a;
		   	obj.angleAbsolu = obj.rotation;
		   }
		/************************************************************/
		
		
		
		
	}
}