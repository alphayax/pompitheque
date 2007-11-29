package test{
	 //mxmlc -source-path=/auto_home/pvassallo/M2/projet/pompitheque/Groupe5/superposition/ TestImage4.as
	import flash.display.SimpleButton;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.*;
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
	
	public class TestImage4b extends Sprite{
		
		private var _parent:Sprite
		private var image:Bitmap			//source
		private var imageBmp:BitmapData
			
		
			
		 public function TestImage4b() {
		 
		 
		//Points recu & travail sur ces points
			 
/* 		var point1:Point = new Point(0, 0);
 * 		var point2:Point = new Point(200, 0);
 * 		var point3:Point = new Point(0, 200);
 * 		var point4:Point = new Point(200, 200);
 */
			
		var point1:Point = new Point(-10,80);
		var point2:Point = new Point(0, 0);
		var point3:Point = new Point(110, 0);
		var point4:Point = new Point(120, 80);
		
		//point sup pour calculer l'angle
		var pointSup:Point = new Point(point2.x,point1.y );
		
		//calcul d'un angle
		var angle:Number = Math.acos( (Point.distance(point1,point2) + Point.distance(pointSup,point2) + Point.distance(point1,pointSup) ) )
		
		//calcul largeur et heuteur du rectangle
		var largeur:Number = Point.distance(point2,point3);
		var hauteur:Number = Point.distance(point1,point2);
		var diag:Number = Point.distance(point1,point3);
		
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
		
		//calcul de la diagonal
		/*var diag:Number;
		diag=Math.sqrt(Math.pow(largeur,2)+Math.pow(hauteur,2));
		trace (diag);*/
		
		var taille:Number;
		if(diag>300){ taille=14;}
		if(diag>200 && diag<300){taille=12;}
		if(diag<200 && diag>150){taille=10;}
		if(diag<150 && diag>100){taille=8;}
		if(diag<100){taille=6;}

		
		//creation  du rectangle

		var torse:Shape = new Shape();
		torse.graphics.beginFill(0xFFFFFFF,1.0);
		torse.graphics.moveTo(point1.x,point1.y);
		torse.graphics.lineTo(point2.x,point2.y);
		torse.graphics.lineTo(point3.x,point3.y);
		torse.graphics.lineTo(point4.x,point4.y);
		torse.graphics.endFill();
		//torse.graphics.drawRect(0,0,largeur,hauteur);
		

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
		tf.x = point2.x; tf.y = point2.y;
		
		tf.width = largeur; tf.height =hauteur;
			
		//definition du texte
		//tf.htmlText = "<b>Lorem ipsum dolor sit amet.</b>";
		var texte:String="essai 2 de dialogue et bla et bla et bla et bla et bla ensuite et aprtes ca me saoule";
		 
		tf.multiline = true;
		tf.wordWrap = true;	
		//tf.embedFonts = true;
		
		//definition du format
		var format:TextFormat = new TextFormat();
		
		format.font = "Verdana";
		format.color = 0xFF0000;
		format.size = taille;
		
		tf.defaultTextFormat = format;
		tf.text=texte;
		
 		//  tf.text=diag.toString();
 		// tf.appendText(" + ");
		// tf.appendText(hauteur.toString());
 		// tf.appendText(" + ");tf.appendText(largeur.toString()); 
 
		
		
		this.addChild(tf);
		
		
		 
		 }
		
	}
	
}
