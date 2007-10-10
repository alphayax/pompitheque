package {
	import flash.display.Sprite;

	public class Chap01_03 extends Sprite
	{
		public function Chap01_03()
		{
            graphics.lineStyle(1, 0, 1);
            for(var i:int=0;i<100;i++) {
                graphics.lineTo(Math.random() * 400, Math.random() * 400);
            }
		}
	}
}
