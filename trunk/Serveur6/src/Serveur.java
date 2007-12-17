import java.net.*; //reseau
import java.io.*;  //entrees - sorties
import java.util.*;//vector ...
/*
 * Serveur
 * 
 * */
public class Serveur
{
  private Vector m_vClient; // output des sockets clients
  private Vector m_vThreadClient; // thread des clients
  
  Serveur(){
	  m_vClient =new Vector(5);
	  m_vThreadClient = new Vector(5);
	  
	  for(int i=0;i<5;i++){
		  m_vClient.add(new HashMap());  
	  }
	  
	  for(int i=0;i<5;i++){
		  m_vThreadClient.add(new HashMap());  
	  }
  }
  
  /*
   * Le main ()
   * */
  public static void main(String args[])
  {
    Serveur srv = new Serveur(); // instance de la classe principale

    try
    {
      Integer port;
      if(args.length<=0) 
    	  port = new Integer("18000"); // port par default
      else 
    	  port = new Integer(args[0]); // ou specifie en argument

      new Commande(srv); // lance le thread de gestion des commandes

      ServerSocket sock = new ServerSocket(port.intValue()); // ouverture d'un socket serveur sur port
      startDisplay(port);

      // lancement du deamon
      while (true){
    	// Creation d'un thread si la connexion
    	// est accepté par le socket
        new ThreadClient(sock.accept(),srv); 
      }
    }
    catch (Exception e) { }
  }

  /*
   * Message accueil
   * 
   * */
  static private void startDisplay(Integer port)
  {
    System.out.println("Serveur MicroMonde en route");
  }


  /*
   * Envoi a tous le monde
   * 
   * */
  synchronized public void sendAll(String message,String sLast,int srv)
  {
	  
	if(!message.contains("<policy-file-request/>")){
		System.out.println(message);
	    PrintWriter out;
	    
	    // pour chaque client on envoi le message
	    HashMap buff = (HashMap)m_vClient.get(srv);
	    Iterator it = buff.values().iterator();
	    
	    while(it.hasNext()){
	    	out = (PrintWriter) it.next();
	    	out.print(message+sLast);
	    	out.flush();
	    }
	}
  }
  
  /*
   * envoi à une seul personne
   * 
   * */
  synchronized public boolean sendTo(String message,String pTo,int srv)
  {
		System.out.println("privée"+message);
	   
	    HashMap buff = (HashMap)m_vClient.get(srv);
	    if(buff.containsKey(pTo)){
		    PrintWriter out = (PrintWriter)buff.get(pTo);
		    
		    out.print(message+"\u0000");
		    out.flush();
		    return true;
	    }else{
	    	return false;
	    }


  }
  
  synchronized public String sendUsersDefinitions(int srv)
  {
	    ThreadClient out;
    
	    String definitions = "<users>";
	    // pour chaque client on envoi le message
	    HashMap buff = (HashMap)m_vThreadClient.get(srv);
	    Iterator it = buff.values().iterator();
	    
	    while(it.hasNext()){
	    	
	    	out = (ThreadClient) it.next();
	    	definitions += "<user pseudo='"+out.m_sNom+"'>";
	    	definitions +="<x>"+out.m_x+"</x>";
	    	definitions +="<y>"+out.m_y+"</y>";
	    	definitions +="<orientation>"+out.m_orientation+"</orientation>";
	    	definitions +="<stature>"+out.m_stature+"</stature>";
	    	definitions +="<type>"+out.m_type+"</type>";
	    	definitions +="</user>";
	    	
	    }
	    definitions += "</users>";
	    
	    return definitions;
  }
  
    
  
  /*
   * 
   * */
  synchronized public void delClient(String nom,int index)
  {
      HashMap buff = (HashMap)m_vClient.get(index);
      if(buff.containsKey(nom)){
    	  buff.remove(nom);  
      }
      HashMap buff2 = (HashMap)m_vThreadClient.get(index);
      if(buff.containsKey(nom)){
    	  buff2.remove(nom);  
      }
   }

  /*
   * 
   * */
  synchronized public boolean addClient(PrintWriter out,ThreadClient tc,String pNom,int nSrv)
  {
    try{
        if(m_vClient.get(nSrv) != null){
        	System.out.println("nouveau MicroMonde " + nSrv);
        	System.out.println(pNom + " rejoint le MicroMonde " + nSrv);
        	HashMap buff = (HashMap)m_vClient.get(nSrv);
        	buff.put(pNom, out);
        	
        	HashMap buff2 = (HashMap)m_vThreadClient.get(nSrv);
        	buff2.put(pNom,tc);
        	
        }else{
        	System.out.println(pNom + " rejoint le MicroMonde " + nSrv);
        	HashMap buff = new HashMap();
        	buff.put(pNom,out);
        	m_vClient.add(nSrv,buff);
        	
        	HashMap buff2 = new HashMap();
        	buff2.put(pNom,tc);
        	m_vThreadClient.add(nSrv,buff2);
        	
        	
        }

        return true;
    }catch (Exception e){ System.out.println("Aprs"+e.toString());return false;}

    
  }

  /*
   * 
   * */
  synchronized public int getNbClients(int nSrv)
  {
	HashMap buff = (HashMap) m_vClient.get(nSrv);
    return buff.size();
  }

}
