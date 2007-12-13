package chat
{
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.XMLSocket;
	import flash.system.Security;
	import flash.utils.Timer;

	public class Client extends Sprite
	{
    	protected var socket:XMLSocket; // socket pour la connexion au serveur
		protected var host:String;      // nom du serveur
		protected var port:Number;      // numero de port pour la connexio
		protected var srv:String;       // numero du serveur de discussion
		protected var nom:String;       // nom du client
		
		// timer for detecting not answering policy-requests
		protected var timer:Timer;
		
		
		/*
		 * Constucteur
		 */
		public function Client(nSrv:String = "",sNom:String = ""):void
		{
			  //initialisation 
				port = 18000;
				host = 'www.yrka.hd.free.fr';
		        srv  = nSrv;
		        nom  = sNom;	 // Pour palier a certaine erreur de securite lie
		      // au different navigateur, Internet Explorer en particulier,
		      // nous mettons en place un timer permettant de demander une connexion
		      // en boucle jusqu'a ce que cela marche
			timer = new Timer(2000, 1);
			
			// on appelle onTimer quand l'evenement TimerEvent est lancer
			timer.addEventListener(TimerEvent.TIMER, onTimer);

			tryConnect();

		}
		
		
		/*
		 *
		 *
		 */
		protected function tryConnect():void
		{
          //creation de la socket 
	      //demande du crossdomain.xml (pour la sécurité des communication inter-domaine
			socket = new XMLSocket();
			Security.allowDomain(host);
			Security.loadPolicyFile("http://"+host+"/crossdomain.xml");
			
			
			//redirection des erreurs sur la fonction on
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			// onData sera appeler lorsque des données arrive au client
			// on peux relier l'evenement avec n'importe quel fonction
			//socket.addEventListener(DataEvent.DATA, onData);
			
		
			// lorsque que l'on est connecte
			socket.addEventListener(Event.CONNECT, onConnect);
			socket.addEventListener(Event.CLOSE, onClose);
			// erreur d'entree-sortie
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			// connection
			socket.connect(host, port);
			
		}
		
		
		/*
		 * Renvoi l'instance de XMLSocket client, permet de relier 
		 * l'evenement DataEvent a une fonction exterieur a la classe Client
		 */
		public function getSocket():XMLSocket{return socket;}

		protected function onSecurityError(e:SecurityErrorEvent):void
		{
			portClosed();
			timer.reset();
			timer.start();
		}
		
		protected function onConnect(e:Event):void
		{
  		send("/name " + nom);
		  send("/server:" + srv);
		  	  
			portOpen();
		}
		
		protected function onClose(e:Event):void
		{
		  send(nom +" est déconnecté");
		}
		
		protected function onIOError(e:Event):void
		{
			portClosed();
		}
		
		protected function onTimer(e:TimerEvent):void
		{
			portOpen();
		}
		


		public function onData(event:DataEvent):String
		{
			return event.data;
		}
	

		protected function portOpen():void
		{
		  //appel de la fonction javascript reportResult suivi des parametre
			//ExternalInterface.call('reportResult', port, "true");
		}
		
		protected function portClosed():void
		{
		  //on remet le timer a 0
			timer.reset();
		  //appel de la fonction javascript reportResult suivi des parametre
			//ExternalInterface.call('reportResult', port, "false");
		}
		
		public function send(data:String):void
		{
			//var xml:XML = new XML("<message from='"++"' to='"++"' >"+data+"</message>");
			
			socket.send(data+"\u0000");
		}
	}
}
