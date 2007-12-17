package 
{
	import flash.display.*;

	public class Pompitheque6 extends Sprite
	{
		public function Pompitheque6()
		{
//			var vue:Vue=new Vue(new Personne("un",120,0,0,"assis","pocahontas"),1);						
			var vue:Vue=new Vue(new Personne("deux",300,0,0,"debout","pocahontas"),1);		
			addChild(vue);
		}
	}
}
