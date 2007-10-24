package test
{
	// event		
	import flash.events.TextEvent 
	import flash.events.Event;
	import flash.events.KeyboardEvent ;
	import flash.events.MouseEvent;
	import flash.events.*;
    // Composants
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.display.Sprite ;
	import flash.display.StageScaleMode ;
	 import flash.display.Bitmap;
	 import flash.display.BitmapData;
	
	public class TestImage extends Sprite
	{
		private var ImgSource:BitmapData;
		
		 public function TestImage() {
		 
			var image:Loader = new Loader();
			image.load(new URLRequest("~/images/tnPersonnage1-4.jpg"));
			
			mage.x = 100;
			image.y = 200;
			addChild(image);
			
		}
	
	
	}
}
