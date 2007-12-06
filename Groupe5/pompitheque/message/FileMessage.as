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
	
		public function afficher(msg:String,pt1:Point,pt2:Point,pt3:Point,pt4:Point):Sprite
        {
		    var _parent:Sprite
			//calcul largeur, hauteur et diagonale du rectangle
			var largeur:Number = Point.distance(pt1,pt2);
			var hauteur:Number = Point.distance(pt1,pt3);
			var diag:Number = Point.distance(point1,point3);
			//creation  du torse du playmobil
			var torse:Shape = new Shape();
			torse.graphics.beginFill(0xFFFFFFF,0.1);
			torse.graphics.moveTo(point1.x,point1.y);
			torse.graphics.lineTo(point2.x,point2.y);
			torse.graphics.lineTo(point3.x,point3.y);
			torse.graphics.lineTo(point4.x,point4.y);
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
			tf.text= msg;
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


