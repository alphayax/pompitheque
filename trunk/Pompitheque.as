package 
{
	import flash.display.Sprite;
	import Pompitheque.*;

	[SWF(frameRate='30',width='800',height='500',backgroundColor='0xffffff')] 
	public class Pompitheque6 extends Sprite
	{
		public function Pompitheque()
		{
			var vue:Vue=new Vue(new Personne("Bibi",350,0,0,"debout","pocahontas"));						
			addChild(vue);
		}
	}
}
