package 
{
	import flash.display.*;
	import flash.events.KeyboardEvent;

	public class Pompitheque6 extends Sprite
	{
		public function Pompitheque6()
		{
			//this.addEventListener(KeyboardEvent.KEY_DOWN,listener);
			var vue:Vue=new Vue(new Personne("un",11,9,0,"debout","pocahontas"),1);						
			//var vue:Vue=new Vue(new Personne("deux",300,100,0,"debout","pocahontas"),1);	
			//var vue:Vue=new Vue(new Personne("trois",300,200,0,"debout","pocahontas"),1);		
			addChild(vue);
			//stage.focus = this;
		}
		
/* 		private function listener(ev:KeyboardEvent):void{
			var n:Number = ev.keyCode - 48;
			if(n < 10 && n >= 0){
				var g:String = "pocahontas";
				if(n % 2 == 1){
					//ici il faut mettre l'autre type que je ne connais pas
					g = "scaramouche";
				}
				var vue:Vue=new Vue(new Personne("client"+n,100+n*30,100+n*25,n*20,"debout",g),1);
				addChild(vue);
				this.removeEventListener(KeyboardEvent.KEY_DOWN,listener);
			}
		} */
	}
}
