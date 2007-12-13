package Pompitheque
{
	import flash.display.Sprite ;

    // Composants Text
	//import pompitheque.message.MessageField; 
    import Pompitheque.Message.Message;
 	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.*;
	
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
		
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

		public function __couleur(couleur:String):Object
		{
			var code:Object
			if(couleur=="blanc"){code=0xFFFFFF;}
			if(couleur=="noir"){code=0x000000;}
			if(couleur=="rouge"){code=0xFF0000;}
			if(couleur=="vert"){code=0x00FF00;}
			if(couleur=="bleu"){code=0x0000FF;}
			return code;
		}
		
		//fonction renvoyant une taille de texte suivant la taille du torse
		public function __donneTaille(diag:Number):Number
        {
			var taille:Number;
			if(diag>300){ taille=14;}
			if(diag>200 && diag<300){taille=12;}
			if(diag<200 && diag>150){taille=10;}
			if(diag<150 && diag>100){taille=8;}
			if(diag<100){taille=6;}
			return taille;
		}
	
        // Fonction d'affichage d'une file de message.
        // Cette fonction prend un tableau de 4 points
		public function afficher(ListePoints:Array):Sprite
        {
            // Extraction des points
            var pt1:Point = ListePoints[0];
            var pt2:Point = ListePoints[1];
            var pt3:Point = ListePoints[2];
            var pt4:Point = ListePoints[3];
		    var _parent:Sprite
			//calcul largeur, hauteur et diagonale du rectangle
			var largeur:Number = Point.distance(pt1,pt2);
			var hauteur:Number = Point.distance(pt1,pt3);
			var diag:Number = Point.distance(pt1,pt3);
			//creation  du torse du playmobil
			var torse:Shape = new Shape();
			torse.graphics.beginFill(0xFFFFFFF,0.1);
			torse.graphics.moveTo(pt1.x,pt1.y);
			torse.graphics.lineTo(pt2.x,pt2.y);
			torse.graphics.lineTo(pt3.x,pt3.y);
			torse.graphics.lineTo(pt4.x,pt4.y);
			torse.graphics.endFill();
			_parent.addChild(torse);
			//creation de la textfield
			var tf:TextField = new TextField();
			//Les coordonnées du textfield sont les memes que l'imager		
			tf.x = torse.x; tf.y = torse.y;
			tf.width = largeur; tf.height =hauteur;
			//definition du texte
			tf.multiline = true;
			tf.wordWrap = true;	
			//definition du format
			var format:TextFormat = new TextFormat();
			var taille:Number = __donneTaille(diag);
			format.font = "Verdana";
			format.color = 0x000000;
			format.size = taille;
			//applique le format
			tf.defaultTextFormat = format;
			//affiche le texte
            var all_messages:String;
            for (var msg:String  in __liste_message){
                all_messages += msg + "\n";
            }
			tf.text= all_messages;
			_parent.addChild(tf);
			return _parent;
		}
                                
		public function add( message:Message ):void
        {
            __liste_message.push( message );
            if ( __liste_message.length > __num_message_max )
            {
                this.remove();
            }
        }
		
		public function remove():void {__liste_message.pop();}

        /****************** Accesseurs *****************/
        public function setMessageMax( max:int ):void {__num_message_max = max;}

        public function getMessageMax():int {return __num_message_max;}
	    
        public function getItem(i:int):Message
        {
            if ( __liste_message.length > i && i>=0 ) {return __liste_message[i];}
            else return null;
        }
    }
}


