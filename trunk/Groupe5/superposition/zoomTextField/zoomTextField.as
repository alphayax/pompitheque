package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.ui.Mouse;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class zoomTextField extends Sprite
    {
        // le container qui contient la grande TextField
        private var __containerBig:Sprite;
        // les coordonnees recues des points du torse
        private var __pointsTorse:Array;
        // les trucs pour le texte
        private var __tfBig:TextField;
        private var __formatBig:TextFormat;
        private var __taillePoliceBig:Number; // AJOUT DIAGRAMME

        // la variable qui precise l'etat de la souris "hidden ou non"
        private var __mouseHideState:Boolean = false;
        // l'echelle du zoom par rapport a l'image reduite
        private var __zoomScale:Number = 2.125;


        public function zoomTextField( tf:TextField, pointsTorse:Array )
        {
            __containerBig = new Sprite();
            __pointsTorse  = new Array();
            __tfBig        = new TextField();
            __formatBig    = new TextFormat()

            __tfBig        = tf;
            __pointsTorse  = pointsTorse;
            __formatBig    = tf.getTextFormat();

            this.addChild(__containerBig);
            __containerBig.addChild( containerBigLoaded() );

            // on ajoute des evenements
            addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
            addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseHideOrShow);
            addEventListener(KeyboardEvent.KEY_DOWN, keyZoom);
        }

        public function containerBigLoaded() : TextField
        {
            // format du grand texte adapte
            __taillePoliceBig = 12;
            __formatBig.size  = __taillePoliceBig;

            __tfBig.width           = 320; 
            __tfBig.height          = 240;
            __tfBig.background      = true;
            __tfBig.backgroundColor = 0xFFFF00; // jaune
            __tfBig.multiline       = true;
            __tfBig.wordWrap        = true;
            __tfBig.setTextFormat( __formatBig );

            return __tfBig;
        }

        public function mouseMove(event:Event) : void {
            // on assigne le deplacement du container a celui de la souris
            __containerBig.x = mouseX;
            __containerBig.y = mouseY;
        }

        public function mouseWheel(event:MouseEvent) : void {
            // zoom en actionnant la molette
            if ( event.delta < 0 ) { // si molette poussee en arriere
                zoomOut();
            }
            else { /// si molette poussee en avant
                zoomIn();
            }
        }

        public function mouseHideOrShow(event:Event) : void {
            // on cache/montre la souris au clic de la souris
            if ( __mouseHideState == false ) {
                Mouse.hide();
                __mouseHideState = true;
            }
            else {
                Mouse.show();
                __mouseHideState = false;
            }
        }

        public function keyZoom(event:KeyboardEvent) : void {
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

        public function zoomIn() : void {
            // on agrandit le sprite contenant l'image originale de 5% par frappe
            __containerBig.scaleX += __containerBig.scaleX * .05;
            __containerBig.scaleY += __containerBig.scaleY * .05;
            // on augmente l'echelle de zoom de l'image originale
            __zoomScale           += __zoomScale * .05;
            // on fait suivre le sprite sur la position de la souris
            followContainer();
        }

        public function zoomOut() : void {
            // on retraicit le sprite contenant l'image originale de 5% par frappe
            __containerBig.scaleX -= __containerBig.scaleX * .05;
            __containerBig.scaleY -= __containerBig.scaleY * .05;
            // on diminue l'echelle de zoom de l'image originale
            __zoomScale           -= __zoomScale * .05;
            // on fait suivre le sprite sur la position de la souris
            followContainer();
        }

        public function followContainer() : void {
            // fonction permettant au sprite de l'image de suivre la souris
            __containerBig.x = mouseX;
            __containerBig.y = mouseY;
        }
    }
}