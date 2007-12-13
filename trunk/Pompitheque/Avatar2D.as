package Pompitheque
{
	 import flash.display.Sprite; // Un sprite est un lutin : zone déplaçable et animable
	
	  import flash.display.*;
	
	  import flash.events.*;
	  import flash.net.URLRequest;
	
	  import flash.geom.Matrix;
	  import flash.geom.Rectangle;
//	  import mx.controls.*;
	
	  import flash.text.*;
//	 import mx.containers.*;
	
	public class Avatar2D extends Acteur
	{
		private var infoText:TextField;
		private var couleur:Number = 0x000000;
		public var taille:Number = 10;
		public var infoBule:Sprite;
		public var bouttonConcernant:menuBoutton;
		//private var langueur:Number = 10;
		public function Avatar2D(n:String, x:Number, y:Number,a:Number,statut:String,genre:String){
			super(n,x,y,a);
			//nom = n;
			//X2d = x;
			//Y2d = y;
			//AngleAbsolue = a;
			graphics.clear();
			var r:Number = taille/2;
			if(genre == "M"){
				graphics.beginFill(0,0);
				graphics.lineStyle(1,0,1);
				//graphics.beginFill(0,0);
				graphics.drawCircle(0,0,r);
				graphics.endFill();
				//graphics.endFill();
				graphics.moveTo(0,0);
				graphics.lineTo(0,-9);
				graphics.moveTo(-2,-7);
				graphics.lineTo(0,-9);
				graphics.lineTo(2,-7);
			}else{
				graphics.beginFill(0,0);
				graphics.lineStyle(1,0,1);
				//graphics.beginFill(0,0);
				graphics.drawCircle(0,0,r);
				graphics.endFill();
				//graphics.endFill();
				graphics.moveTo(0,0);
				graphics.lineTo(0,-8);
			}
			if(statut != "debout"){
				this.scaleX = 0.8;
				this.scaleY = 0.8;
			}
			this.rotation = a;
			this.x = x;
			this.y = y;
			
			infoBule = new Sprite();
			infoBule.graphics.beginFill(0x44FFFF,1);
			infoBule.graphics.drawRect(0,0,100,20);
		 	var t:TextField = new TextField();
		 	var tf:TextFormat = new TextFormat();
		 	tf.align = "center";
		 	tf.bold = true;
		 	t.setTextFormat(tf);
		 	infoBule.addChild(t);
		 	t.height = 20;
		 	t.width = 100;
		 	addChild(infoBule);
		 	infoBule.visible = false;
			infoText = t;
			infoBule.y = -20;
			infoBule.rotation = -a;
			
			this.addEventListener(MouseEvent.ROLL_OVER, ShowBule);
			this.addEventListener(MouseEvent.ROLL_OUT, HideBule);

			
		}
		
		public function changerStatut(s:String){
			if(s != "debout"){
				//this.statureAvatar = "assis";
				this.scaleX = 0.8;
				this.scaleY = 0.8;
			}else{
				//this.statureAvatar = "debout";
				this.scaleX = 1;
				this.scaleY = 1;
			}
		}
		
		public function ShowBule(e:MouseEvent):void {
			infoText.text = e.target.nom;
			infoBule.visible = true;
		}
		
		public function HideBule(e:MouseEvent):void {
			infoBule.visible = false;
		}
		
		public override function getClass():String{
			return "avatar";
		}
		
		
		
	
		
	}
}
