package 
{
	import flash.display.*;

	public class Pompitheque6 extends Sprite
	{
		public function Pompitheque6()
		{
			var vue:Vue=new Vue(new Personne("Bibi",350,0,0,"debout","pocahontas"));						
			addChild(vue);
		}
	}
}
