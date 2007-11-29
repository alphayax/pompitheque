package {
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.ui.Mouse;
    import flash.events.MouseEvent;
    import flash.display.StageScaleMode;

    // taille du fichier Flash pour le compilateur FLEX 2
    [SWF(frameRate='30',width='320',height='240',backgroundColor='0x869CA7')]

    public class zoomPicture extends Sprite
    {
        // le sprite qui contient le masque de découpe
        private var maskSprite:Sprite;

        // le container qui contient la petite image
        private var containerSmall:Sprite;

        // le container qui contient la grande image
        // qui est partiellement caché par le masque 'maskSprite'
        private var containerBig:Sprite;

        // le 'loader' qui va contenir la grande image
        private var pictLdr:Loader;

        public function zoomPicture()
        {
            // pas de changement de taille du fichier, sinon le masque ne fonctionne pas
            stage.scaleMode = StageScaleMode.NO_SCALE;
            // le"container" de la petite image
            containerSmall = new Sprite();
            // le "container" de la grande image
            containerBig = new Sprite();
            // on ajoute le petit et le grand container à la liste d'affichage
            // petit derrière le grand
            this.addChild(containerSmall);
            this.addChild(containerBig);
            // on définit un objet Loader
            pictLdr = new Loader();
            // l'adresse URL de l'image
            // cette image est de grande taille
            var pictURL:String = "playmobile.jpg";
            // on récupère le path complet du movie Flash, on enlève le nom du fichier Flash
            // et on ajoute le nom de l'image
            pictURL = (root.loaderInfo.url.substring(0, (root.loaderInfo.url).lastIndexOf("/") + 1 ) ) + pictURL
            // on fait une requête pour l'URL
            var pictURLReq:URLRequest = new URLRequest(pictURL);
            // on charge l'image concernée
            // équivalent à pictLdr.load(new URLRequest("nounours.png"));
            pictLdr.load(pictURLReq);
            // on définit l'évènement que l'on va attacher à pictLdr
            pictLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
        }

        private function imgLoaded(event:Event):void {
            // maintenant que l'image est chargée dans pictr
            // on l'ajoute à container qui se trouve dans la liste d'affichage
            var smallPicture:Bitmap = Bitmap(pictLdr.content);
            // on récupère le BitmapData de cette image
            var smallData:BitmapData = smallPicture.bitmapData;
            // on met cette image en cache
            smallPicture.cacheAsBitmap = true;
            // on ajoute cette image au sprite
            containerSmall.addChild(smallPicture);
            // on récupère le bitmap
            // que l'on met tels quel dans la grande image
            var bigData:BitmapData = new BitmapData(smallData.width, smallData.height);
            bigData.copyPixels(smallData, new Rectangle(0, 0, smallData.width, smallData.height), new Point(0, 0));
            var bigPicture:Bitmap = new Bitmap(bigData);
            // on met en cache la grande image
            bigPicture.cacheAsBitmap = true;
            // on ajoute cette image au sprite
            containerBig.addChild(bigPicture);
            // l'image de base fait 1000x750 pixels
            // on l'ajuste à la taille de l'affichage 320x240 pixels
            // soit une réduction de 1/3.125
            containerSmall.scaleX = .320;
            containerSmall.scaleY = .320;
            // on fait la création du masque vectoriel dans un sprite
            // un rectangle de 120 pixels de large qui va faire voir la grande image
            maskSprite = new Sprite();
            maskSprite.graphics.lineStyle(0, 0xFF0000, 1.0, true, "none", "ROUND", "ROUND", 3);
            maskSprite.graphics.beginFill(0xFFFFFF);
            maskSprite.graphics.drawRoundRect(-40, 0, 120, 80, 40, 40);
            // on remplit la forme créée
            maskSprite.graphics.endFill();
            // on met en cache l'image du masque
            maskSprite.cacheAsBitmap = true;
            // on ajoute le masque à la liste d'affichage
            addChild(maskSprite);
            // on assigne le masque à la grande image masquée
            bigPicture.mask = maskSprite;
            // on ajoute un évènement sur le stage
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
            // on cache la souris
            //Mouse.hide();
        }

         private function mouseMove(event:Event) : void {
            // on assigne le déplacement du masque à celui de la souris
            maskSprite.x = mouseX;
            maskSprite.y = mouseY;

            // on décale la grande image par rapport à la position de la souris
            // échelle entre grande et petite image = 3.125
            // on a un rapport de 3.125 - 1
            containerBig.x = - mouseX * 2.125;
            containerBig.y = - mouseY * 2.125;
        }

        private function mouseWheel(event:Event) : void {
            containerBig.x = - mouseX * .125;
            containerBig.y = - mouseY * .125;
        }
    }
}