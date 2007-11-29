package test
{
	
	// event		
	import flash.events.TextEvent 
	import flash.events.Event;
	import flash.events.KeyboardEvent ;
	import flash.events.MouseEvent;
	import flash.events.*;
    // Composants
	//import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.display.Sprite ;
	import flash.display.StageScaleMode ;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.*;
	
	
	
	
	public class TestImage extends Sprite
	{
				
		private var ImgSource:BitmapData;
		
		 public function TestImage(event:Event) {
		 
			ImgSource=new BitmapData(100,100);
		 
			var imageLoad:Loader = new Loader();
			imageLoad.load(new URLRequest("tnPersonnage1-4.jpg"));
			
			//sert a modifier la taille de l'image
			imageLoad.scaleX=1;
			imageLoad.scaleY=1;
			addChild(imageLoad);
			 
			var loader:Loader = Loader(event.target.loader);
			var image:Bitmap = Bitmap(loader.content);
			
			
			image.x = 100;
			image.y = 100;
			addChild(image); 
			
		}
		
		
/* 		public function afficheTextInput(event:Event):void
		{
		 var tf:TextField = new TextField();
		tf.x = 0; tf.y = 0;
		tf.width = 50; tf.height = 50;
		tf.visible = true;
		tf.htmlText = "<b>Lorem ipsum dolor sit amet.</b>";
		//tf.focusEnabled = true;
		addChild(tf);	

		}
	 */
	
	}
}
