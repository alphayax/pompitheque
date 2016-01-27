# Rapport du Groupe 6 #

### Assignations ###
  * **Ponzoni Yann** : _Chef de projet_
  * **Martoglio Yoann**
  * **Verheye Fabien**


## Mission ##
**Objectifs** : Construction d'un module de gestion des communications qui s'intègrera dans une application flash.

**Solution envisagée** :
Afin de résoudre ce problème nous avons décidé d'utiliser une architecture client-serveur.
Les clients seront des objets Flash intégrés sur des pages Web.
Le serveur sera une application Java hébergé sur un serveur accessible en permanence.

Par la suite, nous allons détailler les deux principaux composants que nous allons développer.


## Le serveur ##

  * ### Présentation du problème ###

L'application Flash en cours de développement est un logiciel permettant aux différents utilisateurs de communiquer entre eux. Pour permettre aux utilisateurs de dialoguer, notre application doit posséder une structure qui lui permet d'envoyer et de recevoir des messages. Cette structure fait défaut à l'heure actuelle.

  * ### Solution envisagée ###

Pour pouvoir remédier à cela, nous allons développer un serveur permettant la communication entre les clients.
L'application flash que chaque utilisateur utilise pour communiquer constituera le client.
Le programme que nous allons créer pour gérer les communications constituera le serveur.

  * ### Contraintes ###

Dans un souci de ne pas s'écarter du but initial du serveur, il est important de récapituler ici les principales fonctions demandées.
- Le serveur doit attendre les connexion des clients pour les faire rentrer dans le monde.
- Le serveur doit pouvoir recevoir un message d'un client et l'envoyer à un autre client. (voire des autres clients)
- Le serveur doit pouvoir détecter la déconnexion (manuelle ou intempestive) des utilisateurs.

  * ### Implémentation ###

Le serveur sera codé dans un langage lui permettant une réactivité rapide, une stabilité fiable et une portabilité entre différentes architectures et systèmes d'exploitation. Pour cela, nous avons choisi Java.

  * ### État d'avancement du travail ###

Le serveur fonctionne parfaitement. Il reçoit, identifie et connecte les clients qui arrivent. Il détecte également les déconnexions.
Actuellement, nous travaillons sur les différentes commandes qui pourra reconnaître le serveur. De plus en parallèle, nous avons commencé a intégrer les modules des autres groupes.

## Le client ##

  * ### Présentation du problème ###

L'application Flash finale doit permettre de communiquer. Cependant étant encore en phase de développement au travers des autres groupes, elle ne permet pas de vérifier le bon fonctionnement du serveur.

  * ### Solution envisagée ###

Dans un premier temps, nous allons développer une application légère en Flash qui permettra d'effectuer nos test avec le serveur. Par la suite, nous allons compléter ce module pour en faire une partie intégrante de l'application Flash finale.

  * ### Contraintes ###

Ce module se fera en Flash.
Cela est un impératif dans la mesure où le projet initial est en flash.

  * ### Implémentation ###

Comme expliqué plus haut, ce module se fera en Flash.
Pour ce qui est de la version exacte, cela dépendra du choix collectif avec les autres groupes, mais il est important de noter que dans sa version 9, le Flash offre de nombreuses possibilités intéressantes. De plus, à l'heure actuelle, il est supporté par tous les navigateurs et tous les Système d'exploitation.
Enfin, grace aux XMLsocket, la communication entre Flash et un serveur se trouve grandement facilité.

  * ### État d'avancement du travail ###

Le client est fonctionnel. Il se connecte correctement au serveur et récupère les données dont il a besoin. Il peut également envoyer et recevoir des messages.
Nous concentrons nos efforts sur l'intégration avec les autres groupes.

## Le portail ##

  * ### Présentation du problème ###
Les utilisateurs qui veulent utiliser notre projet doivent avoir un point d'entrée. Ce dernier permettra d'afficher l'application cliente Flash et d'établir les connexions entre ces derniers.

  * ### Solution envisagée ###
Dans un premier temps nous allons créer une page PHP qui attaquera la base de données SQlite pour afficher les diverses informations des micromondes. Cette dernière sera placé sur un serveur Apache qui contiendra également les données nécessaires à l'application.

  * ### Contraintes ###
Appel de l'objet flash avec des paramètres.

  * ### Implémentation ###
PHP/SQlite

  * ### État d'avancement du travail ###
Le portail est terminé et fonctionnel. Il est accessible a l'adresse : http://www.arcatys.com/pompitheque/