package generation
{
    // Focus
    //import fl.managers.FocusManager; 
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
	
	public class MessageField extends Sprite
	{
		
		// ----o Protected Property
		
		private var tf:CustomField ;
        private var debug:Debug ;
//        protected var my_focus:FocusManager;

		// ----o Constructor

		public function MessageField()
		{
			
			// stage.scaleMode = StageScaleMode.NO_SCALE ;
			
			tf = new CustomField() ;
			tf.addEventListener(TextEvent.TEXT_INPUT, onInput) ;
			tf.addEventListener(Event.CHANGE, onChange) ;
            tf.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);
			tf.x = 50 ;
			tf.y = 50 ;
			tf.text = "" ;
            addChild(tf) ;	
            tf.visible = false; 

            // Champ de deboggage
            debug = new Debug() ;
            debug.x = 100;
            debug.y = 0;
            debug.text = "Debug";
            addChild( debug );

            // instances du bouton et des dessins
            var monBouton:SimpleButton = new SimpleButton();
            var normal:Shape = new Shape();
            var survol:Shape = new Shape();
            var clic:Shape = new Shape();
            // les dessins
            normal.graphics.beginFill(0x0000FF);
            normal.graphics.drawRoundRect(0, 0, 70, 30, 30);
            survol.graphics.beginFill(0xFF0000);
            survol.graphics.drawRoundRect(0, 0, 70, 30, 30);
            clic.graphics.beginFill(0x00FF00);
            clic.graphics.drawRoundRect(0, 0, 70, 30, 30);
            // les etats du bouton
            monBouton.upState = normal;
            monBouton.overState = survol;
            monBouton.downState = clic;
            monBouton.hitTestState = normal;
            // application du filtre au bouton
            monBouton.addEventListener(MouseEvent.CLICK, afficheTextInput);
            // affichage du bouton
            this.addChild(monBouton);
			
            // Focus
            //my_focus = new FocusManager(this); 
		}
		
		// ----o Public Methods
        public function afficheTextInput(e:Event):void
        {
            tf.visible = true;
            debug.text = "Affichage de TextInput";
            tf.focusEnabled = true;
            //foc.setFocus(tf);
            //trace(">> " + e.type + " -> " + e.currentTarget) ;
        }
                
		public function onChange(e:Event):void
		{
			//trace(">> " + e.type + " -> " + e.currentTarget) ;
		}
		
		public function onInput(e:TextEvent):void 
		{
			
			//trace (">> " + e.type + " -> " + e.currentTarget) ;	
		}
        
        public function onEnter(e:KeyboardEvent):void 
		{
            if (e.charCode == 13){
            tf.visible = false;
			debug.htmlText = tf.text ;
            tf.text = "";
			trace (">> " + e.type + " -> " + e.currentTarget);
            }
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

class Debug extends TextField 
{
	// ----o Constructor
 
	public function Debug() 
	{
 
		type = TextFieldType.INPUT ;		
		width = 300 ;
		height = 20 ;
		border = true ;
		borderColor = 0xFFFFFF ;
		textColor = 0xFFFFFF ;
		defaultTextFormat = new TextFormat("arial", 12)  ;
    }
}


