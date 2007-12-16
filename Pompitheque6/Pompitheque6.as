package 
{
	import flash.display.*;

	public class Pompitheque6 extends Sprite
	{
		public function Pompitheque6()
		{
			var vue:Vue=new Vue(new Personne("prop",400,0,0,"debout","pocahontas"),1);						
			addChild(vue);
		}
	}
}
