import java.net.*;
import java.io.*;

import org.w3c.dom.*;
import org.xml.sax.*;
import javax.xml.parsers.*;


/*
 * 
 * 
 * 
 * */
class ThreadClient implements Runnable
{
  private Thread         m_thread;        // thread client
  private Socket         m_socket;        // socket connecter au client
  private PrintWriter    m_fluxOut;       // flux sortie
  private BufferedReader m_fluxIn;        // flux entree
  private Serveur        m_serveur;       // instance du serveur
  //private int            m_nClient=0;     // numero identifiant le client
  public String    	     m_sNom = "";     // nom du client connecte
  private int            m_nServeur = -1; //nom du micromonde
  public int			 m_x;
  public int			 m_y;
  public int			 m_orientation = 0;
  public String			 m_stature = "debout";
  public String			 m_type = "pocahontas";
  
  
  ThreadClient(Socket s, Serveur srv) 
  {
    m_serveur = srv;
    m_socket  = s; 
    try
    {
      // instanciation du flux de sortie (on recupere celui du socket client)
      m_fluxOut = new PrintWriter(m_socket.getOutputStream());
      // idem mais pour la sortie
      m_fluxIn = new BufferedReader(new InputStreamReader(m_socket.getInputStream()));
      // ajout du flux de sortie pour ce thread client dans le serveur
      
    }
    catch (IOException e){ }

    m_thread = new Thread(this); // instanciation du thread
    m_thread.start();
  }
  
  public boolean insert(){
	  boolean ok = m_serveur.addClient(m_fluxOut,this,m_sNom,m_nServeur);
	  return ok;
  }
  
  
  
  public boolean isCommande(String cmd){
	  
	  //si ça commence pas par / c'est pas une commande
	  if(cmd.charAt(0) != '/' && cmd.charAt(0) != '<') return false;
	  
	  
	  if(cmd.charAt(0) == '<'){
		  if (cmd.startsWith("<demande")){
			  
			  //envoi de la liste des users au client
			  m_fluxOut.print(m_serveur.sendUsersDefinitions(m_nServeur)+ "\u0000");
			  m_fluxOut.flush();
			  
			  BufferedReader plan = null;
			  String ligne ="";
			  String Leplan ="";
			    try{
			    	plan = new BufferedReader(new FileReader(System.getProperty("user.dir")+"/world/"+m_nServeur+"/topo.xml"));
			    }
			    catch(FileNotFoundException exc){
			    	System.out.println("Erreur d'ouverture");
			    }
			    //lecture du plan
			    try {
					while ((ligne = plan.readLine()) != null)
						Leplan += ligne;
				} catch (IOException e) {
					e.printStackTrace();
				}
				//fermeture du fichier
			    try {
					plan.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				//envoi du plan au client
				m_fluxOut.print(Leplan + "\u0000");
				m_fluxOut.flush();
				
				return true;
		  }
		  if(cmd.startsWith("<message"))
		  {
			  String xml = cmd;
			  try{
				  DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
				  Document document= parser.parse(new InputSource(new StringReader(xml)));
				  Element root = document.getDocumentElement();
				  
				  String to = root.getAttribute("to");
				  
				  if(to.equalsIgnoreCase("all"))
					  m_serveur.sendAll(cmd, "\u0000", m_nServeur);
				  else
					  m_serveur.sendTo(cmd, to, m_nServeur);
			  }
			  catch (Exception e){} 
			  return true;
		  } 
		  if(cmd.startsWith("<user") || cmd.startsWith("<newpers"))
		  {
			  String xml = cmd;
			  try{
			  DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			  Document document= parser.parse(new InputSource(new StringReader(xml)));
			  Element root = document.getDocumentElement();
			  
			  NodeList liste= root.getElementsByTagName("x");
			  Element e = (Element) liste.item(0);
			  m_x= Integer.parseInt(e.getTextContent());
			  
			  liste= root.getElementsByTagName("y");
			   e = (Element) liste.item(0);
			  m_y= Integer.parseInt(e.getTextContent());
			  
			  liste= root.getElementsByTagName("stature");
			   e = (Element) liste.item(0);
			  m_stature= e.getTextContent();
			  
			  liste= root.getElementsByTagName("orientation");
			   e = (Element) liste.item(0);
			   m_orientation= Integer.parseInt(e.getTextContent());
			  
			  liste= root.getElementsByTagName("type");
			   e = (Element) liste.item(0);
			   m_type= e.getTextContent();
			  
			  
			  m_serveur.sendAll(cmd, "\u0000", m_nServeur);
			  }
			  catch (Exception e){} 
			  return true;
		  }
		  if(cmd.startsWith("<position"))
		  {
			  String xml = cmd;
			  try{
			  DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			  Document document= parser.parse(new InputSource(new StringReader(xml)));
			  Element root = document.getDocumentElement();
			  
			  NodeList liste= root.getElementsByTagName("x");
			  Element e = (Element) liste.item(0);
			  m_x= Integer.parseInt(e.getTextContent());
			  
			  liste= root.getElementsByTagName("y");
			   e = (Element) liste.item(0);
			  m_y= Integer.parseInt(e.getTextContent());
			  
			  liste= root.getElementsByTagName("stature");
			   e = (Element) liste.item(0);
			  m_stature= e.getTextContent();
			 
			  System.out.println("mais lol");
			  m_serveur.sendAll(cmd, "\u0000", m_nServeur);
			  }
			  catch (Exception e){} 
			  return true;
		  }
		  if(cmd.startsWith("<orientation"))
		  {
			  String xml = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>" +cmd;
			  try{
			  DocumentBuilder parser = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			  Document document= parser.parse(new InputSource(new StringReader(xml)));
			  Element root = document.getDocumentElement();
			  NodeList liste= root.getElementsByTagName("angle");
			  Element e = (Element) liste.item(0);
			  m_orientation= Integer.parseInt(e.getTextContent());
			  m_serveur.sendAll(cmd, "\u0000", m_nServeur);
			  }
			  catch (Exception e){System.out.println("exception");} 
			  return true;
		  }
		  
	  }
	  
	  cmd = cmd.substring(1);
	  
	  	  
	  if (cmd.startsWith("server") && m_nServeur == -1){
		  
		  /* TODO envoi de la chaine XML du niveau demander*/
		  String[] buffer;
		  buffer = cmd.split(":");
		  m_nServeur = Integer.parseInt(buffer[1]) ;
		  if(insert()){
			  System.out.println("Un nouveau client s'est connecte, "+m_sNom);//no "+m_nClient
		  }
		  
		  return true;
	  }else if (cmd.startsWith("name")){
		  try{
			  System.out.println("yooooooooo");
			  String[] buffer;
			  buffer = cmd.split(" ");
			  m_sNom = buffer[1];
			  m_fluxOut.print("tu t'appel maintenant "+m_sNom+" \u0000");
			  m_fluxOut.flush();
		  }catch(Exception e){
			  m_fluxOut.print("Mauvais formatage de la commande /name : /name <nouveau_nom>");
			  m_fluxOut.flush();
		  }

		  return true;
	  }else if (cmd.startsWith("to")){
			  try{
				  String[] buffer;
				  buffer = cmd.split(" ");
				  String to = buffer[1];
				  int index = cmd.indexOf(buffer[1].toString());
				  
				  String message = cmd.substring(index+to.length());
				  

				  
				  if(m_serveur.sendTo(m_sNom + ">>" + buffer[1] + " "+message,buffer[1],m_nServeur)){
					  m_fluxOut.print(m_sNom + ">>" + buffer[1] + " "+message + "\u0000");
					  m_fluxOut.flush();
				  }else{
					  m_fluxOut.print(buffer[1] + " n'est pas connecté\u0000");
					  m_fluxOut.flush();
				  }
				  
			  }catch(Exception e){
				  m_fluxOut.print("Mauvais formatage de la commande /name : /name <nouveau_nom>");
				  m_fluxOut.flush();
			  }

			  
			  return true;
	  }else if (cmd.equals("quit")){
		  
		  try
	      {
	      	// deco
	        System.out.println("Le client "+m_sNom+ " s'est deconnecte");
	        m_serveur.sendAll(m_sNom + " s'est deconnecte", "\u0000", m_nServeur);
	        // supression du client
	        m_serveur.delClient(m_sNom,m_nServeur); 
	        // on ferme le socket du client
	        m_socket.close();
	      }
	      catch (IOException e){ }

		  return true;
	  }else{
		  m_fluxOut.print("commande non reconnue \u0000");
		  m_fluxOut.flush();
		  return true;
	  }
	  
	  

  }

  /*
   * executer lors du start() sur le thread
   * 
   * */
  public void run()
  {
    String message = "";
    // sortie serveur
    
    try
    {
      // lecture du message caractere par caractere
      char cCourant[] = new char[1];
      // attente de donnees client
      // /\
      ///! \  read() est bloquant
      while(m_fluxIn.read(cCourant, 0, 1)!=-1)
      {
    	
      	// si pas fin de message
        if (cCourant[0] != '\u0000' && cCourant[0] != '\n' && cCourant[0] != '\r'){
           message += cCourant[0];
        }
        else if(!message.equalsIgnoreCase(""))
        {
        	if(!isCommande(message)) m_serveur.sendAll(m_sNom+">"+message,"\u0000",m_nServeur);
        	message = "";
        }
      }
    }
    catch (Exception e){}
    //executer lors de la fermeture du thread
    finally
    {
      if(m_sNom != ""){
    	  m_serveur.sendAll(m_sNom+" est déconnecté","\u0000",m_nServeur);
    	  m_serveur.delClient(m_sNom,m_nServeur);
    	  
      }
    }
  }
}
