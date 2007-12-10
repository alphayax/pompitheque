package Pompitheque
{
	  import flash.display.Sprite; // Un sprite est un lutin : zone déplaçable et animable
	
	  import flash.display.*;
		import flash.ui.*;
		import flash.net.*;
	  import flash.events.*;
	  import flash.net.URLRequest;
	
	  import flash.geom.Matrix;
	  import flash.geom.Rectangle;
//	  import mx.controls.*;
	
	  import flash.text.*;
//	 import mx.containers.*;
	

	  
	public class Vue2D extends Sprite
	{

		public var ListeActeur:Array = new Array();
		public var moi:Avatar2D;
		public var statut:String = "souris";
		public var objet_actif:Object = null;
		public var obj_sel:Object = null;
		public var der_obj_sel:Object = null;
		private var appel:Boolean = true;		
		private var cases_occupees:Array;
		public var infoBule:Sprite;
		
		public function Vue2D(hauteur:Number,largeur:Number,interligne:Number,ListeActeur:Array,Proprio:Personne){
		
			this.ListeActeur = ListeActeur;		
			/*var a:Avatar = new Avatar("eltaf",100,100,0);
			var t:Table = new Table(50,50);
			var c:Chaise = new Chaise(150,150);
			addChild(c);
			addChild(t);
			addChild(a);*/
			
			
	//deux sprites pour gérer les évènements
	var down:Sprite = new Sprite();
	var up:Sprite = new Sprite();
	
	deplacer(down,0,20);
	deplacer(up,0,20);
	
	down.graphics.beginFill(0,0.3);
	down.graphics.drawRect(0,0,400,400);
	down.graphics.endFill();
	
	
			
	//menu créé ici
	var menu:Sprite = new Sprite();
	

	//la partie de statut courent
	var souris:Sprite = new Sprite();
	var sg:Object = souris.graphics;
	sg.beginFill(0xFFFFFF,100);
	sg.moveTo(0,0);
	sg.drawRect(0,0,20,20);
	//statut.graphics.endFill();
	souris.x = 0;
	menu.addChild(souris);
	menu.x = 0;
	souris.name = "souris";

	//par défaut pointeur
	sg.lineStyle(1,0,1);
	sg.beginFill(0xFFFFFF,100);
	sg.moveTo(2,2);
	sg.lineTo(4,10);
	sg.lineTo(6,8);
	sg.lineTo(10,16);
	sg.lineTo(12,14);
	sg.lineTo(8,8);
	sg.lineTo(10,6);
	sg.lineTo(2,2);
	sg.endFill();


	souris.addEventListener(MouseEvent.CLICK, menu_clicked);

	//chaise

	var chaise:Sprite = new Sprite();
	var cg:Object = chaise.graphics;
	cg.beginFill(0xFFFFFF,100);
	cg.moveTo(0,0);
	cg.drawRect(0,0,20,20);
	chaise.x = 20;
	menu.addChild(chaise);
	chaise.addEventListener(MouseEvent.CLICK, menu_clicked);
	chaise.name = "chaise";
	
 	creer_losange_plein(chaise,5,5,10,10,0);



	var table:Sprite = new Sprite();
	cg = table.graphics;
	cg.beginFill(0xFFFFFF,100);
	cg.moveTo(0,0);
	cg.drawRect(0,0,20,20);
	table.x = 40;
	menu.addChild(table);
	table.addEventListener(MouseEvent.CLICK, menu_clicked);
	table.name = "table";
	cg.beginFill(0,1);
	cg.drawCircle(10,10,5);

	addChild(menu);
	addChild(down);
	
	//création des grilles
	var g:Object = down.graphics;
	g.moveTo(0,0);
        //graphics.background = 0xFFFFFF;
       //canvas = this;
	//la grille
        g.lineStyle(1, 0xFFFFFF, 0.5);
        
	for(var i:Number = 0; i <= hauteur/interligne ; i++){
		g.moveTo(0,i*interligne);
		g.lineTo(largeur, i*interligne); 
	}


	for(i = 0; i <= largeur/interligne ; i++){
		g.moveTo(i*interligne,0);
		g.lineTo(i*interligne, hauteur); 
	}

	
	//les bordures
	g.lineStyle(2, 0xFFFFFF, 0.5);
	g.moveTo(0,0);
	g.lineTo(0, hauteur); 
	g.lineTo(largeur, hauteur); 
	g.lineTo(largeur, 0); 
	g.lineTo(0, 0); 
	g.beginFill(0,0);
	g.drawRect(0,0,hauteur,largeur);
	g.endFill();
	
	/******************* ajouter les personnages **************/
	for(i = 0; i < ListeActeur.length; i++){
		addChild(new Avatar2D(ListeActeur[i].nom,ListeActeur[i].x2D,ListeActeur[i].y2D,ListeActeur[i].angleAbsolu,ListeActeur[i].statureAvatar,"M"));
	} 
	//lui meme
	moi = new Avatar2D(Proprio.nom,Proprio.getX2D(),Proprio.getY2D(),Proprio.getAngleAbsolu(),Proprio.getStature(),"M");
	//moi.graphics.beginFill(0x55FF55,1);
	moi.graphics.drawCircle(0,0,moi.taille/4);
	//moi.graphics.endFill();
	addChild(moi);

	
	
	this.addEventListener("enterFrame",enterFrame_handler);
	addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
	down.addEventListener(MouseEvent.CLICK, canvas_clicked)
 }
		
		
	public function enterFrame_handler(e:Event):void{
			
						
		}	
		
		

	private function menu_clicked(ev:MouseEvent):void {
	var tar:Object = ev.target.graphics;

	if(objet_actif != null){
		objet_actif.lineStyle(1,0xFFFFFF,1);
		objet_actif.beginFill(0,0);
		objet_actif.drawRect(0,0,20,20);
		objet_actif.endFill();
	}
	
	tar.lineStyle(1,0,1);
	tar.beginFill(0,0);
	tar.drawRect(0,0,20,20);
	tar.endFill();
	objet_actif = tar;
	statut = ev.target.name;
	
    }
		
		
	private function canvas_clicked(ev:MouseEvent):void{
// 	var t:TextField = new TextField();
// 	t.text = "eltaf";
// 	t.x = 200;
// 	addChild(t);
	var x:Number = ev.localX;
	var y:Number = ev.localY;
	if(appel == false){appel = true; trace(appel); return;}
	if(statut == "souris"){
		
// 		if(obj_sel != null){
// 			obj_sel.x = ev.target.localX;
// 			obj_sel.y = ev.target.localY;
// 		}
	//if(obj_sel != null)
	//deselect_tout(obj_sel);
	if(obj_sel != null){
		obj_sel.x = ev.localX;
		obj_sel.y = ev.localY;
	}else{
		moi.x = ev.localX;
		moi.y = ev.localY + 20;
	}

	}else if(statut == "chaise"){
		var chaise:Chaise2D = new Chaise2D(x,y);
		ev.target.addChild(chaise);
		chaise.name = "chaise";
		chaise.addEventListener(MouseEvent.CLICK,objet_clicked);
	}else if(statut == "table"){
		var table:Table2D = new Table2D(x,y);
		table.name = "table";
		ev.target.addChild(table);
		table.addEventListener(MouseEvent.CLICK,objet_clicked);
	}
    }
	
		
	
	
	
	
	private function objet_clicked(ev:MouseEvent):void{
		if(!(statut == "souris")){
			
			appel = false;
			trace(appel);
			return;
		}else{appel = false; }
		
	var obj:Object = ev.target.graphics;
	//var og:objet_graphique = new objet_graphique();
	

	if(objet_deja_sel(ev.target,obj_sel)){
	   if(ev.target == obj_sel && obj_sel.next == null){
		ev.target.deselect();
		//ev.target.removeEventListener();
		obj_sel = null;
		der_obj_sel = null;
		return;
	   }
	   if(ev.ctrlKey){
		ev.target.deselect();
		//ev.target.removeEventListener();
		ev.target.prev.next = ev.target.next;
		ev.target.next = null;
	   }else{
		deselect_tout(obj_sel);
		ev.target.select();
		//ev.target.addEventListener(KeyboardEvent.KEY_DOWN,Touche);
		obj_sel = ev.target;
		der_obj_sel = ev.target;
	   }
	}else if(obj_sel == null){
	
		
		ev.target.select();
		//ev.target.addEventListener(KeyboardEvent.KEY_DOWN,Touche);
		obj_sel = ev.target;
		der_obj_sel = ev.target;
		
	}else{
		if(!ev.ctrlKey){
			deselect_tout(obj_sel);
			obj_sel = ev.target;
			der_obj_sel = ev.target;
		}else{
			der_obj_sel.next = ev.target;
			ev.target.prev = der_obj_sel;
			der_obj_sel = ev.target;
		}
		
			ev.target.select();
			//ev.target.addEventListener(KeyboardEvent.KEY_DOWN,Touche);
			
		

		
	}
	/*if(obj_sel != null){
		obj_sel.addEventListener(KeyboardEvent.KEY_DOWN,Touche);
	}*/
    }

	
	
	
	
	public function deselect_tout(obj:Object):void{
	//var og:objet_graphique = new objet_graphique();
	if(obj.next == null){
	  
		obj.deselect();
		
	  
	 
	}else{
	  deselect_tout(obj.next);
	  obj.next = null;
	    
		obj.deselect();
		
	   
	}
   }


   public function objet_deja_sel(obj:Object,next:Object):Boolean{
	if(next == null)
	{
	  return false;
	}else if(next == obj){
		return true;
	}else{
		return objet_deja_sel(obj,next.next);
	}
   }
    


  /* public function select(obj2:Object):void{
     	//var og:objet_graphique = new objet_graphique();
	var obj:Object = obj2.graphics;
	if(obj2.name == "table"){
		obj.clear();
		obj.beginFill(0xAAAAFF,1);
		obj.drawCircle(0,0,10);
		obj.endFill();
			
	}else{
		obj.clear();
		//og.creer_losange_plein(obj2,0,0,20,20,0xAAAAFF);
		
	}	
   }

   public function deselect(obj2:Object):void{
	//var og:objet_graphique = new objet_graphique();
	var obj:Object = obj2.graphics;
	if(obj2.name == "table"){
		obj.clear();
		obj.beginFill(0x000000,1);
		obj.drawCircle(0,0,10);
		obj.endFill();
			
	}else{
		obj.clear();
		creer_losange_plein(obj2,0,0,20,20,0x000000);
		
	}	
   }*/
   
   public function reportKeyDown(event:KeyboardEvent):void {
			// Fleche gauche 
			if ( event.keyCode == 37 ) {
				this.rotate(this.moi,-20);
			}			
			// Fleche droite
			if ( event.keyCode == 39 ){
				this.rotate(this.moi,20);
			}
			if (event.keyCode == Keyboard.ESCAPE) {
				(Vue)(this.parent).switchVue();
			}
		}	
   
   
   /************************************************************/
		//groupe2d les fonctions créées
		//cree losange pour représenter l'avatar
		   public function creer_losange(obj:Object,x:Number,y:Number,h:Number,w:Number):Object{
			
			var gra:Object = obj.graphics;	
			gra.lineStyle(1,0,1);
			gra.moveTo(w/2 + x,y);
			gra.lineTo(w + x,h/2 + y);
			gra.lineTo(w/2 + x,h + y);
			gra.lineTo(x,h/2 + y);
			gra.lineTo(w/2 + x,y);
		
		
			return obj;
		   }
		
		
		   public function creer_losange_plein(obj:Object,x:Number,y:Number,h:Number,w:Number,co:Number):Object {
			var obj2:Object = obj.graphics;
			obj2.beginFill(co,1);
			creer_losange(obj,x,y,h,w);
			obj2.endFill();
		
			return obj;
		   }
		
		
		   public function deplacer(obj:Object,x:Number,y:Number):void{
			obj.x = x;
			obj.y = y;
		   }
		   
		   public function rotate(obj:Object,a:Number):void {
		   	obj.rotation = obj.rotation + a;
		   	obj.angleAbsolu = obj.rotation;
		   }
		   
		   public function showBule(x:Number,y:Number):void {
		   	infoBule.x = x;
		   	infoBule.y = y;
		   	infoBule.visible = true;
		   	
		   }
		   
		   public function hideBule():void {
		   	infoBule.visible = false;
		   }
		   
		/************************************************************/
   
   
		
		//les évènements
		
		/*public function Touche(event:KeyboardEvent):void {
			
			obj_sel.x += 20;
			// Fleche gauche 
			if ( event.keyCode == 37 ) {
				rotate(obj_sel,-20);
			}			
			// Fleche droite
			if ( event.keyCode == 39 ){ 
				rotate(obj_sel,20);
			}
			event.target.deselect();
			
		}*/
		
		
		
		
	}
}