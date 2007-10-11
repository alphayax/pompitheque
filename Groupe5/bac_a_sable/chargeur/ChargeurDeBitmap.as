// Ce fichier a été compilé suivant la commande suivante :
// mxmlc -source-path=/home/pompidor/FLEX/TESTS/ ChargeurDeBitmap.as
// alors qu'il se trouve dans /home/pompidor/FLEX/TESTS/Pierre

// Gestion dans la liste d'affichage d'un objer d'affichage
// addChild(objet) : ajout
// removeChild(objet) : suppression
// setChildIndex(objet, position) : changement de profondeur
// objet.x : position en abscisse
// objet.y : position en ordonnée

package chargeur
{
  import flash.display.Sprite; // Un sprite est un lutin : zone déplaçable et animable
  import flash.display.Loader;
  import flash.display.Bitmap;	
  import flash.display.BitmapData;

  import flash.events.Event;
  import flash.net.URLRequest;

  import flash.geom.Matrix;
  import flash.geom.Rectangle;

  import flash.text.TextField;

  public class ChargeurDeBitmap extends Sprite {
     // chaque Sprite a une propriété graphics implicite

     // Chargement et affichage d'une image
     public function ChargeurDeBitmap() {

        graphics.moveTo(0,0); // Position initiale

	// Affichage de texte
        var champ:TextField = new TextField();
	champ.text = "Essais divers";
        addChild(champ);

        graphics.lineStyle(1, 0, 0.5); // épaisseur : 1; couleur; alpha (de 0 à 1)
        graphics.lineTo(100, 100); // Ligne : tracée depuis la position courante
        graphics.drawRect(50, 50, 50, 50); // Rectangle évidé vert : 
        // Cercle plein
        graphics.beginFill(0x00FF00),
        graphics.drawCircle(50, 50, 10); // Cercle : x, y, r
        graphics.endFill();

	// Chargement d'une image
        //addChild(_chargeur);

        // Affichage d'un bitmap blanc demi-transparent
        var bitmapdata:BitmapData = new BitmapData(100, 100, true, 0x0FFFFFFF)
        var bitmap:Bitmap = new Bitmap(bitmapdata);
	addChild(bitmap);

        // Affichage d'une ellipse bleue dans un nouveau sprite positionné en 100.100
	var sprite2:Sprite = new Sprite();
	sprite2.x = 100;
	sprite2.y = 100;
	sprite2.graphics.beginFill(0x0000FF);
	sprite2.graphics.drawEllipse(0, 25, 100, 50);
	sprite2.graphics.endFill();
	addChild(sprite2);

	// Gestion d'une image en arrière-plan dans un sprite
        var image:Loader = new Loader();
        image.load(new URLRequest("barb.jpg"));        

/*
        var data:BitmapData = new BitmapData(image.width, image.height, false, 0xFFFFFFFF)
        data.draw(image.content, new Matrix());
        var btpimage:Bitmap = new Bitmap(data);
        btpimage.x = 100;
        btpimage.y = 200;
        addChild(btpimage);
*/

        image.x = 100;
        image.y = 200;
        addChild(image);
     }
  }
}
