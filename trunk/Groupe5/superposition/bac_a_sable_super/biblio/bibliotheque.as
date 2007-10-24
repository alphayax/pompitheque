XMLNode.prototype.getElementByTagName = function(Tag:String):Array  {
        var bons_noeuds = new Array();
        var tous_noeuds = this.childNodes;
        for (var i:Number = 0; i<tous_noeuds.length; i++) {
                noeud_courant = tous_noeuds[i];
                if (noeud_courant.nodeName == Tag) {
                        bons_noeuds.push(noeud_courant);
                }
        }
        return (bons_noeuds.length<=0)? null : bons_noeuds;
};
//--
var bibliotheque:XML = new XML();
bibliotheque.ignoreWhite = true;
bibliotheque.onLoad = function(succes) {
        if (succes) {
                trace(this.firstChild.nodeName);
                var livres:Array = this.firstChild.childNodes;
                for (var i = 0; i<livres.length; i++) {
                        trace(livres[i].getElementByTagName('titre'));
                }
        } else {
                trace("Une erreur s'est produite");
        }
};
bibliotheque.load("bibliotheque.xml");