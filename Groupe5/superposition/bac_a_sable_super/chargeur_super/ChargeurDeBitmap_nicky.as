package chargeur
{
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class ChargeurDeBitmap extends Sprite {
        private var _chargeur:Loader = new Loader();
        // Chargement
        public function ChargeurDeBitmap() {
            graphics.lineStyle(1, 0, 1);
            graphics.lineTo(100, 100);
            var pictURL:String = "./barb.jpg";
            _chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            _chargeur.load(new URLRequest(pictURL));
        }
        // Acces aux infos du bitmap: affichage d'une image
        public function onComplete(evenement:Event):void {
            var image:Bitmap = Bitmap(_chargeur.content);
            var bitmap:BitmapData = image.bitmapData;
            addChild(image);
        }
    }
}