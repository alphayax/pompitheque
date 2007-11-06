package {
	import flash.display.Sprite;

	public class Pompitheque extends Sprite
	{
		public function Pompitheque()
		{			
			var vue:Vue=new Vue("planXML");						
			addChild(vue);
		}
	}
}
