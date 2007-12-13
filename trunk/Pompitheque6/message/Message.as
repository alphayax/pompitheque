package message
{
	import flash.display.Sprite ;
    import flash.events.*;
    import chat.Client;

	public class Message
	{
		// ----o protected property
		
        private var __text:String = ""; // corps du message
        private var __to:String = "all"; // destinataire
        private var __from:String = ""; // expediteur
        private var __wizz:Boolean = false; // le wizz de msn
        private var __client:Client; // Le client qui permettra d'envoyer
                                       // des messages aux serveurs
		// ----o constructeur
    
        /*
        ce constructeur s'applique dans le cas o l'on souhaite parler �tout
        le monde (faire une annonce quoi!). il faudra saisir le message.
        */
		public function Message( client:Client, from:String, dest:String )
		{
            __from = from;
            __to = dest;
            __client = client;
		}

        /*
        Accesseurs
        */
        public function setMessage( text:String ):void { __text = text; }
        public function getMessage():String{ return __text; }
        public function setWizz( wizz:Boolean ):void { __wizz = wizz; }
        public function getWizz():Boolean { return __wizz; }
        public function getDestinataire():String { return __to; }
        public function getExpediteur():String { return __from; }

        /*
        cette fonction renvoie une chaine de caractere xml qui sera envoye
        serveur.
        */
        public function toXml():String
        {
            __text = __text.replace( "&", "&amp;" );
            __text = __text.replace( "<", "&lt;" );
            __text = __text.replace( ">", "&gt;" );
            var xml:String =  "<message from='" + __from + "' to='" + __to + "'>" + __text + "</message>";
            return xml;
        }

        public function fromXml( messageXML:XML ):Message
        {
            __to = messageXML.message.@to; 
            __from = messageXML.message.@from;
            __text = messageXML.message;
            __text = __text.replace( "&amp;", "&" );
            __text = __text.replace(  "&lt;", "<" );
            __text = __text.replace( "&gt;", ">" );
            return this;
 
        }

        public function send():void
        {
           var myserial:String = toXml();
           __client.send( myserial );
        }
    }
}
