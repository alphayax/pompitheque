package pompitheque.message
{
	import flash.display.Sprite ;

    // Composants Text
	//import pompitheque.message.MessageField; 
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
       // public function affiche(p1,p2,p3,p4):void//Sprite 
	//{ }//TODO
		
                                
		public function add( message:Message ):void
        {
            __liste_message.push( message );
            if ( __liste_message.length > __num_message_max )
            {
                this.remove();
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
	    
	public function getItem(i:int):Message
	{
	    if ( __liste_message.length > i && i>=0 )
	    {
	       return __liste_message[i];
	    }
	    else return null;
	}

    }
}


