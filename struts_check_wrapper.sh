#!/bin/sh

#USER = Remote user.  It is assumed that the user either has root equivalent access or is in the SUDOERS file with "NOPASSWD" to allow them to elevate without passing a password in the script.

#KEYFILE = The SSH key used to authenticate to the remote system.  Typically run with a service account that does not have the key protected with a password.  ssh-agent is one option to use a protected key with the scripts.

#SCRIPT = The locally stored script to run on the remote system

#OUTPUTDIR = Where the results from the script are stored locally

#HOSTS = The target systems to run the SCRIPT against

#No error handling in this version - exercise caution!

USER="admin_user"
KEYFILE="/path/to/ssh/keyfile/.ssh/<keyname>.pem"
SCRIPT="/path/to/script/struts_scripts/struts_id.sh"
OUTPUTDIR="/path/to/results/struts_scripts/results/"
HOSTS="/path/to/targets/struts_scripts/targets.txt"

#Makes sure the output directory exists
mkdir -p "${OUTPUTDIR}"

while read TARGET; do
	
	##The script works by initiating a SSH connection to the remote host, executing a shell and reading the locally stored script in.  This avoids needing to upload the script to the remote host. 
	echo "Checking ${TARGET}"
	## Uncomment this line if the user needs to elevate to read all directories
	#ssh "${USER}"@"${TARGET}" -i "${KEYFILE}" "sudo bash" < "${SCRIPT}" > "${OUTPUTDIR}""${TARGET}".txt

	## Uncomment this line if the user does not need to elevate to read all directories
	#ssh "${USER}"@"${TARGET}" -i "${KEYFILE}" "bash" < "${SCRIPT}" > "${OUTPUTDIR}""${TARGET}".txt
done < ${HOSTS}

#clean up our session 
exit 0
