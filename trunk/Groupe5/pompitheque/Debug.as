package pompitheque
{
/*********************************
            Class Debug
*********************************/

// Composants Text
import flash.text.TextField ; 
import flash.text.TextFieldType ;
import flash.text.TextFormat ;

public class Debug extends TextField 
{
	// ----o Constructor
 
	public function Debug() 
	{
 
		type = TextFieldType.INPUT ;		
		width = 400 ;
		height = 200 ;
		border = true ;
		borderColor = 0xFFFFFF ;
		textColor = 0xFFFFFF ;
		defaultTextFormat = new TextFormat("arial", 12)  ;
    }
}
}
