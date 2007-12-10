package Pompitheque
{
	import flash.display.Sprite ;
    import Pompitheque.Personne;
    import flash.events.*;

	public class Message
	{
		// ----o protected property
		
        private var __text:String = ""; // corps du message
        private var __to:String = "all"; // destinataire
        private var __from:String = ""; // exp�iteur
        private var __wizz:Boolean = false; // le wizz de msn
        private var __client:Personne; // Le client qui permettra d'envoyer
                                       // des messages aux serveurs
		// ----o constructeur
    
        /*
        ce constructeur s'applique dans le cas o l'on souhaite parler �tout
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
        public function getDestinataire():String { return __to; }
        public function getExpediteur():String { return __from; }

        /*
        cette fonction renvoie une chaine de caract�e xml qui sera envoy�au
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

        public function fromXml( stringMessageXml:String ):Message
        {
            var messageXML:XML = new XML( stringMessageXml );
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
