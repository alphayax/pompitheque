# Nouvelles fraîches #

Pour que tous le monde puisse connaître les ajouts (ou modifications) les plus importants, dans cette page, chacun fera un bref résumé avec la date d’ajout et un lien comme ceci :

  * **16/12 par Grollemund :** Des nouvelles du front : Intégration

- La communication avec le serveur et la pompitheque est fonctionnelle du coté Pompitheque, coté Serveur il reste la gestion de 2 3 messages et c'est reglé : le groupe6 est au courant et s'en occupe ca devrait etre reglé pour la presentation

- La creation de la vue (si le serveur est lancer seulement) se fait parfaitement

- Dans la vue 3D :
> - Le panorama ne s'affiche pas, on est en train de regarder et d'essayer de reglé le probleme

> - La table est deformé c'est en travaux aussi ca devrait etre fini pour jeudi (mais c'est un pb independant de l'intégration)

- Dans la vue 2D :
> - Le chargement du plan ne fait pas afficher les tables

> - Lorsque le proprio tourne dans la vue 3D ce n'est pas mis a jour dans la vue 3D

> - Verifier la liste et l'affichage des personne dans la grille lorsque le probleme avec le message User sera reglé sur le serveur
- Les messages : Lorsqu'on clic sur un perso, censé afficher l'interface de discussion on a une erreur : le groupe5 est au courant et doit s'en occupé

La version finale est donc sur le SVN dans le repertoire Pompitheque6 et jai aussi uploader le serveur (necessaire pour les test) dans le repertoire Serveur6
Pour lancer le serveur : java -classpath serveur.jar Serveur
Modifier si besoin la classe Client avec l'adresse IP ('localhost' si vous faites tourner le serveur et le client sur votre machine) et verifier que le port n'est pas bloquer

Voila

  * **02/12 par Grollemund :** Upload de la derniere version de la pompitheque version groupe4

> Important pour le groupe 5 (gestion des message) la classe **Personne** contient une fonction **message(destinataire:String)** : c'est la fonction appeler sur le proprietaire lorsqu'on clique sur une personne, destinataire est le nom de la personne cliqué.

  * **28/11 par Grollemund :** Mise a jour des formats de données

> [Format des données](http://code.google.com/p/pompitheque/wiki/CommunFormat)

  * **15/11 par Clairon :** Proposition de correction de problème pour SVN

> J'ai mis la solution dans http://code.google.com/p/pompitheque/issues/detail?id=3 il faut utiliser les issues pour discuter des problèmes que l'on rencontre...

  * **13/11 par Grollemund :** Mise a jour du diagramme de classe

> [Diagramme de classe](http://code.google.com/p/pompitheque/wiki/CommunDiagClass)

  * **13/11 par Grollemund :** Toujours des problemes avec le SVN

> On arrive toujours pas a faire nos upload (sous windows du moins) ca donne ca :

> http://pompitheque.googlecode.com/svn/trunk/commun/pb_svn.JPG
> Ya une debut de reponse ici http://taylorsystems.us/blog/2006/09/subversion-reported-error-while-doing.html mais j'arrive a rien. Ce message devrait se trouver dans les issues mais personne ne les lit, on aura peut etre plus de chance ici...



  * **03/11 par Douziech :** Ajout d’une barre d’avancement

> [Avancement des groupes](http://code.google.com/p/pompitheque/wiki/communAvancement)



  * **29/10 par Grollemund :** Ajout du diagramme de Classe

> [Diagramme de classe](http://code.google.com/p/pompitheque/wiki/CommunDiagClass)