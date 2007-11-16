package pompitheque.message
{
	import flash.display.Sprite ;
    import pompitheque.Personne;
    import flash.events.*;

	public class Message
	{
		// ----o protected property
		
        private var __text:String = ""; // corps du message
        private var __to:String = "all"; // destinataire
        private var __from:String = ""; // expéditeur
        private var __wizz:Boolean = false; // le wizz de msn
        private var __client:Personne; // Le client qui permettra d'envoyer
                                       // des messages aux serveurs

		// ----o constructeur
    
        /*
        ce constructeur s'applique dans le cas où l'on souhaite parler à tout
        le monde (faire une annonce quoi!). il faudra saisir le message.
        */
		public function Message( personne:Personne, from:String, to:String )
		{
            // todo
            __from = from;
            __to = to;
            __client = personne;
		}


        /*
        Accesseurs
        */
        public function setMessage( text:String ):void { __text = text; }
        public function getMessage():String{ return __text; }
        public function setWizz( wizz:Boolean ):void { __wizz = wizz; }
        public function getWizz():Boolean { return __wizz; }

        /*
        cette fonction renvoie une chaine de caractère xml qui sera envoyé au
        serveur.
        */
        public function toXml():String
        {
            var xml:String =  "<message from='" + __from + "' to='" + __to + "'>" + __text + "</message>";
            return xml;
        }

        public function send():void
        {
           var myserial:String = toXml();
           __client.debug.text = myserial;
           __client.send( myserial );
        }

		// ----o public methods
        //public function afficher(p1,p2,p3,p4):Sprite
        {
        //todo papilou et nicky
        }
    }
}
