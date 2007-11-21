package pompitheque
{
	import flash.display.Sprite ;

    // Composants Text
	import pompitheque.MessageField; 
    import pompitheque.message.Message;
 	
	public class FileMessage
	{
		
		// ----o Protected Property
        private var __liste_message:Array;
        private var __num_message_max:int;

		// ----o Constructor

		public function FileMessage()
        {
            __liste_message = new Array();
        }
		
		// ----o Public Methods
        public function affiche(p1,p2,p3,p4):Sprite { }//TODO
		
                                
		public function add( message:Message ):void
        {
            __liste_message.push( message );
            if ( __liste_message.length > __num_message_max )
            {
                remove()
            }
        }
		
		public function remove():void 
        {
            __liste_message.pop();    
        }

        /****************** Accesseurs *****************/
        public function setMessageMax( max:int ):void
        {
            __num_message_max = max;
        }

        public function getMessageMax():int
        {
            return __num_message_max;
        }

	}
}


