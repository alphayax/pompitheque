package generation
{
         //Debug
         import generation.Debug;
        // event		
	import flash.events.TextEvent 
	import flash.events.Event;
	import flash.events.KeyboardEvent ;
        import flash.events.MouseEvent;
        import flash.events.*;
		import flash.events.TimerEvent;
			import flash.utils.Timer;
        // Composants
        import flash.display.SimpleButton;
        import flash.display.Shape;
	import flash.display.Sprite ;
	import flash.display.StageScaleMode ;

         // Composants Text
        import flash.text.TextField ; 
        import flash.text.TextFieldType ;
        import flash.text.TextFormat ;
 	
	public class MessageField extends Sprite
	{
		
		// ----o Protected Property
		
                private var tf:TextField ;
                private var debug:Debug ;
				
                //        protected var my_focus:FocusManager;

		// ----o Constructor

		public function MessageField()
		{
			
			// stage.scaleMode = StageScaleMode.NO_SCALE ;
			
            /******* Champs Texte ************/
		tf = new TextField() ;
		tf.type = TextFieldType.INPUT ;		
		tf.width = 300 ;
		tf.height = 20 ;
		tf.border = true ;
		tf.borderColor = 0xFFFFFF ;
		tf.textColor = 0xFFFFFF ;
		tf.defaultTextFormat = new TextFormat("arial", 12)  ;

            // Events
            tf.addEventListener(TextEvent.TEXT_INPUT, onInput) ;
            tf.addEventListener(Event.CHANGE, onChange) ;
            tf.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);
            //tf.addEventListener(MouseEvent.MOUSE_DOWN, selectionne);
            //tf.addEventListener(MouseEvent.MOUSE_UP, place);
            
            tf.x = 50 ;
            tf.y = 220 ;
	    //tf.text = "" ;
            addChild(tf) ;	
            tf.visible = false; 

            /********* Champ de deboggage *************/
            debug = new Debug() ;
            debug.x = 100;
            debug.y = 0;
            debug.text = "Debug";
            addChild( debug );

            /************** Bouton ********************/
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
			
            /***************** Focus  ********************/
            //my_focus = new FocusManager(this); 
		}
		
		// ----o Public Methods
        public function afficheTextInput(e:Event):void
        {
			    tf.width = 0;
				tf.height = 0;
            tf.visible = true;
	    
/*
	    for(var i:int=0;i<200;i++) {
		tf.width++; 
	    }
*/	  		 var t:Timer = new Timer(5,100);
			t.addEventListener(TimerEvent.TIMER, grandir) ;
			t.start();

  
            debug.text = "Affichage de TextInput";
            stage.focus = tf
        }
		
		  public function grandir(e:TimerEvent):void 
		  {
		  tf.width = tf.width + 4;
		  tf.height = tf.height + 0.2;
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
            //tf.visible = false;
			debug.htmlText = tf.text ;
            tf.text = "";
			trace (">> " + e.type + " -> " + e.currentTarget);
            }
		}
		


	}
}


