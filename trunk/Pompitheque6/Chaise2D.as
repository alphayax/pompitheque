package
{
	import flash.events.*;
	
	public class Chaise2D extends Acteur
	{
		public var selectionne:Boolean = false;
		public var occupe:Boolean = false;
		private var taille:Number = 10;
		private var couleur:Number = 0;
		public function Chaise2D(x:Number,y:Number,a:Number,o:Boolean){ 
			super("chaise",x,y,0);
			graphics.clear();
			graphics.beginFill(0,1);
			graphics.moveTo(0,0);
			graphics.lineTo(taille,0);
			graphics.lineTo(taille/2,taille);
			graphics.lineTo(0,0);
			graphics.endFill();
			
			deplacer(this,x,y);
			this.rotation = a;
			
			addEventListener(MouseEvent.CLICK,clique);
		}
	
	public override function affiche3D():void {}		

	
	public function select():void{
		graphics.clear();
		graphics.beginFill(0x8888FF,1);
		graphics.moveTo(0,0);
		graphics.lineTo(taille,0);
		graphics.lineTo(taille/2,taille);
		graphics.lineTo(0,0);
		graphics.endFill();
		if(Object(parent).obj_sel != null)
			Object(parent).obj_sel.deselect();
			Object(parent).obj_sel = this;
			selectionne = true;
	}
	
	public function deselect():void{
		graphics.clear();
		graphics.beginFill(0,1);
		graphics.moveTo(0,0);
		graphics.lineTo(taille,0);
		graphics.lineTo(taille/2,taille);
		graphics.lineTo(0,0);
		graphics.endFill();
		Object(parent).obj_sel = null;
			selectionne = false;
	}
	
	public override function getClass():String{
			return "chaise";
	}
	
	private function clique(e:MouseEvent):void{
		if(e.ctrlKey == false){
			if(e.target.selectionne == false){
				e.target.select();
				
			}else{
				e.target.deselect();
				
			}
		}else if(e.ctrlKey == true && e.shiftKey == false){
			if(occupe == false){
				deselect();
				occupe = true;
				Object(parent).moi.x = this.x + 5;
				Object(parent).moi.y = this.y + 5;
				Object(parent).moi.setX2D(this.x);
				Object(parent).moi.setY2D(this.y);
				Object(parent).moi.chaise = this;
				Object(parent).moi.changerStatut("assis");
			}
		}
	}
	
	
	}
} 