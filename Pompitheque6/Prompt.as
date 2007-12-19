package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Prompt extends Sprite
	{
		public function Prompt(text:String){
			var t:TextField = new TextField();
			t.width = 400;
			t.height = 400;
			t.multiline = true;
			t.wordWrap = true;
			t.text = text;
			graphics.lineStyle(1,0,1);
			graphics.beginFill(0xFFFFFF,1);
			graphics.drawRect(0,0,400,400);
			graphics.endFill();
			addChild(t);
			this.x = 100;
			this.y = 100;
		}
	}
}