package pompitheque
{
	import flash.display.Sprite ;

    // Composants Text
    import flash.text.TextField ; 
 	
	public class FileMessage
	{
		
		// ----o Protected Property
        string from;
		

		// ----o Constructor

		public function FileMessage() { }//TODO
		
		// ----o Public Methods
        public function affiche(p1,p2,p3,p4):TextField { }//TODO
		
        public function toXml():string {}//TODO
                        
		public function add( mess:Message ):void { }//TODO
		
		public function remove( mess:Message ):void { }//TODO
        
        public function setDestinataire( destinataire:string ):void { }//TODO
		
	}
}


