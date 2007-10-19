package generation
{
         //MessageField
import generation.MessageField;
import flash.display.Sprite ;
import flash.events.Event;
import flash.events.MouseEvent;

	 public class Fenetre extends Sprite {

                private var fenetre:MessageField ;

		// ----o Constructor
		public function Fenetre()
		{
		fenetre = new MessageField();
		
		addChild(fenetre) ;
		
		addEventListener(MouseEvent.MOUSE_DOWN, selectionne);
		addEventListener(MouseEvent.MOUSE_UP, place);

		}
		
		              		
		public function selectionne(e:MouseEvent):void {
		e.currentTarget.startDrag();
                } 
                 
                public function place(e:MouseEvent):void {
		e.currentTarget.stopDrag();
                }
                    
		}              
		              
}