package
{
	public class Porte2D extends Acteur
	{
		public function Porte2D(x1:Number,y1:Number,x2:Number,y2:Number){
			super("x1",x1,x1,x1);
			graphics.clear();
			graphics.beginFill(0,1);
			graphics.drawCircle(x1,y1,4);
			graphics.endFill();
			graphics.beginFill(0,1);
			graphics.drawCircle(x2,y2,4);
			graphics.endFill();
			graphics.lineStyle(5,0,1);
			graphics.moveTo(x1,y1);
			graphics.lineTo(x2,y2);
			
		}
	}
}