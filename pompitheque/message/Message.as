package message
{
	import flash.display.Sprite ;

	public class Message
	{
		// ----o protected property
		
        private var __text:string = ""; // corps du message
        private var __to:string = "all"; // destinataire
        private var __from:string = ""; // expéditeur
        private var __wizz:Boolean = false; // le wizz de msn

		// ----o constructeur
    
        /*
        ce constructeur s'applique dans le cas où l'on souhaite parler à tout
        le monde (faire une annonce quoi!). il faudra saisir le message.
        */
		public function message( from:string )
		{
            // todo
            __from = from;
		}

        /*
        ce constructeur s'applique si l'on souhaite parler à une *seule*
        personne en particulier. 
        */
        public function message( from:string, to:string )
        {
            // todo
            __from = from;
            __to = to;
        }

        /*
        Accesseurs
        */
        public function setmessage( text:string ):void { __text = text; }
        public function getmessage():void{ return __text; }
        public function setwizz( wizz:Boolean ):void { __wizz = wizz; }
        public function getwizz():Boolean { return __wizz; }

        /*
        cette fonction renvoie une chaine de caractère xml qui sera envoyé au
        serveur.
        */
        public function toxml():string
        {
        //todo
        }

		// ----o public methods
        public function afficher(p1,p2,p3,p4):sprite
        {
        //todo papilou et nicky
        }
    }
}
