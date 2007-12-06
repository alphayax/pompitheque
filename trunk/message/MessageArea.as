package pompitheque.message
{
    import pompitheque.message.MessageWidget;
    import flash.display.Sprite ;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class MessageArea extends Sprite
    {

        private var __message_widget:MessageWidget ;

        // ----o Constructor
        public function MessageArea()
        {
            __message_widget = new MessageWidget();
        }
        
        public function saisie():void
        {
            addChild(__message_widget);
            __message_widget.afficheTextInput();
	    
            //evenements
            addEventListener(MouseEvent.MOUSE_DOWN, selectionne);
            addEventListener(MouseEvent.MOUSE_UP, place);
        }
                            
        public function setMessage( message:Message ):void
        {
            __message_widget.setMessage( message );
        }
	    
        /*** Fonctions de Drag and Drop ******/
        public function selectionne(e:MouseEvent):void {
            e.currentTarget.startDrag();
            __message_widget.alpha = 50;
        } 
                     
        public function place(e:MouseEvent):void {
            e.currentTarget.stopDrag();
            __message_widget.alpha = 0;
        }
    }              
}
