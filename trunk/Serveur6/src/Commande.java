import java.io.*;

/*
 * thread de reception des commandes serveur
 * 
 * */
class Commande implements Runnable
{
  Serveur        m_serveur;
  BufferedReader m_fluxIn; 
  String         m_sCmd="";
  Thread         m_thread;  


  Commande(Serveur srv)
  {
    m_serveur = srv; 
    m_fluxIn  = new BufferedReader(new InputStreamReader(System.in));
    m_thread  = new Thread(this);
    m_thread.start();
  }

  /*
   * 
   * */
  public void run()
  {
    try
    {
      // bloquant
      while ((m_sCmd=m_fluxIn.readLine())!=null)
      {
        if (m_sCmd.equalsIgnoreCase("exit")){
          // on tue le serveur
          System.out.println("Serveur Arrete");
          System.exit(0);
        }
        else if(m_sCmd.contains("count"))
        {
        	try{
        		String[] buffer = m_sCmd.split(" ");
                System.out.println(buffer[0]+":"+buffer[1] +"/"+ buffer.length);
                int nSrv = Integer.parseInt(buffer[1]);
                System.out.println(m_serveur.getNbClients(nSrv) + " client(s) sur le MicroMonde #" + nSrv);
        	}catch(Exception e){
        		System.out.println("Erreur, la commande est : count #serveur");
        	}
          
        }
        else
        {
          System.out.println("cette commande n'existe pas");
          System.out.println("Quitter : \"exit\"");
          System.out.println("Nombre de connectes : \"count\"");
          System.out.println("--------");
        }
        System.out.flush();
      }
    }
    catch (IOException e) {}
  }
}
