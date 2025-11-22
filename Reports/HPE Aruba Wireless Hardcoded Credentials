HPE Aruba 505H Sensitive Information Disclosure Vulnerability

Summary:
Gemini series Aruba mesh wireless routers running firmware v8.12.0.2 are vulnerable to sensitive information disclosure.

Base:
215 - Insertion of sensitive information into debugging code
921 - Storage of sensitive data in a mechanism without access control
378 - Creation of temporary file with insecure permissions
547 - Use of hardcoded, security-relevant constants

Description:
This is due to the update & upgrade process involving hardcoded credentials for file download.
Due to the ssh server accepting connections on port 22 enabling remote ssh login for user 'secureimagecopyuser' defined at line 37 of '/aruba/bin/download_image_swarm.sh'.

Reproduce:

1. Extract firmware with binwalk -e
2. Login to the chroot within firmware
3. Execute cat /aruba/bin/download_image_swarm.sh
4. Read line 37 of script
5. Observe script performs update tasks with given hardcoded ssh user credentials.
6. Execute cat /etc/ssh/ssh_config
7. Determine whether ssh-server is enabled and running
8. Atempt remote login with given credentials

Reccomendation:
Remove insecure accounts, credentials.
Subsitute use of Secure File Transfer Protocol for update download and handling.
