package {
	import flash.display.Sprite;

	public class Pompitheque5 extends Sprite
	{
		public function Pompitheque5()
		{
			var vue:Vue=new Vue(new Personne("Bibi",350,0,0,"debout","pocahontas"));						
			addChild(vue);
		}
	}
}
