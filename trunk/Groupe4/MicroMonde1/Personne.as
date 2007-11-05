package
{
	import flash.display.*;
	import flash.net.*;
	
	public class Personne extends Sprite
	{
		//coordonnées de la personne
		public var posX:Number = 0;
		public var posY:Number = 0;
		public var posZ:Number = 0;
		
		//distance avec le point de vue
		public var Distance:Number = 0;
		
		//nom de la personne 
		public var nom:String = "Garry";
		
		//angle initial avec le point de vue
		public var angle:Number = 0;
		
		//angle d'orientation
		public var angleOrientation:Number = 0;
		
		//image de la personne
		public var image:String = "0.gif";
		
		public function Personne(couleur:uint,name:String){
			//on dessine un cercle avec pour centre le point 0,0
			graphics.lineStyle(1);
			graphics.beginFill(couleur);
			graphics.drawCircle(0,0,10);
			nom=name;
			affichePersonne();
			
		}
		
		
		public function setPositionAbsolue(varX:Number,varY:Number,varZ:Number):void{
			posX = varX;
			posY = varY;
			posZ = varZ;
			trace("nouvelle position de "+nom+" x = "+posX+"   y ="+posY);
		}
		
		public function modifierTaille(hauteur:Number, largeur:Number):void{
			width = largeur;
			height = hauteur;
		}
			
		
		public function affichePersonne():void{
			var img:Loader= new Loader();		
			img.load(new URLRequest(image));
			var largeur:Number = 150;
			var hauteur:Number = 74;			
			addChild(img);
			this.getChildAt(0).y -= 375;
			this.getChildAt(0).x -= 118;
			trace("chargement acteur x: "+img.x+" y: "+img.y);
		}
		
		
		
	}
}