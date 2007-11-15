package message
{
    // event		
    import flash.events.TextEvent 
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

    /* Cette classe est tout simplement un TextField surchargé */
	public class MessageWidget extends Sprite
	{
		
		// ----o Protected Property
        public var tf:TextField;
        private var __message:Message;
        private var __result:String = "";

		// ----o Constructor
		public function MessageWidget( message:Message )
		{
            // stage.scaleMode = StageScaleMode.NO_SCALE ;
                
            /******* Objet Message ***********/
            // XXX OU METTONS-NOUS LE MESSAGE ????
            __message = message;

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
            tf.addEventListener(KeyboardEvent.KEY_DOWN, onEnter);

            tf.x = 50 ;
            tf.y = 220 ;
            addChild(tf) ;	
            tf.visible = false; 
		}

        // ----o Private Methods

        /* Methode qui effectue l'animation */
        private function __grandir(e:TimerEvent):void 
        {
            tf.width = tf.width + 4;
            tf.height = tf.height + 0.2;
        }

		
		// ----o Public Methods

        /*
        Methode d'affichage de la zone de saisie.
        C'est une methode qui sera appelé par un évènement.
        (MouseClick sur la personne)
        */
        public function afficheTextInput(e:Event):void
        {
            __result = "";
            tf.width = 0;
            tf.height = 0;
            tf.visible = true;

            var t:Timer = new Timer(5,100);
            t.addEventListener(TimerEvent.TIMER, __grandir) ;
            t.start();

            stage.focus = tf
        }
		
        /*
        Méthode lancé lorsque l'on presse la touche ENTRER.
        Cette méthode va renoyer le corps du message
        */
        public function onEnter(e:KeyboardEvent):void
		{
            if (e.charCode == 13){
                //tf.visible = false;
                __message.setMessage( tf.text );
                tf.text = "";
            }
		}
	}
}


