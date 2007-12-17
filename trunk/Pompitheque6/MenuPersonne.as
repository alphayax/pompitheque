package
{
	//import flash.display.Sprite;
	import flash.display.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	
	public class MenuPersonne extends Sprite
	{
		
		public function MenuPersonne(x:Number,y:Number,per:Array){
			
			var pers:Array = new Array();
		    var posx:Array = new Array();
		    var posy:Array = new Array();
			

			this.x = x;
			this.y = y;
			
			
			graphics.lineStyle(0,0,0);			
			graphics.beginFill(0xFFFFFF,1);
			graphics.drawRect(0,0,150,400);
			graphics.endFill();
			
			for(var i:Number = 0; i < per.length; i++){
				var b:menuBoutton = new menuBoutton((Acteur) (per[i]).getName(),[0xDDDDDD,0xDDDDFF],[0,i*21+25,20,150],bClique,[(Acteur) (per[i]).getX2D(),(Acteur) (per[i]).getY2D()]);
				per[i].bouttonConcernant = b;
				addChild(b);
			}
		}
	
	
	private function bClique(e:MouseEvent):void {
		Object(e.target.parent.parent.parent).deplacer(Object(e.target.parent.parent.parent).indication,e.target.parent.D2[0],e.target.parent.D2[1]);
		Object(e.target.parent.parent.parent).indication.visible = true;
	}
	

	
	
	}
	
}