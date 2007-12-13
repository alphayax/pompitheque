package Pompitheque
{
	
	
	  import flash.display.*;
	
	  import flash.events.*;
	  import flash.net.URLRequest;
	
	  import flash.geom.Matrix;
	  import flash.geom.Rectangle;
	  
	  import flash.text.*;

	

	  
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
		private var listePersonne:Array = new Array();
		public var up:Sprite;
		public var down:Sprite;
		public var indication:Sprite = new Sprite();
		private var menuActif:MenuPersonne;
		private var numImmeubilier:Number = 0;
		
		
		public function Vue2D(hauteur:Number,largeur:Number,interligne:Number,ListeActeur:Array,Proprio:Personne){
			this.ListeActeur = ListeActeur;		

			
		//deux sprites pour gérer les évènements
		down = new Sprite();
		up = new Sprite();
		
		deplacer(down,0,20);
		deplacer(up,0,20);
		
		down.graphics.beginFill(0,0.3);
		down.graphics.drawRect(0,0,400,400);
		down.graphics.endFill();
		
		indication.graphics.lineStyle(2,0xAAFFAA,1);
		indication.graphics.drawCircle(0,0,20);
		deplacer(indication,100,100);
		indication.visible = false;
		down.addChild(indication);
		
	
			
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
		sg.lineTo(4,12);
		sg.lineTo(6,10);
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
		addChild(up);
		
		//création des grilles
		var g:Object = down.graphics;
		g.moveTo(0,0);
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
			if(ListeActeur[i].getClass() == "personne"){
				var a:Avatar2D = new Avatar2D(ListeActeur[i].nom,ListeActeur[i].x2D,ListeActeur[i].y2D,ListeActeur[i].angleAbsolu,ListeActeur[i].statureAvatar,"M");
				up.addChild(a);
				a.infoBule.rotation = -ListeActeur[i].angleAbsolu;
				listePersonne.push(a);
			}else if(ListeActeur[i].getClass() == "table"){
			
			}else if(ListeActeur[i].getClass() == "chaise"){
			
			}
		} 
		
		//menu des personnages (a droite)
		menuActif = new MenuPersonne(down.width + down.x + 5,down.y,listePersonne);
		addChild(menuActif);
		
		/*var s:Sprite = new Sprite();
		addChild(s);*/
			var t:TextField = new TextField();
			t.type = TextFieldType.INPUT;
			t.border = true;
			t.borderColor = 0x000000;
			t.height = 20;
			t.width = 150;
			t.x = menuActif.x;
			t.y = menuActif.y;
			//s.addChild(t);
			
		/*t.addEventListener(Event.CHANGE,TextChanged);
		t.addEventListener(MouseEvent.CLICK,function (event:MouseEvent):void {event.target.text = "eltaf"; });
		t.addEventListener(KeyboardEvent.KEY_DOWN,function (e:KeyboardEvent):void{e.target.text += e.charCode; });*/
			
				
		//lui meme
		moi = new Avatar2D(Proprio.nom,Proprio.x2D,Proprio.y2D,Proprio.angleAbsolu,Proprio.statureAvatar,"M");
		moi.graphics.drawCircle(0,0,moi.taille/4);
		addChild(moi);
	
		
		
		down.addEventListener(MouseEvent.CLICK, canvas_clicked);
 }
		
		
		
		
		
		
		
		
	/****************************** Autres méthodes ***********************************/	

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

	var x:Number = ev.localX;
	var y:Number = ev.localY;
	if(appel == false){appel = true; trace(appel); return;}
	if(statut == "souris"){
		
	if(obj_sel != null){
		obj_sel.x = ev.localX;
		obj_sel.y = ev.localY;
	}else{
		moi.x = ev.localX;
		moi.y = ev.localY + 20;
	}

	}else if(statut == "chaise"){
		var chaise:Chaise2D = ajoutChaise(x,y);
		/*var chaise:Chaise2D = new Chaise2D(x,y);
		ev.target.addChild(chaise);
		chaise.name = "chaise";*/
		chaise.addEventListener(MouseEvent.CLICK,objet_clicked);
	}else if(statut == "table"){
		var table:Table2D = ajoutTable(x,y);
		/*var table:Table2D = new Table2D(x,y);
		table.name = "table";
		ev.target.addChild(table);*/
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

	if(objet_deja_sel(ev.target,obj_sel)){
	   if(ev.target == obj_sel && obj_sel.next == null){
		ev.target.deselect();
		obj_sel = null;
		der_obj_sel = null;
		return;
	   }
	   if(ev.ctrlKey){
		ev.target.deselect();
		ev.target.prev.next = ev.target.next;
		ev.target.next = null;
	   }else{
		deselect_tout(obj_sel);
		ev.target.select();
		obj_sel = ev.target;
		der_obj_sel = ev.target;
	   }
	}else if(obj_sel == null){
	
		
		ev.target.select();
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

	}

    }

	
	
	
	
	public function deselect_tout(obj:Object):void{
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
		   	if(obj.getClass() == "avatar"){
		   		obj.infoBule.rotation = -obj.rotation;
		   	}
		   }
		   
		   public function showBule(x:Number,y:Number):void {
		   	infoBule.x = x;
		   	infoBule.y = y;
		   	infoBule.visible = true;
		   	
		   }
		   
		   public function hideBule():void {
		   	infoBule.visible = false;
		   }
		   
		   
		   public function CallBackAjoutPersonnage(newpers:Acteur):void{
		   	var p:Avatar2D = new Avatar2D(newpers.nom,newpers.x2D,newpers.y2D,newpers.angleAbsolu,"debout",newpers.genre);
		   	listePersonne.push(p);
		   	addChild(p);
		   	menuActif = new MenuPersonne(down.width + down.x + 5,down.y,getVue().ListeActeur);
			addChild(menuActif);
		   }
		   
		   public function CallBackSuppPersonnage(i:Number):void{
		   	up.removeChild(listePersonne[i]);
   			for(var j:Number = i; j < ListeActeur.length - 1; j++){
   				listePersonne[j] = listePersonne[j+1];
   			}
   			removeChild(menuActif);
   			listePersonne.pop();
		   	menuActif = new MenuPersonne(down.width + down.x + 5,down.y,listePersonne);
			addChild(menuActif);
		   }
		   
		   public function CallBackPosition(newpers:Acteur):void{
		   	for(var i:Number = 0; i < listePersonne.length; i++){
		   		if(listePersonne[i].nom == newpers.nom){
		   			listePersonne[i].x2D = newpers.x2D;
		   			listePersonne[i].y2D = newpers.y2D;
		   			listePersonne[i].x = newpers.x2D;
		   			listePersonne[i].y = newpers.y2D;
		   			listePersonne[i].bouttonConcernant.D2 = [newpers.x2D,newpers.y2D];
		   			break;
		   		}
		   	}
		   }
		   
		   public function CallBackOrientation(newpers:Acteur):void{
		   	for(var i:Number = 0; i < listePersonne.length; i++){
		   		if(listePersonne[i].nom == newpers.nom){
		   			listePersonne[i].angleAbsolu = newpers.angleAbsolu;
		   			listePersonne[i].rotation = newpers.angleAbsolu;
		   			
		   			break;
		   		}
		   	}
		   }
		   
		   public function ajoutTable(x:Number,y:Number,t:Number = 10):Table2D{
		   	var table:Table2D;
		   	table = new Table2D(x,y);
		   	numImmeubilier++;
		   	table.nom = "imm" + numImmeubilier;
		   	up.addChild(table);
		   	ListeActeur.push(table);
		   	return table;
		   }
		   
		   public function ajoutChaise(x:Number,y:Number):Chaise2D{
		   	var chaise:Chaise2D;
		   	chaise = new Chaise2D(x,y);
		   	numImmeubilier++;
		   	chaise.nom = "imm" + numImmeubilier;
		   	up.addChild(chaise);
		   	ListeActeur.push(chaise);
		   	return chaise;
		   }
		   
		   public function suppImmeubilier(obj:Object):void{
		   	for(var i:Number = 0; i < ListeActeur.length; i++){
		   		if(ListeActeur[i].nom == obj.nom){
		   			up.removeChild(ListeActeur[i]);
		   			for(var j:Number = i; j < ListeActeur.length - 1; j++){
		   				ListeActeur[j] = ListeActeur[j+1];	
		   			}
		   			break;
		   			
		   		}
		   	}
		  
		   	ListeActeur.pop();
		   }
		   
		   
		   
		   public function getVue():Object{
		   	return Object(parent);
		   }
		   
		/************************************************************/
   
   	
		
		//les évènements
		
		
		public function TextChanged(event:Event):void{
			
		}
		
		
		
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
