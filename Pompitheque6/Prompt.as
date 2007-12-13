package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Prompt extends Sprite
	{
		public function Prompt(text:String){
			var t:TextField = new TextField();
			t.width = 100;
			t.height = 20;
			t.text = text;
			graphics.beginFill(0xFFFFFF,1);
			graphics.drawRect(0,0,100,20);
			graphics.endFill();
			addChild(t);
			this.x = 100;
			this.y = 100;
		}
	}
}