package {
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	import Personne;

	public class MicroMonde extends Sprite
	{
		// centre de la rotation
		public var px:Number = 400;
		public var py:Number = 500;
		public var pz:Number = 0;
		
		
		public var hauteur:Number = 375;
		public var largeur:Number = 235;
		
		public var profondeur:Number = 0;
		
		// useless
		public var speed:Number = 10;

		
		// angle rotation de la vue
		public var angleVue:Number = 0;
		public var deplAngle:Number = 2;
		public var deplAngle2:Number = -15;
		
		// distance maximum
		public var distMax:Number=1000;
		
		// taille photo
		public var taillePhoto:Number=20;
		public var nouvTaille:Number=0;
		
		public var pers1:Personne = new Personne(0xff0000,"Robert");
		public var pers2:Personne = new Personne(0xffff00,"Karl");
		public var pers3:Personne = new Personne(0xffffff,"Maria");
		
		public function MicroMonde()
		{
			super();	
			graphics.lineStyle(1);
			graphics.moveTo(px,py);
			graphics.lineTo(px+200,py-115.5);
			graphics.moveTo(px,py);
			graphics.lineTo(px-200,py-115.5);
			
			
			//position des avatars	
			pers1.setPositionAbsolue(px+100,0,pz+100);
			pers2.setPositionAbsolue(px+200,0,pz+200);
			pers3.setPositionAbsolue(px+300,0,pz+300);
			
			//Calcul de l'angle des avatars par rapport au centre de vue 
			/*
			 * A vérifier
			 */
			pers1.angle = Math.atan((pers1.posZ+pz)/(pers1.posX+px))*180/Math.PI;
			pers2.angle = Math.atan((pers2.posZ+pz)/(pers2.posX+px))*180/Math.PI;
			pers3.angle = Math.atan((pers3.posZ+pz)/(pers3.posX+px))*180/Math.PI;
			
			
			//calcul de la distance entre le centre de vue et les avatars
			pers1.Distance = calculDistance(pers1);
			pers2.Distance = calculDistance(pers2);
			pers3.Distance = calculDistance(pers3);
			
			//calcul de la taille de l'avatar			
			calculTaille(pers1);
			calculTaille(pers2);
			calculTaille(pers3);
			
			//ajout des avatars
			addChild(pers3);
			
			addChild(pers2);
			addChild(pers1);
			
			// affichage et placement des avatars
			affichePersonne(pers1);
			affichePersonne(pers2);
			affichePersonne(pers3);
			
			
			this.addEventListener("enterFrame",enterFrame_handler);
		}
		
		public function enterFrame_handler(e:Event):void{
			stage.focus=this;
			addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);			
		}
		
		public function reportKeyDown(event:KeyboardEvent):void {
			// Fleche gauche rotation 5 degrés
			if ( event.keyCode == 37 ) {
				angleVue -= deplAngle;
			}
			
			// Fleche droite
			if ( event.keyCode == 39 ){
				angleVue += deplAngle;
			}
			
			
			if(angleVue>359 ){
				angleVue=0;
			}else if (angleVue< -359){
				angleVue=0;
				
			}
			affichePersonne(pers1);
			affichePersonne(pers2);
			affichePersonne(pers3);
			

		}

		public function calculDistance(pers:Personne):Number{
			//return Math.sqrt(Math.pow((pers.posX-px),2)+Math.pow((pers.posY-py),2));
			var dist:Number = Math.sqrt(Math.pow((pers.posX-px),2)+Math.pow((pers.posZ-pz),2));
			//trace("nom : "+pers.nom+"  px:"+pers.posX+"  py:"+pers.posY+"   pz:"+pers.posZ+"   dist:"+dist);
			return dist;
		}
		
		public function affichePersonne(pers:Personne):void{		
				
			pers.posX = Math.cos((angleVue - pers.angle)*Math.PI/180)*pers.Distance;
			pers.posZ = Math.sin((angleVue - pers.angle)*Math.PI/180)*pers.Distance;
			pers.x=pers.posX+px;
			pers.y=pers.posZ*Math.sin(deplAngle2*Math.PI/180)+py;	
			
			// on n'affiche que les personnes qui sont au dessus de la ligne de vue
			if(pers.y < py){
				pers.visible = true;
			}else{
				pers.visible = false;
			}	
			
			
			if(pers == pers2){
			graphics.lineStyle(1);
			graphics.moveTo(px,py);
			graphics.lineTo(pers.x,pers.y);
			}	
		}
		
		public function calculTaille(pers:Personne):void{
			//profondeur = calculDistance(pers);
			profondeur = pers.Distance;
			nouvTaille = (distMax - profondeur)*taillePhoto/distMax;
			pers.height = nouvTaille;
			pers.width = nouvTaille;
		}		
	}
}
