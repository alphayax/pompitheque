package pompitheque
{

import pompitheque.Debug;
    import pompitheque.Vue3D;
    import pompitheque.message.MessageArea;
    import pompitheque.message.Message;
    import pompitheque.message.FileMessage;
    import flash.events.*;
    import flash.utils.*;
    import flash.display.Sprite ;

    
    /********************************************************************************************
    Pour l integration, on doit prevoir pour la classe Personne :
    VARIABLES :
    - private var __login:String;  Login de la personne connect�
    - private var __message_area:MessageArea;  Objet Message qui servira �l'�riture de messages (sic)
    - private var __dico_filesmessages:Dictionary;
    - private var __vue3D:Vue3D; // Vue 3D de la personne
    
    METHODES :
    - onClick(event)
    - addMessage()
    
     Sans oublier les "import"
    *********************************************************************************************/
    
    
    /*
    Cette classe repr�ente une personne connect� Elle poss�e �alement les
    m�hodes pour converser avec le serveur (m�hode send).
    */
	public class Personne extends Sprite// XXX H�itage ???
	{
		// ----o protected property
		
        private var __login:String; // Login de la personne connect�
        private var __message_area:MessageArea; // Objet Message qui servira �                                       // l'�riture de messages (sic!)
        private var __dico_filesmessages:Dictionary;
        private var __vue3D:Vue3D; // Vue 3D de la personne

public var debug:Debug;
		// ----o constructeur
    
        /*
        ce constructeur s'applique dans le cas o l'on souhaite parler �tout
        le monde (faire une annonce quoi!). il faudra saisir le message.
        */
		public function Personne( )
		{
		// TODO
		
/*************DEbut Integration*******************************************************************/		
            var msg:Message = new Message( this, "Moi", "Toi" );
            __message_area = new MessageArea();
            __message_area.setMessage( msg );
            __dico_filesmessages = new Dictionary();
	           /********************************************************************
		   Pour l integration, Vue3D doit prendre en parametre un MessageArea
		   *********************************************************************/
            __vue3D = new Vue3D( __message_area ); 
            addChild( __vue3D );
	    
/***************Fin Integration *******************************************************************/
	    

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
        Cette m�hode est appell�d� que l'on clique sur une personne afin de
        communiqu�avec elle.
        XXX A voir, est-ce le bon ��ement ?
        */
        public function onClick(e:Event):void
        {
            //TODO R�up�ation du login de la personne choisie -A FAIRE)
            var login_personne_choisie:String = "";

            // On instancie un "CoreMessage"
            var msg:Message = new Message( this, __login, login_personne_choisie );
            // On passe le "CoreMessage" au MessageWidget
            __message_area.setMessage( msg );
            // On appelle la m�hode qui va afficher la fenetre de saisie
            __message_area.saisie(); // Saisie et envoie le message
        }

        /******************************************
            M�hode reserv�s aux clients/serveur
        *******************************************/

        /*
        Cette m�hode permet de se connecter au serveur
        */
        public function connect():void{} // TODO a voir pour les param�res

        /*
        Cette m�hode permet d'envoyer un message au serveur
        */
        public function send( message:String ):void { } // TODO
	public function receive():String {var s:String; return s;} // TODO

        /*
        Cette m�hode permet d'�outer les messages envoy� par le serveur
        */
        public function addMessage():void
        {
	//TODO R�up�ation d'un message du destinataire	
	/********Message recu*********/
	var msgRecu:String = receive();
	var message:Message = new Message(this, "", "");
	message = message.fromXml(msgRecu);
            

	// Insertion du message dans la file qui-va-bien
            /****
            Methode haskey puisqu'il faut le faire a la main
            actionscript ne possede pas de methode pour le faire (AS sucks!!)
            ****/
	    if(message.getDestinataire() == "all")
	    {
	    for ( var key:String in __dico_filesmessages )
	    {
	           __dico_filesmessages[key].add( message );
            }
            } 
	   else {
            var isin:Boolean = false;

            for ( var cle:String in __dico_filesmessages )
            {
	       if ( cle == message.getDestinataire() ){ isin = true; }
            }

            if ( isin == false )
            {
	    __dico_filesmessages[message.getDestinataire() ] = new FileMessage();
	    __dico_filesmessages[message.getDestinataire() ].setMessageMax(6);
            }
	       __dico_filesmessages[message.getDestinataire() ].add( message );
}
	    /************* Debug ****************/
	    //debug.text=(__dico_filesmessages[message.getDestinataire()].length).toString;
	   // __dico_filesmessages["Toi"];
	    debug.text= __dico_filesmessages[message.getDestinataire() ].getItem(0).getMessage();
        }
    }
}
