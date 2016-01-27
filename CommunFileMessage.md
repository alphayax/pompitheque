# Class FileMessage #

Cette file contient des [CommunMessage](CommunMessage.md) messages. Elle peut-être affichée, sérialisée...

```
class FileMessage:
    /******* Attributs publiques **********/
    string from;
    Message[];

    /******* Méthodes privée **********/
    genererTextField()

    /******* Méthodes publiques **********/
    void afficher(Point p1, Point p2, Point p3, Point p4)
    void setDestinaire()
    void add()
    void remove()
    string toXml()

```

## Attributs ##
**from**: Expediteur de la file

## Méthodes ##
**genererTextField**: Retrourne un TextField contenant tous les messages

**setDestinataire**: Positionne le destinataire afin d'afficher tout les messages pour le destinataire et non pas tout le monde (en a-t-on besoin ? Boulot fait par le serveur ?)

**afficher**: voir Groupe5Superposition

**toXml**: Sérialise la classe en XML. Retourne du XML bien formé où se trouve toutes les informations utile à la classe afin de la reconstruire.