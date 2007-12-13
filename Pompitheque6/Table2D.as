package
{
	public class Table2D extends Acteur
	{
		private var couleur:Number = 0;
		private var langueur:Number = 10;
		public var hauteur:Number = 10;
		
		public function Table2D(x:Number,y:Number){
			super("chaise",x,y,0);
			graphics.clear();
			graphics.beginFill(couleur,1);
			graphics.drawRect(0,0,langueur,hauteur);
			graphics.endFill();
			this.x = x;
			this.y = y;
		}
		
		public function select():void {
			graphics.clear();
			graphics.beginFill(0xDDDDFF,1);
			graphics.drawRect(0,0,langueur,hauteur);
			graphics.endFill();
			this.x = x;
			this.y = y;
		}
		
		public function deselect():void {
			graphics.clear();
			graphics.beginFill(couleur,1);
			graphics.drawRect(0,0,langueur,hauteur);
			graphics.endFill();
			this.x = x;
			this.y = y;
		}
		
		public override function getClass():String{
			return "table";
		}
	}
}