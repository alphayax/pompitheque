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

    /*
    Cette classe est tout simplement un TextField surchargé
    */
	public class MessageWidget extends Sprite
	{
		
		// ----o Protected Property
        private var __tf:TextField;
        private var __message:Message;

		// ----o Constructor
		public function MessageWidget()
		{
            // stage.scaleMode = StageScaleMode.NO_SCALE ;

            /******* Champs Texte ************/
            __tf = new TextField() ;
            __tf.type = TextFieldType.INPUT ;		
            __tf.width = 300 ;
            __tf.height = 20 ;
            __tf.border = true ;
            __tf.borderColor = 0xFFFFFF ;
            __tf.textColor = 0xFFFFFF ;
            __tf.defaultTextFormat = new TextFormat("arial", 12)  ;

            // Events
            __tf.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);

            __tf.x = 50 ;
            __tf.y = 220 ;
            addChild(__tf) ;	
            __tf.visible = false; 
		}

        // ----o Private Methods

        /* Methode qui effectue l'animation */
        private function __grandir(e:TimerEvent):void 
        {
            __tf.width = __tf.width + 4;
            __tf.height = __tf.height + 0.2;
        }

        public function setMessage( message:Message ):void
        {
            __message = message;
        }
		
		// ----o Public Methods

        /*
        Methode d'affichage de la zone de saisie.
        */
        public function afficheTextInput():void
        {
            __tf.width = 0;
            __tf.height = 0;
            __tf.visible = true;

            var t:Timer = new Timer(5,100);
            t.addEventListener(TimerEvent.TIMER, __grandir) ;
            t.start();

            stage.focus = __tf
        }
		
        /*
        Méthode lancé lorsque l'on presse la touche ENTRER.
        Cette méthode va renoyer le corps du message
        */
        public function onEnter(e:KeyboardEvent):void
		{
            if (e.charCode == 13){
                //__tf.visible = false;
                __message.setMessage( __tf.text ); // Positionne le corps du message
                __message.send(); // toXMLise et envoie le message
                __tf.text = "";
            }
		}
	}
}


