package pompitheque.message
{
    import pompitheque.message.Message;
    import pompitheque.Debug;
    // event		
    import flash.events.TextEvent;
    import flash.events.Event;
    import flash.events.KeyboardEvent ;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    // Composants
    import flash.display.Sprite ;
    import flash.display.StageScaleMode ;

    // Composants Text
    import flash.text.TextField ; 
    import flash.text.TextFieldType ;
    import flash.text.TextFormat ;

    //import necessaires pour filtre bouton 
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.filters.BevelFilter;

    /*
    Cette classe est tout simplement un TextField surcharge    */
	public class MessageWidget extends Sprite
	{
		
		// ----o Protected Property
        private var __tf:TextField;
        private var __message:Message;
        private var __cadre:Shape;
        private var __wizz:SimpleButton;
        private var __wizzText:TextField;

		// ----o Constructor
		public function MessageWidget()
		{
            // stage.scaleMode = StageScaleMode.NO_SCALE ;

            /******* Champs Texte ************/
            __tf = new TextField() ;
            __tf.type = TextFieldType.INPUT ;		
            __tf.width = 400 ;//modifier
            __tf.height = 25 ;

            __tf.textColor = 0x4f575e ;
            __tf.defaultTextFormat = new TextFormat("arial", 12)  ;
            //positionnement du champ de texte 
            __tf.x = 50 ;
            __tf.y = 220 ;
            
            /********* Shape *********/
            __cadre = new Shape();
                // les dessins
            __cadre.graphics.beginFill(0xc2cdd5);
            __cadre.graphics.drawRoundRect(0, 0, 400, 25, 10);
            
            /**** bouton wizz ***********/
            __wizzText = new TextField();
            __wizzText.type = TextFieldType.DYNAMIC;
            __wizzText.mouseEnabled = false;
            __wizzText.text = "wizz";
            __wizzText.textColor = 0xEBF1FA;
            __wizzText.x = 460;
            __wizzText.y = 220;
            __wizzText.width = 25;
            __wizzText.height = 25;
            
            __wizz = new SimpleButton();
            var normal:Shape = new Shape();
            var survol:Shape = new Shape();
            var clic:Shape = new Shape();
                // les dessins
            normal.graphics.beginFill(0x7ABC74);
            normal.graphics.drawRoundRect(460, 220, 25, 25, 10);
            survol.graphics.beginFill(0xFF0000);
            survol.graphics.drawRoundRect(460, 220, 25, 25, 10);
            clic.graphics.beginFill(0x00FF00);
            clic.graphics.drawRoundRect(460, 220, 25, 25, 10);
                // les etats du bouton
            __wizz.upState = normal;
            __wizz.overState = survol;
            __wizz.downState = clic;
            __wizz.hitTestState = normal;
            
            //parametre filtre
            var distance:Number = 2;
            var angle:Number = 45;
            var surbrillance:Number = 0xFFFFFF;
            var alphaSurbrillance:Number = 1.0;
            var ombre:Number = 0x000000;
            var alphaOmbre:Number = .9;
            var flouX:Number = 5;
            var flouY:Number = 5;
            var intensite:Number = 1;
            var qualite:Number = 3;
            var type:String = "inner";
            var masquage:Boolean = false;
            // definition du biseau
            var filtreBiseau:BevelFilter = new BevelFilter(
                distance,angle, surbrillance, alphaSurbrillance, ombre, alphaOmbre,
                flouX, flouY, intensite, qualite, type, masquage);
            
            // application du filtre au bouton
            __wizz.filters = new Array(filtreBiseau);
            __cadre.filters = new Array(filtreBiseau);
            


            /***** Events *************/
                __tf.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);
            __tf.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
            __wizz.addEventListener(MouseEvent.CLICK, onWizz);
            
            /******* ajout a la vue **************/
            addChild(__wizz);
            addChild(__wizzText);
            addChild(__cadre);	
            addChild(__tf) ;
            /**************/

            __tf.visible = false; 
            __wizz.visible = false;
            __wizzText.visible = false; 
		}

        // ----o Private Methods

		/* Methodes qui effectue l'animation */
		private function __ouvrir(e:TimerEvent):void 
		{
	    
		    __cadre.width = __cadre.width + 4;
		    __cadre.height = __cadre.height + 0.25;
	    
            //on rend visible le textfield
		    if(__cadre.width > 390) 
		    {
                __tf.visible = true;
                __wizz.visible = true;
                __wizzText.visible = true;
                    //on donne le focus au textfield
                stage.focus = __tf
		    }
		}
	    
		private function __fermer(e:TimerEvent):void 
		{
		    __tf.visible = false;
		    __wizz.visible = false;
		    __wizzText.visible = false;
		    __cadre.width = __cadre.width - 4;
		    __cadre.height = __cadre.height - 0.25;
	    
            //on cache le textfield
		    if(__cadre.width < 2) 
		    {
                __cadre.visible = false;
		    }	
		}
	

        public function setMessage( message:Message ):void
        {
            __message = message;
        }
	    
	
			    
        public function setMaxChars(nb:int):void
        {
            __tf.maxChars = nb ;
        }
        
        public function onKey( e:KeyboardEvent ):void
        {
            if (__tf.textWidth > __tf.width-15)
            {
                this.setMaxChars(__tf.length);
            }
            else this.setMaxChars(200);
            
        }
        
        public function onWizz( e:Event ):void
        {
            this.alpha=1;
            /*****TO DO*******///TODO
            
        }
        
        public function afficheTextInput():void
        {
            //initialisation du shape
            __cadre.width = 0;
            __cadre.height = 0;
            __cadre.x = 50;
            __cadre.y = 220;
            __cadre.visible = true;
            __tf.text = "";

            //on lance le timer
            var t:Timer = new Timer(5,100);
            t.addEventListener(TimerEvent.TIMER, __ouvrir) ;
            t.start();
        }
        
        /*
        Methode lance lorsque l'on presse la touche ENTRER.
        Cette methode va renoyer le corps du message
        */
        public function onEnter(e:KeyboardEvent):void
        {
            if (e.charCode == 13)//touche entrer
            {
                //__tf.visible = false;
                __message.setMessage( __tf.text ); // Positionne le corps du message
                __message.send(); // toXMLise et envoie le message
                __tf.text = "";
            }
            if (e.charCode == 27) //touche echap
            {
               var t:Timer = new Timer(5,100);
               t.addEventListener(TimerEvent.TIMER, __fermer) ;
               t.start();
               __tf.text = "";	
            }
        }   
    }
}


