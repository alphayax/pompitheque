package Pompitheque
{
	public class menuBoutton extends boutton
	{
		public var D2:Array;
		
		public function menuBoutton(text:String,co:Array,pos:Array,fu:Function,D2:Array){
			super(text,co,pos,fu);
			this.D2 = D2;
		}
	}
}
