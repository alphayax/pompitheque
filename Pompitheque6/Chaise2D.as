package
{
	public class Chaise2D extends Acteur
	{
		public var occupe:Boolean = false;
		private var taille:Number = 10;
		private var couleur:Number = 0;
		public function Chaise2D(x:Number,y:Number){ 
			super("chaise",x,y,0);
			graphics.clear();
			creer_losange_plein(this,x,y,taille,taille,couleur);
			deplacer(this,x,y);
		}
	
	public override function affiche3D():void {}		

	
	public function select():void{
		graphics.clear();
		creer_losange_plein(this,x,y,taille,taille,0xDDDDFF);
	}
	
	public function deselect():void{
		graphics.clear();
		creer_losange_plein(this,x,y,taille,taille,couleur);
	}
	
	public override function getClass():String{
			return "chaise";
	}
	
	}
} 