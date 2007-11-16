package pompitheque
{

import pompitheque.Debug;
    import pompitheque.Vue3D;
    import pompitheque.message.MessageArea;
    import pompitheque.message.Message;
    import flash.events.*;
    import flash.display.Sprite ;

    /*
    Cette classe repr�sente une personne connect�. Elle poss�de �galement les
    m�thodes pour converser avec le serveur (m�thode send).
    */
	public class Personne extends Sprite// XXX H�ritage ???
	{
		// ----o protected property
		
        private var __login:String; // Login de la personne connect�e
        private var __message_area:MessageArea; // Objet Message qui servira �
                                       // l'�criture de messages (sic!)
        private var __vue3D:Vue3D; // Vue 3D de la personne

public var debug:Debug;
		// ----o constructeur
    
        /*
        ce constructeur s'applique dans le cas o� l'on souhaite parler � tout
        le monde (faire une annonce quoi!). il faudra saisir le message.
        */
		public function Personne( )
		{
            // TODO
            var msg:Message = new Message( this, "Moi", "Toi" );
            __message_area = new MessageArea();
            __message_area.setMessage( msg );
            __vue3D = new Vue3D( __message_area );
            addChild( __vue3D );

/********* Champ de deboggage *************/
debug = new Debug() ;
debug.x = 100;
debug.y = 0;
debug.text = "Debug";
addChild( debug);

		}
        
        /******************************************
                        Evenements
        *******************************************/
        /*
        Cette m�thode est appell� d�s que l'on clique sur une personne afin de
        communiqu� avec elle.
        XXX A voir, est-ce le bon �v�nement ?
        */
        public function onClick(e:Event):void
        {
            //TODO R�cup�ration du login de la personne choisie -A FAIRE)
            var login_personne_choisie:String = "";

            // On instancie un "CoreMessage"
            var msg:Message = new Message( this, __login, login_personne_choisie );
            // On passe le "CoreMessage" au MessageWidget
            __message_area.setMessage( msg );
            // On appelle la m�thode qui va afficher la fenetre de saisie
            __message_area.saisie(); // Saisie et envoie le message
        }

        /******************************************
            M�thode reserv�es aux clients/serveur
        *******************************************/

        /*
        Cette m�thode permet de se connecter au serveur
        */
        public function connect():void{} // TODO a voir pour les param�tres

        /*
        Cette m�thode permet d'envoyer un message au serveur
        */
        public function send( message:String ):void { } // TODO

        /*
        Cette m�thode permet d'�couter les messages envoy�s par le serveur
        */
        public function listen():void{}// TODO
    }
}
