package
{
	
	
	  import flash.display.*;
	
	  import flash.events.*;
	  import flash.net.URLRequest;
	
	  import flash.geom.Matrix;
	  import flash.geom.Rectangle;
	  
	  import flash.text.*;
	  import flash.utils.*;
	  import chat.Client;
	

	  
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
		private var interligne:Number;
		private var longueur:Number;
		private var hauteur:Number;
		private var vueLoaded:Number;
		private var inte:Number = 0;
		
		
		public function Vue2D(plan:XML,Proprio:Personne){
			//this.ListeActeur = ListeActeur;		

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
	        
	    interligne = Number(plan.@interligne);
	    longueur = Number(plan.@longueur);
	    hauteur = Number(plan.@hauteur);
	    
	    interligne = 20;
	    longueur = 600;
	    hauteur = 400;
	        
	       // p = new Prompt(interligne + "   " + longueur + "   " + hauteur);
	       // addChild(p);
	      
		for(var i:Number = 0; i <= hauteur/interligne ; i++){
			g.moveTo(0,i*interligne);
			g.lineTo(longueur, i*interligne); 
		}
	
	
		for(i = 0; i <= longueur/interligne ; i++){
			g.moveTo(i*interligne,0);
			g.lineTo(i*interligne, hauteur); 
		}
	
		
		//les bordures
		g.lineStyle(2, 0xFFFFFF, 0.5);
		g.moveTo(0,0);
		g.lineTo(0, hauteur); 
		g.lineTo(longueur, hauteur); 
		g.lineTo(longueur, 0); 
		g.lineTo(0, 0); 
		g.beginFill(0,0);
		g.drawRect(0,0,hauteur,longueur);
		g.endFill();
		

		//créer les murs 
		for each(var mur:XML in plan.salle..mur){
			addChild(new Mur2D(Number(mur.@x1)*interligne,Number(mur.@y1)*interligne,Number(mur.@x2)*interligne,Number(mur.@y2)*interligne));
		}
		 
		for each(var porte:XML in plan.salle..porte){
			addChild(new Porte2D(Number(mur.@x1)*interligne,Number(mur.@y1)*interligne,Number(mur.@x2)*interligne,Number(mur.@y2)*interligne));
		}
		
		for each(var table2:XML in plan.mobilier..table){
			addChild(new Table2D(Number(table2.@x)*interligne,Number(table2.@y)*interligne,Number(table2.@longueur),Number(table2.@hauteur)));
		}
		
		for each(var chaise2d:XML in plan.mobilier..chaise){
			addChild(new Chaise2D(Number(chaise2d.@x)*interligne,Number(chaise2d.@y)*interligne,Number(chaise2d.@orientation),Boolean(chaise2d.occupe) ));
		}
		
		
		//--------------- ajouter les personnages ----------------/
		vueLoaded = setInterval(vueLoadedFunc, 500);
		
		
	//var p:Prompt = new Prompt(String(getVue().Proprio.x));
	//addChild(p);
		
		//menu des personnages (a droite)
		menuActif = new MenuPersonne(down.width + down.x + 5,down.y,listePersonne);
		addChild(menuActif);
		

			var t:TextField = new TextField();
			t.type = TextFieldType.INPUT;
			t.border = true;
			t.borderColor = 0x000000;
			t.height = 20;
			t.width = 150;
			t.x = menuActif.x;
			t.y = menuActif.y;
			addChild(t);
			

			
				
		//lui meme
		moi = new Avatar2D(Proprio.getName(),Proprio.getX2D(),Proprio.getY2D(),Proprio.getAngleAbsolu(),Proprio.getStature(),Proprio.getType());
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
		if(moi.statut == "debout"){
			moi.x = ev.localX;
			moi.y = ev.localY + 20;
			moi.setX2D(moi.x);
			moi.setY2D(moi.y);
			getVue().Proprio.setX2D(moi.x);
			getVue().Proprio.setY2D(moi.y);
		}else{
			if(ev.ctrlKey == true){
				moi.x = ev.localX;
				moi.y = ev.localY + 20;
				moi.setX2D(moi.x);
				moi.setY2D(moi.y);
				getVue().Proprio.setX2D(moi.x);
			getVue().Proprio.setY2D(moi.y);
				if(moi.chaise != null){
					moi.chaise.occupe = false;
				}
				moi.changerStatut("debout");
				
			}
		}
	}

	}else if(statut == "chaise"){
		var chaise:Chaise2D = ajoutChaise(x,y,false);
		/*var chaise:Chaise2D = new Chaise2D(x,y);
		ev.target.addChild(chaise);
		chaise.name = "chaise";*/
		chaise.addEventListener(MouseEvent.CLICK,objet_clicked);
	}else if(statut == "table"){
		var table:Table2D = ajoutTable(x,y,10,10);
		/*var table:Table2D = new Table2D(x,y);
		table.name = "table";
		ev.target.addChild(table);*/
		table.addEventListener(MouseEvent.CLICK,objet_clicked);
	}
   }
	
		
	
	
	
	private function vueLoadedFunc():void{
		if(getVue() == null){
			vueLoaded = setInterval(vueLoadedFunc, 500);
		}else{
			clearInterval(vueLoaded);
			for(var i:Number = 0; i < getVue().ListeActeur.length; i++){
			if(getVue().ListeActeur[i].getClass() == "personne"){
				var a:Avatar2D = new Avatar2D(getVue().ListeActeur[i].nom,getVue().ListeActeur[i].x2D,getVue().ListeActeur[i].y2D,getVue().ListeActeur[i].angleAbsolu,getVue().ListeActeur[i].statureAvatar,"M");
				//up.addChild(a);
				a.infoBule.rotation = - getVue().ListeActeur[i].angleAbsolu;
				listePersonne.push(a);
			}else if(getVue().ListeActeur[i].getClass() == "table"){
			
			}else if(getVue().ListeActeur[i].getClass() == "chaise"){
			
			}
		} 
		
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
		   	obj.angleVue = obj.rotation;
		   	obj.setAngleAbsolu(obj.rotation);
		   	getVue().Proprio.setAngleAbsolu(obj.rotation);
		   	if(obj.getClass() == "avatar2D"){
		   		obj.infoBule.rotation = -obj.rotation;
		   	}
		   //	var p:Prompt = new Prompt("<orientation  pseudo='"+obj.getName()+"'><angle>"+obj.getAngleAbsolu()+"</angle></orientation>");
		   	//addChild(p);
		   	if(obj.getClass() == "avatar2D"){
		   		(Vue)(parent).client.send("<orientation  pseudo='"+obj.getName()+"'><angle>"+obj.getAngleAbsolu()+"</angle></orientation>"); 
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
		   
		   
		   public function CallBackAjoutPersonnage(newpers:Personne):void{
		   	/*var pp:Prompt = new Prompt("eltaf");
		   	inte += 5;
		   	pp.x += inte;
		   	addChild(pp);*/
		   	var p:Avatar2D = new Avatar2D(newpers.getName(),newpers.getX2D(),newpers.getY2D(),newpers.getAngleAbsolu(),"debout",newpers.getType());
		   	listePersonne.push(p);
		   	addChild(p);
		   	menuActif = new MenuPersonne(down.width + down.x + 5,down.y,listePersonne);
			addChild(menuActif);
		   }
		   
		   public function CallBackSuppPersonnage(i:Number):void{
		   	up.removeChild(listePersonne[i]);
   			for(var j:Number = i; j < getVue().ListePersonne.length - 1; j++){
   				getVue().ListePersonne[j] = getVue().ListePersonne[j+1];
   			}
   			removeChild(menuActif);
   			getVue().ListePersonne.pop();
		   	menuActif = new MenuPersonne(down.width + down.x + 5,down.y,listePersonne);
			addChild(menuActif);
		   }
		   
		   public function CallBackPosition(newpers:Personne):void{
		   
		   /*	for(var i:Number = 0; i < getVue().ListeActeur.length; i++){
		   		if(getVue().ListeActeur[i].getName() == newpers.getName() && getVue().ListeActeur[i].getClass().toLowerCase() == "personne"){
		   			getVue().ListeActeur[i].setX2D(newpers.getX2D());
		   			getVue().ListeActeur[i].setY2D(newpers.getY2D());
		   			break;
		   		
		   	}*/
		   	var p:Prompt = new Prompt(newpers.getX2D().toString() + "  " + newpers.nom);
		   	addChild(p);
		   	for(var i:Number = 0; i < listePersonne.length; i++){
		   		
		   		if(listePersonne[i].nom == newpers.getName()){
		   			listePersonne[i].setX2D(newpers.getX2D());
		   			listePersonne[i].setY2D(newpers.getY2D());
		   			listePersonne[i].x = newpers.getX2D();
		   			listePersonne[i].y = newpers.getY2D();
		   			listePersonne[i].bouttonConcernant.D2 = [newpers.getX2D(),newpers.getX2D()];
		   			break;
		   		}
		   	}
		   }
		   
		   public function CallBackOrientation(newpers:Personne):void{
		   	var p:Prompt = new Prompt("eltaf   " + newpers.getAngleAbsolu());
		   	inte += 5;
		   //	addChild(p);
		   	
		   	for(var i:Number = 0; i < listePersonne.length; i++){
		   		if(getVue().ListeActeur[i].getClass().toLowerCase() == "personne"){
			   		if(getVue().ListeActeur[i].nom == newpers.getName()){
			   			getVue().ListeActeur[i].setAngleAbsolu(newpers.getAngleAbsolu());
			   			break;
			   		}
			   	}
		   	}
		   	
		   	for(var i:Number = 0; i < listePersonne.length; i++){
		   		if(listePersonne[i].nom == newpers.getName()){
		   			listePersonne[i].setAngleAbsolu(newpers.getAngleAbsolu());
		   			listePersonne[i].rotation = newpers.getAngleAbsolu();
		   			break;
		   		}
		   	}
		   }
		   
		   public function ajoutTable(x:Number,y:Number,longueur:Number,hauteur:Number):Table2D{
		   	var table:Table2D;
		   	table = new Table2D(x,y,longueur,hauteur);
		   	numImmeubilier++;
		   	table.nom = "imm" + numImmeubilier;
		   	up.addChild(table);
		   	//getVue().ListeActeur.push(table);
		   	return table;
		   }
		   
		   public function ajoutChaise(x:Number,y:Number,o:Boolean):Chaise2D{
		   	var chaise:Chaise2D;
		   	chaise = new Chaise2D(x,y,0,o);
		   	numImmeubilier++;
		   	chaise.nom = "imm" + numImmeubilier;
		   	up.addChild(chaise);
		   	//getVue().ListeActeur.push(chaise);
		   	return chaise;
		   }
		   
		   public function suppImmeubilier(obj:Object):void{
		   	for(var i:Number = 0; i < getVue().ListeActeur.length; i++){
		   		if(getVue().ListeActeur[i].nom == obj.nom){
		   			up.removeChild(getVue().ListeActeur[i]);
		   			for(var j:Number = i; j < getVue().ListeActeur.length - 1; j++){
		   				getVue().ListeActeur[j] = getVue().ListeActeur[j+1];	
		   			}
		   			break;
		   			
		   		}
		   	}
		  
		   	getVue().ListeActeur.pop();
		   }
		   
		   public function ajoutPersonne(pers:Personne):void{
		   	//var a:Avatar2D = new Avatar2D(pers.getName(),pers.getX2D(),pers.getY2D(),pers.getAngleAbsolu(),pers.getStature(),pers.getType());
		   	var a:Avatar2D = new Avatar2D(pers.nom,pers.getX2D(),pers.getY2D(),pers.getAngleAbsolu(),pers.getStature(),pers.getType());
		   	up.addChild(a);
		   	listePersonne.push(a);
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