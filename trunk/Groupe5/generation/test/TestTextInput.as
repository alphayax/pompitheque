package generation.test
{
 
	import flash.display.Sprite ;
	import flash.display.StageScaleMode ;
		
	import flash.events.TextEvent 
	import flash.events.Event;
        import flash.events.MouseEvent;
        
        import flash.display.SimpleButton;
        import flash.display.Shape;
        import flash.filters.BevelFilter;

	
	public class TestTextInput extends Sprite
	{
		
		// ----o Protected Property
		
		protected var tf:CustomField ;

		// ----o Constructor
		
		public function TestTextInput()
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE ;
			
			tf = new CustomField() ;
 
			tf.addEventListener(TextEvent.TEXT_INPUT, onInput) ;
			tf.addEventListener(Event.CHANGE, onChange) ;
 
			tf.x = 50 ;
			tf.y = 50 ;
 
			tf.text = "Saisir du texte ici : " ;
 

                        
                        
                        
                        
                        
                        // instances du bouton et des dessins
                        var monBouton:SimpleButton = new SimpleButton();
                        var normal:Shape = new Shape();
                        var survol:Shape = new Shape();
                        var clic:Shape = new Shape();

                        var distance:Number = 5;
                        var angle:Number = 45;
                        var surbrillance:Number = 0xFFFFFF;
                        var alphaSurbrillance:Number = 1.0;
                        var ombre:Number = 0x000000;
                        var alphaOmbre:Number = .9;
                        var flouX:Number = 5;
                        var flouY:Number = 5;
                        var intensite:Number = 1;
                        var qualite:Number = 3;
                        var type:String = "inner";
                        var masquage:Boolean = false;
// definition du biseau
                        var filtreBiseau:BevelFilter = new BevelFilter(distance,angle, surbrillance, alphaSurbrillance, ombre, alphaOmbre, flouX, flouY, intensite, qualite, type, masquage);

// les dessins
                        normal.graphics.beginFill(0x0000FF);
                        normal.graphics.drawRoundRect(0, 0, 70, 30, 30);
                        survol.graphics.beginFill(0xFF0000);
                        survol.graphics.drawRoundRect(0, 0, 70, 30, 30);
                        clic.graphics.beginFill(0x00FF00);
                        clic.graphics.drawRoundRect(0, 0, 70, 30, 30);
// les états du bouton
                        monBouton.upState = normal;
                        monBouton.overState = survol;
                        monBouton.downState = clic;
                        monBouton.hitTestState = normal;

// application du filtre au bouton
                        monBouton.filters = new Array(filtreBiseau);
                        monBouton.addEventListener(MouseEvent.CLICK, afficheTextInput);
                        
// affichage du bouton
                        
                        this.addChild(monBouton);


                        
                        
                        
			
		}
		
		// ----o Public Methods
                public function afficheTextInput(e:Event):void
                {
                    addChild(tf) ;	
                    //trace(">> " + e.type + " -> " + e.currentTarget) ;
                }
                
		public function onChange(e:Event):void
		{
			trace(">> " + e.type + " -> " + e.currentTarget) ;
		}
		
		public function onInput(e:TextEvent):void 
		{
			
			trace (">> " + e.type + " -> " + e.currentTarget) ;	
		}
		
		
	}
}
 
import flash.text.TextField ; 
import flash.text.TextFieldType ;
import flash.text.TextFormat ;
 
class CustomField extends TextField 
{
	
	// ----o Constructor
 
	public function CustomField() 
	{
 
		type = TextFieldType.INPUT ;		
		width = 300 ;
		height = 300 ;
		border = true ;
		borderColor = 0xFFFFFF ;
		textColor = 0xFFFFFF ;
		defaultTextFormat = new TextFormat("arial", 12)  ;
}
 
}


