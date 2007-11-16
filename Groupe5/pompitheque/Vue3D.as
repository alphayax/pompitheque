package pompitheque
{

    import pompitheque.message.MessageArea;
	import flash.display.Sprite ;
    import flash.events.*;
    // Composants
    import flash.display.SimpleButton;
    import flash.display.Shape;
    import flash.display.StageScaleMode ;

	public class Vue3D extends Sprite
	{
		// ----o protected property
        private var __message_area:MessageArea;
		// ----o constructeur
		public function Vue3D( message:MessageArea )
		{
            __message_area = message;
            addChild( __message_area );

            /************** Bouton ********************/
            var monBouton:SimpleButton = new SimpleButton();
            var normal:Shape = new Shape();
            var survol:Shape = new Shape();
            var clic:Shape = new Shape();
            // les dessins
            normal.graphics.beginFill(0x0000FF);
            normal.graphics.drawRoundRect(0, 0, 70, 30, 30);
            survol.graphics.beginFill(0xFF0000);
            survol.graphics.drawRoundRect(0, 0, 70, 30, 30);
            clic.graphics.beginFill(0x00FF00);
            clic.graphics.drawRoundRect(0, 0, 70, 30, 30);
            // les etats du bouton
            monBouton.upState = normal;
            monBouton.overState = survol;
            monBouton.downState = clic;
            monBouton.hitTestState = normal;
            // application du filtre au bouton
            monBouton.addEventListener(MouseEvent.CLICK, onClick);
	    
            // affichage du bouton
            this.addChild(monBouton);
}
        
        /******************************************
                        Evenements
        *******************************************/
        public function onClick(e:Event):void
        {
            __message_area.saisie();
        }
    }
}
