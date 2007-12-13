package panorama
{

    import flash.display.*;
    import flash.geom.*;
    import flash.events.*;
    import flash.net.URLRequest;
    import flash.text.TextField;
    
    public class ChargeurDeBitmap extends Sprite
    {
	// contient le nom des images � charger
	private var tabImage:Array = new Array();
	//private var tabImage:Array = new Array("pano-tamaris.jpg");
	// contient les images charg�es
	private var tabLoader:Array = new Array();
	//tableau angle
	private var tabAngle:Array = new Array();
	// contient toutes les decoupes d'images
	private var tabSmallBitmapData:Array = new Array();
	private var cheminImage:String;
	private var nb:int = 0;
	private var largeur:int = 10;//largeur des petits batonnets
	private var debut:int ;
	private var maxHeight:int ;//hauteur max du panorama


	private var longueur:int ;//nombre de battonets
	//ratio de zoom
	private var ratio:Number ;


    public function ChargeurDeBitmap()
	{
			setMaxHeight(400);
			setNbBattonets(50);
			setZoom(1);
			setLargeur(10);
			setDebut(0);
			setCheminImage("http://localhost/TaWeb/");
			//setCheminImage("http://stev34.free.fr/fac/");
			//addPhoto("panorama_01.gif");
			//addPhoto("panorama_02.gif");
			//addPhoto("panorama_03.gif");
			//addPhoto("panorama_04.gif");
			//addPhoto("Panorama_Haute_Maurienne_01.JPG");
			//addPhoto("Panorama_Haute_Maurienne_02.JPG");
			addPhoto("salle_1.jpg");
			addPhoto("salle_2.jpg");
			//addPhoto("salle_01.gif");
			//addPhoto("salle_02.gif");
			//addPhoto("salle_03.gif");
			//addPhoto("salle_04.gif");
			//addPhoto("pano-tamaris.jpg");

       	  	LoadImage();
		// on g�re maintenant le clavier
       		// la sc�ne doit pouvoir recevoir les �v�nements clavier
       		stage.focus = this;
		// on ajoute un �v�nement de type clavier sur la sc�ne
        	stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			setAngle(29);
	}

	public function LoadImage():void
	{
		for(var i:int = 0;i<tabImage.length;i++)
		{
			tabLoader.push(new Loader());
			tabLoader[i].load(new URLRequest(cheminImage+tabImage[i]));
			tabLoader[i].contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
	}

	public function Affiche():void
	{
		//ici on doit enlever tout les fils ajout� au pr�alable
		for(var k:int = numChildren-1;k>=0;k--)
		{
			removeChildAt(k);
		}
		var z:int = 0;
		var nbb:int = 0;
		var mil:Number=debut+longueur/2;




		for(var j:int = debut;j<mil;j++)
		{
			var b1:Bitmap = new Bitmap(tabSmallBitmapData[j%tabSmallBitmapData.length]);
			if(b1.height>maxHeight){
				b1.height=maxHeight;
			}
	//b1.x=largeur*nbb*ratio;
			b1.x=largeur*mil*ratio-largeur*(mil-nbb)*ratio;

			b1.y=(b1.height-b1.height*ratio*(100-Math.sqrt(z)*2)/100)/2;
			b1.height=b1.height*tabAngle[j%tabSmallBitmapData.length]*ratio*(100-Math.sqrt(z)*2)/100;
			b1.width=b1.width*ratio;
			z++;
			nbb++;
			addChild(b1);
		}
		this.x=(longueur*largeur-longueur*largeur*ratio)/2;
		if(b1.height<maxHeight){
			this.y=-b1.y;
			this.height=b1.height;
		}else{
			this.y=0;
			this.height=b1.height;
		//this.y=-b1.y;
		}


	/*	var b3:Bitmap = new Bitmap(tabSmallBitmapData[0]);
		if(b3.height>maxHeight){
			this.height=maxHeight;
		}else{
			this.height=b3.height;
		}*/


		for(var l:int = mil;l<(debut+longueur);l++)
		{
			var b2:Bitmap = new Bitmap(tabSmallBitmapData[l%tabSmallBitmapData.length]);
			if(b2.height>maxHeight){
				//b2.width=b2.width/(b2.height/maxHeight);
				b2.height=maxHeight;
			}
			//b2.x=largeur*nbb*(b2.height/maxHeight);
			b2.x=largeur*nbb*ratio;
			b2.y=(b2.height-b2.height*ratio*(100-Math.sqrt(z)*2)/100)/2;//on centre la deformation
			b2.height=b2.height*tabAngle[j%tabSmallBitmapData.length]*ratio*(100-Math.sqrt(z)*2)/100;//on deforme reduction de la taille au centre
			//prevoir un arrondi au lieu d'un angle!!!
			b2.width=b2.width*ratio;

			z--;
			nbb++;
			addChild(b2);
		}

	}


	public function decaler(scale:int):void
	{
		debut += scale;//ici c debut et non longueur
		if(debut<0){
		debut+=tabSmallBitmapData.length;
		}
		if(debut>tabSmallBitmapData.length){
		debut-=tabSmallBitmapData.length;
		}

	}

	public function zoom(zo:Number):void
	{
		ratio += zo;
	}

	public function onComplete(evenement:Event):void
	{
		nb++;
		if(nb==tabImage.length)
		{
			onCompleteAll();
		}
	}

	public function onCompleteAll():void
	{
		var hauteur:int = tabLoader[0].height;
		var x:int = 0;
		var y:int = 0;
		var rect:Rectangle = null;

		for(var i:int = 0;i<tabImage.length;i++)
		{
			var bitmap:BitmapData = new BitmapData(tabLoader[i].width, tabLoader[i].height, false, 0xFFFFFF);
			bitmap.draw(tabLoader[i].content, new Matrix(), null, null, null, true);
			while(x<tabLoader[i].width)
			{
				rect= new Rectangle(x,y,largeur,hauteur);
				var tempBitmap:BitmapData=new BitmapData(largeur,hauteur,false,0xFFFFFF);
				tempBitmap.copyPixels(bitmap,rect,new Point(0,0),bitmap,new Point(0,0),true);
				tabSmallBitmapData.push(tempBitmap);
				tabAngle.push(1);
				x = x + largeur;
			}
			x = 0;
		}

		debut = 390;
		Affiche();
	}

	private function onKeyDown(event:KeyboardEvent):void
    {

	    // la valeur absolue du d�calage
            var decal:Number = 1;
	    // la valeur absolue du zoom
            var zo:Number = 0.1;
	    // je r�cup�re ma touche fl�che
            switch(event.keyCode) {
                case(37) : // touche gauche
                   decaler(-decal);
                   break;
                case(38) : // touche haut
                   // yDecal -= decal;
                   // conteneurImage.y -= decal;
                   break;
                case(39) : // touche droite
                   decaler(decal);
                   break;
                case(40) : // touche bas
                   // yDecal += decal;
                   // conteneurImage.y += decal;
                   break;
				case(107) : // touche + //187 marco
                   zoom(zo);
                   break;
                case(109) : // touche - //54 marco
         	   zoom(-zo);
                   break;
		default:
		   //txt.text = "code: " + event.keyCode;

            }
	    Affiche();
	}

		public function setZoom(zo:Number):void
		{//zoom
				ratio=zo;
		}
		public function setNbBattonets(nbr:int):void
		{//nombre de battonets
				longueur=nbr;
		}
		public function setMaxHeight(ht:int):void
		{//hauteur max du panorama
				maxHeight=ht;
		}
		public function setDebut(d:int):void
		{//debut affichage
				debut=d;
		}
		public function setLargeur(l:int):void
		{//largeur des petits batonnets
				largeur=l;
		}
		public function setCheminImage(c:String):void
		{//chemin repertoire image
				cheminImage=c;
		}
		public function addPhoto(p:String):void
		{//ajoute un nom de photo
				tabImage.push(p);
		}
		public function setAngle(battonet:int):void
		{//numero de battonet
			var inttmp:int=battonet-3;
			var tabcoef:Array = new Array(0.95,0.88,0.80,0.75,0.80,0.88,0.95);
			for(var an:int = 0;an<7;an++)
			{
				if(inttmp<0){
					inttmp+=tabSmallBitmapData.length;
				}else{
					if(inttmp>=tabSmallBitmapData.length){
						inttmp-=tabSmallBitmapData.length;
					}
				}
				tabAngle[inttmp]=tabcoef[an];
				inttmp++;
			}
		}


		public function getZoom():Number
		{//zoom
				return ratio;
		}
		public function getNbBattonets():int
		{//nombre de battonets
				return longueur;
		}
		public function getMaxHeight():int
		{//hauteur max du panorama
				return maxHeight;
		}
		public function getDebut():int
		{//debut affichage
				return debut;
		}
		public function getLargeur():int
		{//largeur des petits batonnets
				return largeur;
		}
		public function getCheminImage():String
		{//chemin repertoire image
				return cheminImage;
		}
	
    }
}
