package
{
	import flash.display.Sprite;
	
	public class Mur2D extends Acteur
	{
		public function Mur2D(x1:Number,y1:Number,x2:Number,y2:Number){
			super("mur",x2,y2,x1);
			graphics.clear();
			graphics.lineStyle(5,0xFF8888);
			graphics.moveTo(x1,y1);
			graphics.lineTo(x2,y2);
		}
	}
} 