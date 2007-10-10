package{
	import flash.display.Sprite;
	public class test extends Sprite {
		public function test(){
			graphics.lineStyle(1, 0, 1);
			for (var i:int=0; i<100; i++){
				graphics.lineTo(Math.random()*400, Math.random()*400);
			}
		}
	}
}
