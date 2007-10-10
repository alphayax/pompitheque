package
{
 
	import flash.display.Sprite ;
	import flash.display.StageScaleMode ;
		
	import flash.events.TextEvent 
	import flash.events.Event;
	
	public class TestTextInput extends Sprite
	{
		
		// ----o Protected Property
		
		protected var tf:CustomField ;

		// ----o Constructor
		
		public function TestTextInput()
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE ;
			
			tf = new CustomField() ;
 
			tf.addEventListener(TextEvent.TEXT_INPUT, onInput) ;
			tf.addEventListener(Event.CHANGE, onChange) ;
 
			tf.x = 50 ;
			tf.y = 50 ;
 
			tf.text = "Saisir du texte ici : " ;
 
			addChild(tf) ;	
			
		}
		
		// ----o Public Methods
		
		public function onChange(e:Event):void
		{
			trace(">> " + e.type + " -> " + e.currentTarget) ;
		}
		
		public function onInput(e:TextEvent):void 
		{
			
			trace (">> " + e.type + " -> " + e.currentTarget) ;	
		}
		
		
	}
}
 
import flash.text.TextField ; 
import flash.text.TextFieldType ;
import flash.text.TextFormat ;
 
class CustomField extends TextField 
{
	
	// ----o Constructor
 
	public function CustomField() 
	{
 
		type = TextFieldType.INPUT ;		
		width = 300 ;
		height = 300 ;
		border = true ;
		borderColor = 0xFFFFFF ;
		textColor = 0xFFFFFF ;
		defaultTextFormat = new TextFormat("arial", 12)  ;

}
 
}
