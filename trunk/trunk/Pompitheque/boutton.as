package Pompitheque
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.*;
	
	public class boutton extends Sprite
	{
		public var h:Number;
		public var w:Number;
		public var co:Array;
		public function boutton(text:String,co:Array,pos:Array,fu:Function) {
			this.h = pos[2];
			this.w = pos[3];
			this.co = co;
			var t:TextField = new TextField();
			t.text = text;
			t.height = pos[2];
			t.width = pos[3];
			t.selectable = false;
			this.graphics.beginFill(co[0],1);
			this.graphics.drawRect(0,0,pos[3],pos[2]);
			this.graphics.endFill();
			this.x = pos[0];
			this.y = pos[1];
			addChild(t);
			
			addEventListener(MouseEvent.MOUSE_OVER,over);
			addEventListener(MouseEvent.MOUSE_OUT,out);
			addEventListener(MouseEvent.CLICK,fu);
		}
		
		public function over(e:MouseEvent){
			var a:Object = e.target.parent.graphics;
			a.clear();
			a.beginFill(e.target.parent.co[1],1);
			a.drawRect(0,0,e.target.parent.w,e.target.parent.h);
			a.endFill();
		}
		
		public function out(e:MouseEvent){
			var a:Object = e.target.parent.graphics;
			a.clear();
			a.beginFill(e.target.parent.co[0],1);
			a.drawRect(0,0,e.target.parent.w,e.target.parent.h);
			a.endFill();
		}
		
	}
}
