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
	import flash.display.Loader;
	import flash.net.*;
	
	public class TestImage extends Sprite
	{
		private var ImgSource:BitmapData;
		
		 public function TestImage() {
		 
			ImgSource=new BitmapData(100,100);
		 
			var imageLoad:Loader = new Loader();
			imageLoad.load(new URLRequest("tnPersonnage1-4.jpg"));
			
			imageLoad.scaleX=2;
			imageLoad.scaleY=2;
			addChild(imageLoad);
			var image:Bitmap = Bitmap(imageLoad.content);
			
			
			image.x = 100;
			image.y = 100;
			addChild(image);
			
		}
	
	
	}
}
