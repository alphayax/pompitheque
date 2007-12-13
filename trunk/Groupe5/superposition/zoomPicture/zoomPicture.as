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
    import flash.events.KeyboardEvent;
    import flash.display.StageScaleMode;

    // taille du fichier Flash pour le compilateur FLEX 2
    [SWF(frameRate='30',width='320',height='240',backgroundColor='0x4682b4')]

    public class zoomPicture extends Sprite
    {
        // le sprite qui contient le masque de decoupe
        private var maskSprite:Sprite;
        // le container qui contient la petite image
        private var containerSmall:Sprite;
        // le container qui contient la grande image
        // qui est partiellement cache par le masque 'maskSprite'
        private var containerBig:Sprite;
        // le 'loader' qui va contenir la grande image
        private var pictLdr:Loader;

        // la variable qui precise l'etat de la souris "hidden ou non"
        private var mouseHideState:Boolean = false;
        // l'echelle du zoom par rapport a l'image reduite
        private var zoomScale:Number = 2.125;


        public function zoomPicture() {
            // pas de changement de taille du fichier, sinon le masque ne fonctionne pas
            stage.scaleMode = StageScaleMode.NO_SCALE;
            // le "container" de la petite image
            containerSmall = new Sprite();
            // le "container" de la grande image
            containerBig = new Sprite();
            // on ajoute le petit et le grand container a la liste d'affichage
            // petit derriere le grand
            this.addChild(containerSmall);
            this.addChild(containerBig);
            // on definit un objet Loader
            pictLdr = new Loader();
            // l'adresse URL de l'image
            // cette image est de grande taille
            var pictURL:String = "0.gif";
            // on recupere le chemin complet du movie Flash, on enleve le nom du fichier Flash
            // et on ajoute le nom de l'image
            pictURL = (root.loaderInfo.url.substring(0, (root.loaderInfo.url).lastIndexOf("/") + 1 ) ) + pictURL
            // on fait une requete pour l'URL
            var pictURLReq:URLRequest = new URLRequest(pictURL);
            // on charge l'image concernee
            // equivalent a pictLdr.load(new URLRequest("playmobile.png"));
            pictLdr.load(pictURLReq);
            // on definit l'evenement que l'on va attacher a pictLdr
            pictLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
        }

        private function imgLoaded(event:Event):void {
            // maintenant que l'image est chargee dans pictr
            // on l'ajoute a container qui se trouve dans la liste d'affichage
            var smallPicture:Bitmap = Bitmap(pictLdr.content);
            // on recupere le BitmapData de cette image
            var smallData:BitmapData = smallPicture.bitmapData;
            // on met cette image en cache
            smallPicture.cacheAsBitmap = true;
            // on ajoute cette image au sprite
            containerSmall.addChild(smallPicture);
            // on recupere le bitmap
            // que l'on met tel quel dans la grande image
            var bigData:BitmapData = new BitmapData(smallData.width, smallData.height);
            bigData.copyPixels(smallData, new Rectangle(0, 0, smallData.width, smallData.height), new Point(0, 0));
            var bigPicture:Bitmap = new Bitmap(bigData);
            // on met en cache la grande image
            bigPicture.cacheAsBitmap = true;
            // on ajoute cette image au sprite
            containerBig.addChild(bigPicture);
            // on ajuste l'image a la taille de l'affichage 320x240 pixels
            // soit une reduction de 1/3.125
            containerSmall.scaleX = .320;
            containerSmall.scaleY = .320;
            // on fait la creation du masque vectoriel dans un sprite
            // un rectangle de 150 pixels de large qui va faire voir la grande image
            maskSprite = new Sprite();
            maskSprite.graphics.lineStyle(0, 0xFF0000, 1.0, true, "none", "ROUND", "ROUND", 3);
            maskSprite.graphics.beginFill(0xFFFFFF);
            maskSprite.graphics.drawRoundRect(-75, -45, 150, 90, 40, 40);
            // on remplit la forme creee
            maskSprite.graphics.endFill();
            // on met en cache l'image du masque
            maskSprite.cacheAsBitmap = true;
            // on ajoute le masque a la liste d'affichage
            addChild(maskSprite);
            // on assigne le masque a la grande image masquee
            bigPicture.mask = maskSprite;
            // on ajoute un evenement sur le stage
            stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseHideOrShow);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyZoom);
        }

        private function mouseMove(event:Event) : void {
            // on assigne le deplacement du masque a celui de la souris
            maskSprite.x = mouseX;
            maskSprite.y = mouseY;

            // on decale la grande image par rapport a la position de la souris
            // echelle entre grande et petite image = 3.125
            // on a un rapport de 3.125 - 1 --> zoomScale = 2,125
            containerBig.x = - mouseX * zoomScale;
            containerBig.y = - mouseY * zoomScale;
        }

        private function mouseWheel(event:MouseEvent) : void {
            // zoom en actionnant la molette
            if ( event.delta < 0 ) { // si molette poussee en arriere
                zoomOut();
            }
            else { /// si molette poussee en avant
                zoomIn();
            }
        }

        private function mouseHideOrShow(event:Event) : void {
            // on cache/montre la souris au clic de la souris
            if ( mouseHideState == false ) {
                Mouse.hide();
                mouseHideState = true;
            }
            else {
                Mouse.show();
                mouseHideState = false;
            }
        }

        private function keyZoom(event:KeyboardEvent) : void {
            // zoom si appui sur "ALT +" ou "ALT -"
            // recuperation du code de la touche pressee "NUMPAD_ADD = 107"
            if ( event.altKey == true && event.keyCode == 107 ) {
                zoomIn();
            }
            // recuperation du code de la touche pressee "NUMPAD_SUBTRACT = 109"
            else if ( event.altKey == true && event.keyCode == 109 ) {
                zoomOut();
            }
        }

        private function zoomIn() : void {
            // on agrandit le sprite contenant l'image originale
            containerBig.scaleX += containerBig.scaleX * .05;
            containerBig.scaleY += containerBig.scaleY * .05;
            maskSprite.width += maskSprite.width * .05;
            maskSprite.height += maskSprite.height * .05;
            // on augmente l'echelle de zoom de l'image originale
            zoomScale += zoomScale * .05;
            // on recentre le sprite sur la position de la souris
            followContainer();
        }

        private function zoomOut() : void {
            // on retraicit le sprite contenant l'image originale
            containerBig.scaleX -= containerBig.scaleX * .05;
            containerBig.scaleY -= containerBig.scaleY * .05;
            maskSprite.width -= maskSprite.width * .05;
            maskSprite.height -= maskSprite.height * .05;
            // on diminue l'echelle de zoom de l'image originale
            zoomScale -= zoomScale * .05;
            // on recentre le sprite sur la position de la souris
            followContainer();
        }

        private function followContainer() : void {
            // fonction permettant au sprite
            // de l'image de suivre la souris
            containerBig.x = - mouseX * zoomScale;
            containerBig.y = - mouseY * zoomScale;
        }
    }
}