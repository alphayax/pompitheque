package message
{
    //MessageField
    import pompitheque.message.MessageWidget;
    import flash.display.Sprite ;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class MessageArea extends Sprite {

        public var msgfield:MessageWidget ;

        // ----o Constructor
        public function MessageArea()
        {
            msgfield = new MessageWidget();
        }
        
        public function afficher():void
        {
            addChild(msgfield);
            msgfield.afficheTextInput();
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
