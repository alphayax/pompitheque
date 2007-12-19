package
{
	import flash.events.MouseEvent;
	
	public class Table2D extends Acteur
	{
		private var couleur:Number = 0;
		private var longueur:Number = 10;
		public var hauteur:Number = 10;
		public var selectionne:Boolean = false;
		
		public function Table2D(x:Number,y:Number,longueur:Number,hauteur:Number){
			super("chaise",x,y,0);
			graphics.clear();
			graphics.beginFill(couleur,1);
			graphics.drawRect(0,0,longueur,hauteur);
			this.longueur = longueur;
			this.hauteur = hauteur;
			graphics.endFill();
			this.x = x;
			this.y = y;
			
			addEventListener(MouseEvent.CLICK,clique);
		}
		
		public function select():void {
			graphics.clear();
			graphics.beginFill(0xDDDDFF,1);
			graphics.drawRect(0,0,longueur,hauteur);
			graphics.endFill();
			if(Object(parent).obj_sel != null)
			Object(parent).obj_sel.deselect();
			Object(parent).obj_sel = this;
			selectionne = true;
			this.x = x;
			this.y = y;
		}
		
		public function deselect():void {
			graphics.clear();
			graphics.beginFill(couleur,1);
			graphics.drawRect(0,0,longueur,hauteur);
			graphics.endFill();
			Object(parent).obj_sel = null;
			selectionne = false;
			this.x = x;
			this.y = y;
		}
		
		public override function getClass():String{
			return "table";
		}
		
		private function clique(e:MouseEvent):void{
			if(e.target.selectionne == false){
				e.target.select();
				
			}else{
				e.target.deselect();
				
			}
		}
	}
}