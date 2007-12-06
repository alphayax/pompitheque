package pompitheque
{

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.net.*;
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
		

        /************* Variables privé pour les messages **********/
        //--------------     integration groupe5    ---------------
        private var __message_area:MessageArea; // Pour la saisie du message
        private var __dico_filesmessages:Dictionary; 
        /***************** Fin intégration GROUPE5 ****************/


		
		//stature de l'avatar vue ('assis' ou 'debout')
		private var statureAvatar:String;	
		
        /************************************************
        *           CONSTRUCTEUR PERSONNE               *
        ************************************************/
		public function Personne(nom:String,varX:Number,varY:Number,
          angleAbsolu:Number,statureAvatar:String,typeAvatar:String)
        {
			super(nom,varX,varY,angleAbsolu);
			this.typeAvatar=typeAvatar;	
			this.statureAvatar=statureAvatar;
            __message_area = new MessageArea();
            __dico_filesmessages = new Dictionary();
			/**trace(varX+' personne  '+varY) **/
		}
		
		public override function affiche3D():void
		{
			//trace("nom "+super.nom+"   angleVue :"+this.angleVue);
			var angleVueArrondie:Number = 0;
			if (super.angleVue%10 < 5)
				angleVueArrondie = super.angleVue - super.angleVue%10;
			else angleVueArrondie = super.angleVue + (10 - super.angleVue%10);
			angleVueArrondie = Math.abs(angleVueArrondie)%360;
			trace(this.parent);
			var img:Loader = new Loader();
				img.y = -hauteur;
				img.x = -largeur/2; 
			if(this.numChildren == 0){
			
				img.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,angleVueArrondie.toString())));
				/*var imgTemp:BitmapData;
				imgTemp = new BitmapData(this.largeur, this.hauteur, false, 0xFFFFFF)
				    	imgTemp.draw(img, null, null, null, null, false);
				    	var tep:Bitmap = new Bitmap(imgTemp);	
				    	tep.y = -hauteur;
				tep.x = -largeur/2;  */
				addChild(img);					
			}
			/** CODE QUI CHANGE L'ANGLE VUE QUAND LE PROPRIO TOURNE
			if (tempAngle != angleVueArrondie){
				//trace("angle vue -->"+super.angleVue.toString());
				//trace("angle arrondie -->"+angleVueArrondie);			
				//var img:Loader = Avatar.getImage(typeAvatar,statureAvatar,angleVueArrondie.toString());
				//var img:Loader = new Loader();
				var anglePrec:Number = 0;
				var angleSuiv:Number = 0;
				
				var img:Loader = new Loader();
				img.y = -hauteur;
				img.x = -largeur/2; 
				imgPrec.y = -hauteur;
				imgPrec.x = -largeur/2; 
				imgSuiv.y = -hauteur;
				imgSuiv.x = -largeur/2;
				
				//Ajustement des angles
				
				
				if(this.numChildren == 0){
					if(angleVueArrondie == 0 || angleVueArrondie == 360){
					anglePrec = 350;
					angleSuiv = 10;	
					}else{
					anglePrec = angleVueArrondie-10;
					angleSuiv = angleVueArrondie+10;	
					}
					img.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,angleVueArrondie.toString())));
					imgPrec.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,(anglePrec).toString())));
					imgSuiv.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,(angleSuiv).toString())));
					 
					addChild(img);					
				}else{
					trace("Angle Arrondie :"+angleVueArrondie);
					
					if(tempAngle < angleVueArrondie){
						//(Loader)(getChildAt(0)) = imgPrec;
						if(angleVueArrondie == 0 || angleVueArrondie == 360){
					anglePrec = 350;
					angleSuiv = 10;	
				}else{
					anglePrec = angleVueArrondie-10;
					angleSuiv = angleVueArrondie+10;	
				}
						this.addChild(imgPrec);
						img.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,(anglePrec).toString())));
						imgPrec = img;
						img.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,(angleSuiv).toString())));
					 	imgSuiv = img;
						this.removeChildAt(0);
					}else{
						if(angleVueArrondie == 0 || angleVueArrondie == 360){
					anglePrec = 350;
					angleSuiv = 10;	
				}else{
					anglePrec = angleVueArrondie+10;
					angleSuiv = angleVueArrondie-10;	
				}
						this.addChild(imgSuiv);
						img.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,(anglePrec).toString())));
						imgPrec = img;
						img.load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,(angleSuiv).toString())));
					 	imgSuiv = img;
						
						this.removeChildAt(0);
						//(Loader)(getChildAt(0)) = imgSuiv;
					}
					
					
					//(Loader)(getChildAt(0)).load(new URLRequest(Avatar.getImage(typeAvatar,statureAvatar,angleVueArrondie.toString())));
				}
				
				//img.y = -hauteur;
				//img.x = -largeur/2; 
				
				//addChild(img);
				
				
				//trace(img);
				//trace("img :"+typeAvatar+" stature :"+statureAvatar+" angle :"+angleVueArrondie.toString());
				
 				//this.getChildAt(0).y = -hauteur;
				//this.getChildAt(0).x = -largeur/2; 
				tempAngle = angleVueArrondie;				
			}
			**/
			
			x = super.x3D;
			y = super.y3D;
		}

		//renvoie l'adresse de l'image correspondant a la vue de la personne
		public function getImage():String
		{
			return "image";
		}
		
		//renvoie les 4 coordonnÃ©es correspondant a la zone texte de la photo image
		public function getZoneTexte():Array
		{
			//possibilitÃ© de les stockÃ© ds un fichier XML
			//->
			//on recupere les coordonnÃ©es correspondant ds le fichier xml
			//on applique la reduction de taille dut la perspective pour coller a la photo
			return new Array();
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
		
		/**DEBUT INTEGRATION GROUPE5**/
		//fonction appeler sur le proprio lorsqu'on clique sur une personne
		public function saisieMessage(destinataire:String):void
		{
            // On instancie un "CoreMessage"
            var msg:Message = new Message( __client, this.getName(), destinataire );
            // On passe le "CoreMessage" au MessageWidget
            __message_area.setMessage( msg );
            // On appelle la  methode qui va afficher la fenetre de saisie
            __message_area.saisie(); // Saisie et envoie le message
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
        }
        /**************FIN INTEGRATION GROUPE5*****************/
	}
}
