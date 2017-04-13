#!/bin/sh

#HOST stores the hostname to add to the output
HOST="$(hostname)"

#The script finds all instances of java files matching the criteria, extracts them to a pipe, then greps out the file version.  
#Output is returned to the parent script in tab delimited format - <HOSTNAME> <JAR FILE LOCATION> <VERSION NUMBER>
find / -type f -iname '*struts*.jar' |
	while read JARFILE; do
		printf "${HOST}	${JARFILE}	"
		unzip -p "${JARFILE}" META-INF/MANIFEST.MF | grep -F Specification-Version
	done

#clean up our session
exit 0
