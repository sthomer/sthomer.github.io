#!/bin/sh

# get the current path
CURPATH=`pwd`

inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
-e modify ~/projects \
| while read date time dir file; do

	FILECHANGE=${dir}${file}
	# convert absolute path to relative
	FILE=`echo "$FILECHANGE" | sed 's:'___jb_tmp___'::'`

	case "$FILE" in
	*.js | *.jsp | *.java | *.tag | *.jspf | *.css | *.xml | *.sql | *.html | *.pl)
		FILECHANGEREL=`echo "$FILE" | sed 's:'$CURPATH'/::'`
		FILEDISPLAY=`echo ${file} | sed 's:'___jb_tmp___'::'`
		echo '-------------------------------------------------------------------------------'
		rsync --progress --relative -vra "$FILECHANGEREL" steveh01.mediture.dom:/home/steveh && \
		echo "At ${time} on ${date}, file $FILEDISPLAY was backed up via rsync"
		;;
	esac

done
