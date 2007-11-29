package test{
	 //mxmlc -source-path=/auto_home/pvassallo/M2/projet/pompitheque/Groupe5/superposition/ TestImage4.as
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.*;
	import flash.display.Graphics
	//import flash.math
	// event		
	import flash.events.TextEvent 
	import flash.events.Event;
	import flash.events.KeyboardEvent ;
	import flash.events.MouseEvent;
	import flash.events.*;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TestImage4 extends Sprite{
		
		private var _parent:Sprite
		private var image:Bitmap			//source
		private var imageBmp:BitmapData
			
		
			
		 public function TestImage4() {
		 
		 
		//Points recu & travail sur ces points
			 
/* 		var point1:Point = new Point(0, 0);
 * 		var point2:Point = new Point(200, 0);
 * 		var point3:Point = new Point(0, 200);
 * 		var point4:Point = new Point(200, 200);
 */
			
		var point1:Point = new Point(0, -50);
		var point2:Point = new Point(150, 50);
		var point3:Point = new Point(0, 150);
		var point4:Point = new Point(150, 200);
		
		//point sup pour calculer l'angle
		var pointSup:Point = new Point(point2.x,point1.y );
		
		//calcul d'un angle
		var angle:Number = Math.acos( (Point.distance(point1,point2) + Point.distance(pointSup,point2) + Point.distance(point1,pointSup) ) )
		
		//calcul largeur et heuteur du rectangle
		var largeur:Number = Point.distance(point1,point2);
		var hauteur:Number = Point.distance(point1,point3);
		
		//Effet de matrice
		//angle=30;
		 var matr:Matrix = new Matrix();
		 //matr.translate(50,50);
		//matr.rotate(2*Math.PI*(angle/360));
		//matr.b=Math.tan(1);
/* 		matr.a=0;
 * 		matr.c=Math.tan(angle);
	
 * 		matr.b=0;
 * 		matr.d=0;
 */
		//trace(matr);
		
		
		
		//creation  du rectangle

		//var torse:Shape = new Shape();
		this.createEmptyMovieClip("torse",3);
		torse.graphics.beginFill(0xFFFFFFF,1.0);
		torse.lineStyle(1,0x000000);
		torse.lineTo(point1.x,point1.y);
		torse.lineTo(point2.x,point2.y);
		torse.lineTo(point3.x,point3.y);
		torse.lineTo(point4.x,point4.y);
		torse.endFill();
		//torse.graphics.drawRect(0,0,largeur,hauteur);
		
		/*var Rect:Rectangle = new Rectangle(200,200,largeur,hauteur);
		var point5:Point = new Point(450, 400);
		Rect.bottomRight= point5;
		trace(Rect);*/
		

		this.addChild(torse);
		//mageBmp = new BitmapData( largeur, hauteur , true, 0x00000000 );	 
		//imageBmp.draw( );
		//this.addChild(imageBmp);
		
		//application de la matrice
		var torseTrans:Transform = new Transform(torse);
		torseTrans.matrix = matr;
		
		//creation de la textfield
		var tf:TextField = new TextField();
		
		//Les coordonnées du textfield sont les memes que l'imager		
		tf.x = torse.x; tf.y = torse.y;
		
		tf.width = largeur; tf.height =hauteur;
			
		//definition du texte
		//tf.htmlText = "<b>Lorem ipsum dolor sit amet.</b>";
		var texte:String="essai de dialogue";
		 
		tf.multiline = true;
		tf.wordWrap = true;	
		//tf.embedFonts = true;
		
		//definition du format
		var format:TextFormat = new TextFormat();
		
		format.font = "Verdana";
		format.color = 0xFF0000;
		format.size = 20;
		
		tf.defaultTextFormat = format;
		
		tf.text=" essai de dialogue ";
		
		this.addChild(tf);
		
		
		 
		 }
		
	}
	
}
