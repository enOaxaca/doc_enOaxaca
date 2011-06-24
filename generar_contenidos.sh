#!/bin/bash

#!/bin/bash


function generar_CTPs {	
	FILES=./*\.md
	for f in $FILES
	do
	  echo "Processing $f file..."
	  filename=`echo $f | sed 's/\.md//'`
	  markdown $f > $filename.ctp
	done
}

function borrar_cache {	
	FILES=./*\.ctp
	for f in $FILES
	do
	  echo "Deleting $f file..."
	  rm $f
	done
	FILES=./*\.html
	for f in $FILES
	do
	  echo "Deleting $f file..."
	  rm $f
	done
}

function generar_HTMLs {	
	FILES=./*\.md
	for f in $FILES
	do
	  echo "Processing $f file..."
	  filename=`echo $f | sed 's/\.md//'`
	  markdown $f > $filename.html
	done
}

RETVAL=0
case "$1" in
   "") 
      echo "ERROR:
	Falta de argumento.
	Use: $0 [OPCIÓN]
DESCRIPCIÓN:
	Genera los archivos de markdown a formatos ctp y html\" 
OPCIONES DISPONIBLES:
	--ctp	Genera todos los archivos del directorio actual a formatos ctp
	 -c
	--html	Genera todos los archivos del directorio actual a formatos html
	 -h
	--del	Borra los archivos generados en html y ctp.
	 -d
	 
"
      RETVAL=1
      ;;
   --ctp|-c)
      generar_CTPs
      ;;
   --html|-h)
      generar_HTMLs
      ;;
   --del|-d)
      borrar_cache
      ;;
esac

exit $RETVAL


###########################################################################################

rm -f /tmp/markdown.html

	markdown $1 >> /tmp/markdown.html

	TITLE=`cat /tmp/markdown.html | grep -Eo "<h1>.*</h1>" | head -1 | sed -r  "s/<h1>(.*)<\/h1>/\1/"`
	USER=`eval whoami`

	rm -f /tmp/markdown.html

	echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>' > /tmp/markdown.html

	echo "<title>$TITLE</title>" >>  /tmp/markdown.html

	echo "<meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\" />
		<link rel=\"stylesheet\" type=\"text/css\" href=\"/home/$USER/.config/css/style.css\" />
	</head>
	<body>
	<div id='content'>
	" >> /tmp/markdown.html


	markdown $1 >> /tmp/markdown.html
	echo '</div>
	</body>
	</html>'  >> /tmp/markdown.html

#gnome-open /tmp/markdown.html 
