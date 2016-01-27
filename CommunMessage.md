# Class Message #

Le message est destiné à être mis dans une [file de message](CommunFileMessage.md). Il possède une méthode de saisie, une methode d'affichage et une méthode de sérialisation qui sera appellé par la [file de message](CommunFileMessage.md) afin d'être passé au serveur.

```
class Message:
    /******* Attributs publiques **********/
    string from;
    string to;
    bool publicite;
    string corps;
    string corps_html;

    /******* Méthodes publiques **********/
    void afficher()
    string saisir()
    string toXml()

```

## Attributs ##
**from**: Createur du message

**to**: destinataire(s). si `to` est égale à "all", envoie à toutes les personnes du salon

**publicité** :
utilisé lorsqu'un personnage parle à quelqu'un et veut que tout le monde entende (comme s'il criait)... Cela permet de charrier les gens ;)

**corps**: corps du mesage

**corps\_html**: corps du message en html (permet de faire tout plein de chabada (smiles...))

## Méthodes ##
**afficher**: existe-t-elle vraiment ? Là est la question...

**saisir**: methode affichant le TextField permettant à l'utilisateur de saisir le message. Doit-elle renvoyer le message ou le positionne-t-elle directement dans l'attribut ?

**toXml**: Sérialise la classe en XML. Retourne du XML bien formé où se trouve toutes les informations utile à la classe afin de la reconstruire.