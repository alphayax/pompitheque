package Pompitheque
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
//	import message.*;
	import pompitheque.message.MessageArea;
    import pompitheque.message.Message;
    import pompitheque.message.FileMessage;

	public class Personne extends Acteur
	{
		//taille d'origine
		var largeur:Number = 235;
		var hauteur:Number = 375;
		var tempAngle:Number = -1;
		//var imgPrec:Loader = new Loader();
		//var imgSuiv:Loader = new Loader();
		
		//type de l'avatar vue ('pocahontas'...)
		private var typeAvatar:String;
		
		
        /************* Variables prive pour les messages **********/
        //--------------     integration groupe5    ---------------
        private var __message_area:MessageArea; // Pour la saisie du message
        private var __dico_filesmessages:Dictionary; 
        /***************** Fin intégration GROUPE5 ****************/


		
		//stature de l'avatar vue ('assis' ou 'debout')
		private var statureAvatar:String;	
		
        /************************************************
        *           CONSTRUCTEUR PERSONNE               *
        ************************************************/
		public function Personne(nom:String,varX:Number,varY:Number,angleAbsolu:Number,statureAvatar:String,typeAvatar:String){
			super(nom,varX,varY,angleAbsolu);
			this.typeAvatar=typeAvatar;	
			this.statureAvatar=statureAvatar;
            __message_area = new MessageArea();
            __dico_filesmessages = new Dictionary();
			/**trace(varX+' personne  '+varY) **/
		}
		
		public override function affiche3D():void
		{
			graphics.clear();
			//trace("nom "+super.nom+"   angleVue :"+this.angleVue);
			var angleVueArrondie:Number = 0;
			if (super.angleVue%10 < 5)
				angleVueArrondie = super.angleVue - super.angleVue%10;
			else angleVueArrondie = super.angleVue + (10 - super.angleVue%10);
			angleVueArrondie = Math.abs(angleVueArrondie)%360;
			
			var img:Loader = new Loader();
				img.y = -hauteur;
				img.x = -largeur/2; 
			if(this.numChildren == 0){			
				img.load(new URLRequest(this.getImage()));
				addChild(img);					
			}
			x = super.x3D;
			y = super.y3D;
		}
		
		
		
		
		//renvoie l'adresse de l'image correspondant a la vue de la personne
		public function getImage():String
		{
			return Avatar.getImage(typeAvatar,statureAvatar,angleVueArrondie.toString());
		}
		
		//renvoie les 4 coordonnÃ©es correspondant a la zone texte de la photo image
		public function getZoneTexte():Array
		{
			return Avatar.getZoneTexte(typeAvatar,statureAvatar,angleVueArrondie.toString());
		}		
		
		public function setStatureAvatar(statureAvatar:String):void {
			this.statureAvatar=statureAvatar;
		}
		
		public override function getClass():String{
			return "Personne";
		}
				public function getType():String {
			return typeAvatar;
		}
		public function getStature():String {
			return statureAvatar;
		}
		
		/********************DEBUT INTEGRATION GROUPE5**********************/
		//fonction appeler sur le proprio lorsqu'on clique sur une personne
		public function saisieMessage(destinataire:String, vue3D:Vue3D):void
		{
            // On instancie un "CoreMessage"
            var msg:Message = new Message( vue3D.client, this.getName(), destinataire );
            // On passe le "CoreMessage" au MessageWidget
            __message_area.setMessage( msg );
            // On appelle la  methode qui va afficher la fenetre de saisie
            __message_area.saisie( vue3D ); // Saisie et envoie le message
		}

		public function receiveMessage():void
        {
            //TODO Recuperation d'un message du destinataire	
            /********Message recu*********/
            var msgRecu:String = receive();
            // On créé un message vide qui sera remplie par fromxml
            var message:Message = new Message(this, "", "");
            message = message.fromXml(msgRecu);
            
            // Insertion du message dans la file qui-va-bien
            /****
            Methode haskey puisqu'il faut le faire a la main
            actionscript ne possede pas de methode pour le faire (AS sucks!!)
            ****/
            var isin:Boolean = false;
            for ( var cle:String in __dico_filesmessages )
            {
               if ( cle == message.getExpediteur() ){ isin = true; }
            }

            if ( isin == false )
            {
                __dico_filesmessages[message.getExpediteur()] = new FileMessage();
                __dico_filesmessages[message.getExpediteur()].setMessageMax(6);
            }
           __dico_filesmessages[message.getExpediteur()].add( message );
           // FIXME !!!
           addChild(__dico_filesmessages[message.getExpediteur()].afficher(vue3D.getPoint()));
        }
        /**************FIN INTEGRATION GROUPE5*****************/
	}
}
