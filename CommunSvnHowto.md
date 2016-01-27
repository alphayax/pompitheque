# SVN Howto #

## Demarrage ##

Adresse du projet : http://code.google.com/p/pompitheque/

Mot de passe à générer sur : http://code.google.com/hosting/settings

puis

Connexion au serveur SVN :
```
svn checkout https://pompitheque.googlecode.com/svn/trunk/ pompitheque --username <votre username gmail (sans le @gmail.com)>
```

Url du repositery : https://pompitheque.googlecode.com/svn/trunk/


## SVN qu'est ce que c'est ? ##

Subversion (SVN) est un logiciel informatique de contrôle de version. Il reprend les principes de CVS mais en l'améliorant ( ex : copie et renommage de fichiers avec conservation de l'historique, commit atomiques, etc.).

Pour plus d'information : http://fr.wikipedia.org/wiki/Subversion_(logiciel)


## Comment ça fonctionne ? ##

Avant chaque session de travail on se connecte au serveur SVN et on télécharge les fichiers hébergés (commande « update »). On récupère ainsi au fur et à mesure les fichiers du projet pour travailler, chaque fichiers est la derniere version donc cela facilite la coordination.

Après avoir modifié des fichiers on fait un « commit », commande qui va envoyer les fichiers sur le serveur, va tester si le fichier n'a pas été modifié entre temps par un autre utilisateur et sinon va remplacer le fichier du serveur par votre version. Si le fichier a été modifié par un autre utilisateur pendant que vous travailliez dessus on recoit une alerte, on peut ainsi vérifier et mieux intégrer les versions des fichiers.
Si je dis pas de bêtises on peut aussi en cas de problèmes revenir sur une ancienne version d'un fichier.

Donc il faut penser à faire un update avant de commencer à travailler et de faire des commit fréquemment. C'est pas facile de prendre le réflexe au début mais vous verrez que c'est très pratique pour travailler en groupe.

## Installation ##


### Windows / LinuX / Mac OS / Solaris / etc... ###
Rendez vous sur cette page pour plus d'informations a propos des packages disponibles pour votre distribution :
http://subversion.tigris.org/project_packages.html

## Comment se connecter ? ##

Vous pouvez accéder au projet avec votre compte gmail. Si vous n'en avez pas, créez en un. Ensuite envoyez un mail à gnaitan@gmail.com ou à clairon@gmail.com afin que nous vous ajoutions à la liste des membres du projet.

### Sous Windows ###

Pour utiliser SVN sous windows je vous conseille le client tortoiseSVN (http://tortoisesvn.net/), téléchargez le et installez le. Il s'intègre automatiquement à Explorer. Puis créez un fichier qui contiendra les fichiers uploadés et downloadés sur le SVN et faites un clic droit dessus puis "SVN checkout", et entrez cette adresse : "https://pompitheque.googlecode.com/svn/trunk/ ". Un mot de passe va vous etre demandé, vous le trouverez dans la partie "source" du projet (http://code.google.com/hosting/settings plus précisément) et pour le login c'est votre username sur gmail.

Désormais à chaque fois que vous voudrez travailler sur le projet faites d'abord un « update » (clic droit sur le fichier -> SVN update).

Quand vous modifiez des fichiers ou rajoutez des fichiers vous devez faire un « SVN commit », vous sélectionnez les fichiers, rajoutez un commentaire et vous faite votre commit, les fichiers seront alors uploader sur le svn.

### Sous Linux ###

#### Installation (ubuntu / debian) ####
```
sudo apt-get install subversion subversion-tools
```

#### Utilisation ####

Première chose à faire : `svn update`. Cela va mettre à jour votre copie locale de l'arborescence.

Pour ajouter un fichier ou un dossier : `svn add monfichier`.

Pour voir les modifications effectués : `svn diff`. On peut voir les modifications d'un seul fichier `svn diff monfichier`.

Pour envoyer tout le joli travail sur le serveur : `svn commit -m "Groupe<N°dugroupe>: Mon message`.

Il existe aussi d'autre clients, vous pourrez trouver la liste ici : http://fr.wikipedia.org/wiki/Subversion_%28logiciel%29#Logiciels_clients

Et toujours : `svn --help` ou encore `svn update --help` ect...

## Les + de google code ##

A l'adresse du projet vous trouverez un Wiki qui vous permettra de postez vos doc et vos infos simplement et une gestion des issues (liste des problèmes rencontrés, un utilisateur peut trouvez une solution pour vous et la poster)