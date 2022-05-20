CTFd Server Administrator Account Takeover Vulnerability by Social Engineering Neo.


**Tested On: -**
Live Remote Hosted CTFd v2.1.5 Server.
Local Hosted CTFd v2.1.5 Server.
Windows
MacOS
Linux


**Class: -**
Improper Authorization - CWE-285


**Base: -**
Direct Request 'Forced Browsing' - CWE-425


**Summary: -**
Due to Improper Authorization Checks and Direct Request Protections, Newly Created CTF'd Servers Have the Potential of a "Full" Administrator Account Takeover During the Setup Process. This Includes the Given URL Prior to and During SETUP/UNTIL "Save-State".


**Short Description: -**
A remote attacker with knowledge of this new CTF'd hostname could modify critical configurations of the server. This is only possible while the server admin is performing the initial setup.


**Proof of Concept: -**
####
VICTIM – (Server Admin)
1.) -    Setting up CTF'd server configuration as usual.

ATTACKER
1.) -    Knowledge of newly created CTFd hostname.
2.) -    Access https://[HOST].ctfd.io to verify the server is up.
3.) -    Access https://[HOST].ctfd.io/setup to set/modify server Administrator password, username and email – no authentication/authorization required to input these values
4.) -    Login with new admin credentials at https://[HOST].ctfd.io/login
####

**CODE: -** [Here](../Scripts/CTFdTakeover.sh)


[ADMIN USER TAKEOVER SUCCESSFUL]
####

~~VIDEO: - https://youtu.be/li9dX7CUTTg *Exploit*~~ **REUPLOAD PLANNED**
     ~~: - https://youtu.be/bQyVyXzvHCo *Demo*~~


**Expected Result: -**
Users should not have the ability to read/write critical server/user configuration without proper authentication.


**Observed Result: -**
Unauthorized users have the ability to read/write critical server/user configuration without any authentication.