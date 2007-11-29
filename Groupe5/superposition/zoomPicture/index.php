<?php // printFolder script
// paramètres
$nom_dossier     = basename(getcwd());
$chemin_dossier  = trim(rtrim(dirname($_SERVER['PHP_SELF']), '/\\'), "/"); // sans les caractères "/" de début et de fin de chaine
$dossier_root    = "~nauberval/tmp";              // dossier racine où ne pas afficher la bouton "Parent Directory"
$dossier_data    = "/~nauberval/zdata";
$favicon         = "favicon.png";             // icône de la barre d'URL
$title           = $chemin_dossier;           // titre de la fenêtre 
$h1              = "| ".$chemin_dossier." |"; // titre de la page
$bgcolor         = "#CCCCCC";                 // couleur de fond


// PENSE-BETE

// FONCTIONS

function retourDate ( $fic ) {
    $aujourdhui = date ("j F Y, H:i:s");
    $dateFichier = date ("j F Y, H:i:s", filemtime($fic));
    $diffDate = $aujourdhui - $dateFichier;
    if ( $diffDate == 0 ) { return "Aujourd'hui, ".date ("H:i:s", filemtime($fic)); }
    else if ( $diffDate == 1 ) { return "Hier, ".date ("H:i:s", filemtime($fic)); }
    else return date ("j F Y, H:i:s", filemtime($fic));
}

function size_readable ( $size, $retstring = null ) {
    $sizes = array('B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
    if ( $retstring === null ) { $retstring = '%01.2f %s'; }
    $lastsizestring = end( $sizes );
    foreach ( $sizes as $sizestring ) {
            if ( $size < 1024 ) { break; }
            if ( $sizestring != $lastsizestring ) { $size /= 1024; }
    }
    if ( $sizestring == $sizes[0] ) { $retstring = '%01d %s'; } // Bytes aren't normally fractional
    return sprintf( $retstring, $size, $sizestring );
}

function get_size ( $path ) {
    if (!is_dir($path)) return filesize($path);
    $dir = opendir($path);
    while($file = readdir($dir))
    {
        if (is_file($path."/".$file)) $size+=filesize($path."/".$file);
        if (is_dir($path."/".$file) && $file!="." && $file !="..") $size +=get_size($path."/".$file);
    }
    return $size;
}

/*function code_URL_accents( $chaine ) {
    //$trans_code_URL = array("À" => "A%CC%80", "Á" => "A%CC%81", "Ä" => "A%CC%88", "Â" => "A%CC%82", "Ã" => "A%CC%83", "à" => "a%CC%80", "á" => "a%CC%81", "ä" => "a%CC%88", "â" => "a%CC%82", "ã" => "a%CC%83", "È" => "E%CC%80", "É" => "E%CC%81", "Ë" => "E%CC%88", "Ê" => "E%CC%82", "è" => "e%CC%80", "é" => "e%CC%81", "ë" => "e%CC%88", "ê" => "e%CC%82", "Ì" => "I%CC%80", "Í" => "I%CC%81", "Ï" => "I%CC%88", "Î" => "I%CC%82", "ì" => "i%CC%80", "í" => "i%CC%81", "ï" => "i%CC%88", "î" => "i%CC%82", "Ò" => "O%CC%80", "Ó" => "O%CC%81", "Ö" => "O%CC%88", "Ô" => "O%CC%82", "Õ" => "O%CC%83", "ò" => "o%CC%80", "ó" => "o%CC%81", "ö" => "o%CC%88", "ô" => "o%CC%82", "õ" => "o%CC%83", "Ù" => "U%CC%80", "Ú" => "U%CC%81", "Ü" => "U%CC%88", "Û" => "U%CC%82", "ù" => "u%CC%80", "ú" => "u%CC%81", "ü" => "u%CC%88", "û" => "u%CC%82", "Ÿ" => "Y%CC%88", "Ñ" => "N%CC%83", "Ç" => "C%CC%A7", "ÿ" => "y%CC%88", "ñ" => "n%CC%83", "ç" => "c%CC%A7");
    $lettre_accent = array("À", "Á", "Ä", "Â", "Ã", "à", "á", "ä", "â", "ã", "È", "É", "Ë", "Ê", "è", "é", "ë", "ê", "Ì", "Í", "Ï", "Î", "ì", "í", "ï", "î", "Ò", "Ó", "Ö", "Ô", "Õ", "ò", "ó", "ö", "ô", "õ", "Ù", "Ú", "Ü", "Û", "ù", "ú", "ü", "û", "Ÿ", "Ñ", "Ç", "ÿ", "ñ", "ç");
    $code_URL = array("A%CC%80", "A%CC%81", "A%CC%88", "A%CC%82", "A%CC%83", "a%CC%80", "a%CC%81", "a%CC%88", "a%CC%82", "a%CC%83", "E%CC%80", "E%CC%81", "E%CC%88", "E%CC%82", "e%CC%80", "e%CC%81", "e%CC%88", "e%CC%82", "I%CC%80", "I%CC%81", "I%CC%88", "I%CC%82", "i%CC%80", "i%CC%81", "i%CC%88", "i%CC%82", "O%CC%80", "O%CC%81", "O%CC%88", "O%CC%82", "O%CC%83", "o%CC%80", "o%CC%81", "o%CC%88", "o%CC%82", "o%CC%83", "U%CC%80", "U%CC%81", "U%CC%88", "U%CC%82", "u%CC%80", "u%CC%81", "u%CC%88", "u%CC%82", "Y%CC%88", "N%CC%83", "C%CC%A7", "y%CC%88", "n%CC%83", "c%CC%A7");
    return str_replace( $lettre_accent, $code_URL, $chaine );
}*/ // -- INUTILISEE --

function get_icon ( $file ) {
    //$file = strtolower( $file );
    
    // FICHIERS TYPE IMAGE
    if ( preg_match( "/[.]jp[e]?g$/i", $file ) ) { $icone = "img/imageJPEG.png"; }
    else if ( preg_match( "/[.]gif$/i", $file ) ) { $icone = "img/imageGIF.png"; }
    else if ( preg_match( "/[.]tif[f]?$/i", $file ) ) { $icone = "img/imageTIFF.png"; }
    else if ( preg_match( "/[.]png$/i", $file ) ) { $icone = "img/imagePNG.png"; }
    else if ( preg_match( "/[.]bmp$/i", $file ) ) { $icone = "img/imageBMP.png"; }
    else if ( preg_match( "/[.]pict$/i", $file ) ) { $icone = "img/imagePICT.png"; }
    else if ( preg_match( "/[.]psd$/i", $file ) ) { $icone = "img/imagePSD.png"; }
    else if ( preg_match( "/[.]icns$/i", $file ) ) { $icone = "img/imageICNS.png"; }
    else if ( preg_match( "/[.]ico$/i", $file ) ) { $icone = "img/imageICO.png"; }
    
    // FICHIERS TYPE DOCUMENT
    else if ( preg_match( "/[.]odp$/i", $file ) ) { $icone = "docs/oo2-impress-doc.png"; }
    else if ( preg_match( "/[.]ods$/i", $file ) ) { $icone = "docs/oo2-calc-doc.png"; }
    else if ( preg_match( "/[.]odt$/i", $file ) ) { $icone = "docs/oo2-writer-doc.png"; }
    else if ( preg_match( "/[.]doc$/i", $file ) ) { $icone = "docs/DOCdocsIcon.png"; }
    else if ( preg_match( "/[.]xls$/i", $file ) ) { $icone = "docs/XLSdocsIcon.png"; }
    else if ( preg_match( "/[.]ppt$/i", $file ) ) { $icone = "docs/PPTdocsIcon.png"; }
    else if ( preg_match( "/[.]pps$/i", $file ) ) { $icone = "docs/PPTdocsIcon.png"; }
    else if ( preg_match( "/[.]txt$/i", $file ) ) { $icone = "docs/textIcon.png"; }
    else if ( preg_match( "/[.]rtf[d]?$/i", $file ) ) { $icone = "docs/textIcon.png"; }
    else if ( preg_match( "/[.]pdf$/i", $file ) ) { $icone = "docs/PDFicon.png"; }
    else if ( preg_match( "/[.]ps$/i", $file ) ) { $icone = "docs/PSicon.png"; }
    else if ( preg_match( "/[.]htm[l]?$/i", $file ) ) { $icone = "docs/internetDocumentIcon.png"; }
    else if ( preg_match( "/[.]webloc$/i", $file ) ) { $icone = "docs/httpWeblocIcon.png"; }
    else if ( preg_match( "/[.]m3u$/i", $file ) ) { $icone = "docs/VLC-m3u.png"; }
    else if ( preg_match( "/[.]srt$/i", $file ) ) { $icone = "docs/VLC-srt.png"; }
    else if ( preg_match( "/[.]sub$/i", $file ) ) { $icone = "docs/VLC-sub.png"; }
    
    // FICHIERS TYPE PROGRAMME
    else if ( preg_match( "/[.]php[3-5]?$/i", $file ) ) { $icone = "prgms/phpfile.png"; }
    else if ( preg_match( "/[.]c$/i", $file ) ) { $icone = "prgms/cfile.png"; }
    else if ( preg_match( "/[.]cc$/i", $file ) ) { $icone = "prgms/c++file.png"; }
    else if ( preg_match( "/[.]cpp$/i", $file ) ) { $icone = "prgms/c++file.png"; }
    else if ( preg_match( "/[.]h$/i", $file ) ) { $icone = "prgms/hfile.png"; }
    else if ( preg_match( "/[.]l[+]?$/i", $file ) ) { $icone = "prgms/lfile.png"; }
    else if ( preg_match( "/[.]m$/i", $file ) ) { $icone = "prgms/mfile.png"; }
    else if ( preg_match( "/[.]r$/i", $file ) ) { $icone = "prgms/rfile.png"; }
    else if ( preg_match( "/[.]s$/i", $file ) ) { $icone = "prgms/sfile.png"; }
    else if ( preg_match( "/[.]y$/i", $file ) ) { $icone = "prgms/yfile.png"; }
    else if ( preg_match( "/[.]java$/i", $file ) ) { $icone = "prgms/javafile.png"; }
    
    // FICHIERS TYPE ARCHIVE
    else if ( preg_match( "/[.]img$/i", $file ) ) { $icone = "archive/dmgIcon.png"; }
    else if ( preg_match( "/[.]dmg$/i", $file ) ) { $icone = "archive/dmgIcon.png"; }
    else if ( preg_match( "/[.]ace$/i", $file ) ) { $icone = "archive/aceIcon.png"; }
    else if ( preg_match( "/[.]bz$/i", $file ) ) { $icone = "archive/bah-bz.png"; }
    else if ( preg_match( "/[.]bz2$/i", $file ) ) { $icone = "archive/bah-bz2.png"; }
    else if ( preg_match( "/[.]cpgz$/i", $file ) ) { $icone = "archive/bah-cpgz.png"; }
    else if ( preg_match( "/[.]cpio$/i", $file ) ) { $icone = "archive/bah-cpio.png"; }
    else if ( preg_match( "/[.]gz$/i", $file ) ) { $icone = "archive/bah-gz.png"; }
    else if ( preg_match( "/[.]tar$/i", $file ) ) { $icone = "archive/bah-tar.png"; }
    else if ( preg_match( "/[.]tbz$/i", $file ) ) { $icone = "archive/bah-tbz.png"; }
    else if ( preg_match( "/[.]tbz2$/i", $file ) ) { $icone = "archive/bah-tbz2.png"; }
    else if ( preg_match( "/[.]tgz$/i", $file ) ) { $icone = "archive/bah-tgz.png"; }
    else if ( preg_match( "/[.]zip$/i", $file ) ) { $icone = "archive/bah-zip.png"; }
    else if ( preg_match( "/[.]z$/i", $file ) ) { $icone = "archive/bah-z.png"; }
    else if ( preg_match( "/[.]bin$/i", $file ) ) { $icone = "archive/binIcon.png"; }
    else if ( preg_match( "/[.]rar$/i", $file ) ) { $icone = "archive/rarIcon.png"; }
    else if ( preg_match( "/[.]sit$/i", $file ) ) { $icone = "archive/sitIcon.png"; }
    else if ( preg_match( "/[.]sitx$/i", $file ) ) { $icone = "archive/sitxIcon.png"; }
    
    // FICHIERS TYPE AUDIO
    else if ( preg_match( "/[.]aac$/i", $file ) ) { $icone = "audio/iTunes-aac.png"; }
    else if ( preg_match( "/[.]m4[abp]$/i", $file ) ) { $icone = "audio/iTunes-mpeg4.png"; }
    else if ( preg_match( "/[.]aif[f]?$/i", $file ) ) { $icone = "audio/iTunes-aiff.png"; }
    else if ( preg_match( "/[.]au$/i", $file ) ) { $icone = "audio/iTunes-audible.png"; }
    else if ( preg_match( "/[.]mp3$/i", $file ) ) { $icone = "audio/iTunes-mp3.png"; }
    else if ( preg_match( "/[.]pls$/i", $file ) ) { $icone = "audio/iTunes-playlist.png"; }
    else if ( preg_match( "/[.]wav$/i", $file ) ) { $icone = "audio/iTunes-wav.png"; }
    else if ( preg_match( "/[.]ogg$/i", $file ) ) { $icone = "audio/VLC-ogg.png"; }
    else if ( preg_match( "/[.]wma$/i", $file ) ) { $icone = "audio/VLC-wma.png"; }
    
    // FICHIERS TYPE VIDEO
    else if ( preg_match( "/[.]3gp$/i", $file ) ) { $icone = "video/Movie-3GPP.png"; }
    else if ( preg_match( "/[.]avi$/i", $file ) ) { $icone = "video/Movie-AVI.png"; }
    else if ( preg_match( "/[.]flv$/i", $file ) ) { $icone = "video/Movie-FLASH.png"; }
    else if ( preg_match( "/[.]mp[e]?g$/i", $file ) ) { $icone = "video/Movie-MPEG.png"; }
    else if ( preg_match( "/[.]mp4$/i", $file ) ) { $icone = "video/Movie-MPEG4.png"; }
    else if ( preg_match( "/[.]m4v$/i", $file ) ) { $icone = "video/Movie-MPEG4.png"; }
    else if ( preg_match( "/[.]mov$/i", $file ) ) { $icone = "video/Movie-QuickTime.png"; }
    else if ( preg_match( "/[.]asf$/i", $file ) ) { $icone = "video/VLC-asf.png"; }
    else if ( preg_match( "/[.]dat$/i", $file ) ) { $icone = "video/VLC-dat.png"; }
    else if ( preg_match( "/[.]divx$/i", $file ) ) { $icone = "video/VLC-.png"; }
    else if ( preg_match( "/[.]ogm$/i", $file ) ) { $icone = "video/VLC-ogm.png"; }
    else if ( preg_match( "/[.]wmv$/i", $file ) ) { $icone = "video/VLC-wmv.png"; }
    
    // FICHIERS TYPE REALPLAYER
    else if ( preg_match( "/[.]ra[m]?$/i", $file ) ) { $icone = "RealPlayerDoc.png"; }
    else if ( preg_match( "/[.]rm$/i", $file ) ) { $icone = "RealPlayerDoc.png"; }
    
    // ICONE PAR DEFAUT
    else $icone = "fileIcon.png";
    
    return $icone;
}

function get_UNIX_style_perms( $file ) {
    $perms = fileperms($file);

    if (($perms & 0xC000) == 0xC000) {
        // Socket
        $info = 's';
    } elseif (($perms & 0xA000) == 0xA000) {
        // Lien symbolique
        $info = 'l';
    } elseif (($perms & 0x8000) == 0x8000) {
        // Régulier
        $info = '-';
    } elseif (($perms & 0x6000) == 0x6000) {
        // Bloc spécial
        $info = 'b';
    } elseif (($perms & 0x4000) == 0x4000) {
        // Dossier
        $info = 'd';
    } elseif (($perms & 0x2000) == 0x2000) {
        // Caractère spécial
        $info = 'c';
    } elseif (($perms & 0x1000) == 0x1000) {
        // FIFO pipe
        $info = 'p';
    } else {
        // Inconnu
        $info = 'u';
    }
    
    // Propriétaire
    $info .= (($perms & 0x0100) ? 'r' : '-');
    $info .= (($perms & 0x0080) ? 'w' : '-');
    $info .= (($perms & 0x0040) ?
                (($perms & 0x0800) ? 's' : 'x' ) :
                (($perms & 0x0800) ? 'S' : '-'));
    
    // Groupe
    $info .= (($perms & 0x0020) ? 'r' : '-');
    $info .= (($perms & 0x0010) ? 'w' : '-');
    $info .= (($perms & 0x0008) ?
                (($perms & 0x0400) ? 's' : 'x' ) :
                (($perms & 0x0400) ? 'S' : '-'));
    
    // Tous
    $info .= (($perms & 0x0004) ? 'r' : '-');
    $info .= (($perms & 0x0002) ? 'w' : '-');
    $info .= (($perms & 0x0001) ?
                (($perms & 0x0200) ? 't' : 'x' ) :
                (($perms & 0x0200) ? 'T' : '-'));
    
    return $info;
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    
    <head>
        <link rel="icon" href="<?php echo $dossier_data."/".$favicon; ?>" type="image/x-icon" />
        <link rel="shortcut icon" href="<?php echo $dossier_data."/".$favicon; ?>" type="image/x-icon" />
        <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
        <style type="text/css">
            .iconFIC {width:32px; height:32px;}
            .titreColonne {font-style:italic; text-decoration:underline;}
            .colNom {width:400px; text-align: left;}
            .colDateModif {width:250px; text-align: left;}
            .colTaille {width:100px; text-align: left;}
            .colDroits {width:100px; text-align: left;}
        </style>
        <title> <?php echo $title; ?> </title>
    </head>
    <script language="javascript">
    </script>

    <body bgcolor="<?php echo $bgcolor; ?>">
        <center>
            <h1> <?php echo $h1; ?> </h1>
            <h5>Par définition,&nbsp;&nbsp;les éléments de ce dossier sont censés y rester temporairement selon le bon vouloir de l'administrateur</h5>
        
        <br/>
        <table>
            <tr class="titreColonne">
                <td></td>
                <td class="colNom">Nom</td>
                <td class="colDateModif">Date de modification</td>
                <!--<td class="colTaille">Taille</td>-->
                <td class="colDroits">Droits</td>
            </tr>
        <?php
        
        // listing des fichiers du repertoire
        $rep = opendir( "." );
        
        while ( false !== ($fnom = readdir( $rep )) ) {
            // Définition des éléments à ne pas afficher
            if ( $fnom != "." && $fnom != ".." && $fnom != ".DS_Store" && $fnom != "_data" && $fnom != "Icon\r" && $fnom != "index.php" ) {
                echo "<tr>\n";
                switch ( filetype($fnom) ) {
                    // TYPE DE FICHIER
                    case "dir" &&  $fnom == ".." && $chemin_dossier !== "~Nicky/tmp" :
                        echo "<td><img class=\"iconFIC\" src=\"".$dossier_data."/back.gif\" /></td><td class=\"colNom\"><a href=\"$fnom/\">Dossier parent</a></td>\n";
                        break;
                    case "file" :
                        echo "<td><img class=\"iconFIC\" src=\"".$dossier_data."/".get_icon($fnom)."\" /></td><td class=\"colNom\"><a href=\"$fnom\">$fnom</a></td>\n";
                        break;
                    case "dir" :
                        echo "<td><img class=\"iconFIC\" src=\"".$dossier_data."/dirIcon.png\" /></td><td class=\"colNom\"><a href=\"$fnom/\">$fnom</a></td>\n";
                        break;
                }
                echo "<td class=\"colDateModif\">".retourDate($fnom)."</td>\n";
                /*echo "<td class=\"colTaille\">".size_readable(get_size($fnom))."</td>\n";*/
                echo "<td class=\"colDroits\">".get_UNIX_style_perms($fnom)."</td>\n";
                echo "</tr>\n";
            }
            else if ( $fnom == ".." /*&& $chemin_dossier != $dossier_root*/ ) {
                echo "<tr>\n";
                echo "<td><img class=\"iconFIC\" src=\"".$dossier_data."/back.gif\" /></td><td><a href=\"$fnom/\">Dossier parent</a></td>\n";
                echo "<td>".retourDate($fnom)."</td>\n";
                /*echo "<td>".size_readable(get_size($fnom))."</td>\n";*/
                echo "<td>".get_UNIX_style_perms($fnom)."</td>\n";
                echo "</tr>\n";
            }
        }
        
        closedir( $rep );

        ?>
        </table>
        </center>
    </body>
</html>