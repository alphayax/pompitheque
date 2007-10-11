package {
	import flash.display.Sprite;
    import flash.text.TextField ;

	public class Chap01_03 extends Sprite
	{
		public function Chap01_03()
		{
            var tf:TextField = new TextField() ;
            tf.x = 10 ;
            tf.y = 10 ;
            tf.width = 120 ;
            tf.height = 20 ;
            tf.text = "Hello World" ;
 
            addChild ( tf ) ;
        }
	}
}
