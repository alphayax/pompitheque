# Encodage des documents #
L'encodage de tous les fichiers doit être en **UTF8**

# Format des données #
Afin de communiquer entre les divers modules de l'application, nous avons besoin d'une norme concernant les données.
Nous pouvons distinguer trois types de données:
  * Les messages
    * Cette donnée est envoyée au serveur sur demande de l'utilisateur (envoie d'un message)
    * Le serveur la retourne aux utilisateurs spécifiés (par défaut, tout le monde).
  * Les Utilisateurs
    * Cette donnée évolue en permanance si l'utilisateur se déplace ou change d'orientation.
    * Elle est envoyée au serveur a chaque changement.
  * La salle et le mobillier
    * Stoquée sur le serveur ces données seront envoyées uniquement à la connexion d'un client

## Format de données pour les messages ##
Le message envoyé possède un destinataire et un expéditeur
```
<message from="toto" to="titi">Mon message privé</message>
```
si le destinataire est "all", le message s'enverra à tout le monde
```
<message from="toto" to="all">Hi folks !</message>
```
On peut aussi envoyer des wizz (pour la version 2 ?)
```
<message from="tata" to="brice" wizz="wizz">G't KC !</message>
```
Le wizz permet d'interpeller un autre utilisateur. Pour l'instant il n'y aura qu'un seul type de wizz mais plusieurs types peuvent être envisager:

  * important!
  * "je veux te parler en priver"
  * ect...

**Il n'y a pas de format de fichier pour les files de messages**

## Format de données pour les utilisateurs ##
```
<user pseudo="toto">
   <x>1</x>
   <y>2</y>
   <orientation>90</orientation>
   <stature>debout</stature>
   <type>pocahontas</type>
</user>
```


## Format de données pour la salle et le mobilier ##
```
<plan>
  <salle>
    <mur x1="2.00" y1="2.00" x2="18.00" y2="2.00" />
    <mur x1="18.00" y1="2.00" x2="18.00" y2="17.00" />
    <mur x1="18.00" y1="17.00" x2="2.00" y2="17.00" />
    <mur x1="2.00" y1="17.00" x2="2.00" y2="2.00" />
    <angle x="18" y="2" posPanorama="17" />
    <angle x="18" y="17" posPanorama="726" />
    <angle x="2" y="17" posPanorama="1436" />
    <angle x="2" y="2" posPanorama="2145" />
  </salle>
  <mobilier>
    <table x="4.50" y="5.00" orientation="0" />
    <table x="10.77" y="4.97" orientation="0" />
    <chaise x="4.70" y="3.93" orientation="0" />
    <chaise x="2.77" y="5.20" orientation="0" />
    <chaise x="4.90" y="6.63" orientation="0" />
    <chaise x="11.20" y="3.87" orientation="0" />
    <chaise x="13.20" y="5.30" orientation="0" />
    <chaise x="11.43" y="6.87" orientation="0" />
  </mobilier>
</plan>
```

# Communication avec le serveur #

## Demande du plan et de la liste ##
Message envoyer par la vue au serveur pour demander la liste des personnes et le plan
```
<demande nom="nomduserveur" />
```

## Liste des personnes ##
Message recu par le serveur lors de la creation de la vue
```
<users>
 <user pseudo="zorro">
   <x>1</x>
   <y>2</y>
   <orientation>90</orientation>
   <stature>debout</stature>
   <type>pocahontas</type>
 </user>
 <user pseudo="zorrette">
   <x>2</x>
   <y>1</y>
   <orientation>50</orientation>
   <stature>debout</stature>
   <type>pocahontas</type>
 </user>
</users>
```

## Nouvelle personne qui se connecte ##
Message envoyé/recu qd une nouvelle personne se connecte dans le monde.

Le message est envoyer dans la vue2D une fois que la personne choisi sa position pour la premiere fois
```
<newpers pseudo="zorro">
   <x>1</x>
   <y>2</y>
   <orientation>90</orientation>
   <stature>debout</stature>
   <type>pocahontas</type>
</newpers>
```

## Personne deconnecté ##
Message envoyé/recu qd un client se deconnecte
```
<deco pseudo="zorro" />
```

## Nouvelle position d'une personne ##
Message envoyé/recu qd une personne se deplace.

Le message est envoyer dans la vue2D quand la personne a choisi sa nouvelle position, si la personne se place sur une chaise alors sa stature change
```
<position pseudo="zorro">
   <x>5</x>
   <y>5</y>
   <stature>assis</stature>
</position>
```

## Nouvel angle d'une personne ##
Message envoyé/recu qd une personne tourne sur elle meme.

Le message est envoyer dans la vue3D a chaque fois qu'un personne tourne a droite ou a gauche
```
<orientation pseudo="zorro">
 <angle>90</angle>
</orientation>
```