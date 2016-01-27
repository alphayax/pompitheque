# Index du groupe 6 #


[Rapport du groupe 6](Groupe6Rapport.md)


## Organisation ##

[Répartition des taches](Groupe6Orga.md)

## Travail réalisé ##

### Client ###
#### Description ####
Nous avons développé une partie de l'application client en action script.
Dans cette dernière, nous avons crée une classe qui permet de faire toutes les connexions avec le serveur.

#### Utilisation ####
##### Inclusion du paquet #####
Nous avons un fichier `Client.as`.
Ce dernier va dans un package que nous avons nommé `chat`.

Les sources Client se trouvent ici : http://www.arcatys.com/pompitheque/dev/Groupe6/

Une fois rajouté au projet, il suffira de faire la commande suivante pour l'inclure dans le code
```
import chat.*
```

##### Création et connexion du client #####
On appelle une instance de la classe Client.
Les paramètres sont :
  * le numéro du micromonde
  * le login de l'utilisateur
Ces parametres sont récupérés a partir du portail (nous le gerons)
```
var clt:Client = new Client(srv,nom);
```

##### Envoi des données #####
Pour envoyer les données, on utilise la méthode publique send(data);
On passe comme données des chaînes de caractères ou directement un format XML
```
clt.send(data:DataEvent);
```

##### Réception des données #####
Pour récupérer des données, on associe une fonction à l'évènement `DataEvent.DATA` (se déclenche quand des données arrivent).
```
// Redirection des données depuis la socket vers la méthode `write`
clt.getSocket().addEventListener(DataEvent.DATA,write);   

// Réception les messages entrant par la socket grace au Listener DataEvent de la socket (XMLSocket)
public function write(data:DataEvent):void
{
 // Traitement des données
 // Appel des fonction adéquates en fonction des types de message
 // Confere format des données en XML(WIKI)
}
```

### Phases de test ###
  * Tests de montée en charge : 300 utilisateurs connectés simultanément -> OK
  * Tests des différents navigateurs : Opéra, IE6, IE7, Firefox -> OK
  * Tests des systèmes d'exploitation : Windows, Linux (Ubuntu) -> OK