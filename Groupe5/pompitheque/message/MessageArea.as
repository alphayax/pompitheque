package pompitheque.message
{
    //MessageField
    import pompitheque.message.MessageWidget;
    import flash.display.Sprite ;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class MessageArea extends Sprite {

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
            addEventListener(MouseEvent.MOUSE_DOWN, selectionne);
            addEventListener(MouseEvent.MOUSE_UP, place);
        }
                            
        public function setMessage( message:Message ):void
        {
            __message_widget.setMessage( message );
        }
        public function selectionne(e:MouseEvent):void {
            e.currentTarget.startDrag();
        } 
                 
        public function place(e:MouseEvent):void {
            e.currentTarget.stopDrag();
        }
                    
    }              
		              
}
