Microsoft Windows Defender Ransomware Protection 'Controlled Folder Access' bypass by RGFulw*

**Affected Platforms: -**
    Windows
    Linux - (WSL)

**Tested On: -**
Windows 10 (build 17763.253, 18362.295, 18362.356 & 18363.535)

**Summary: -**
Restricted Users can Overwrite Files/Directories Protected by Windows Defender Ransomware Protection Controlled Folder Access 'CFA'.

**Short Description: -**
A user with the Linux Subsystem (WSL) installed on their device, could be vulnerable to Linux-based ransomware attacks, potentially encrypting the entire device including Windows.

Windows Defender Ransomware Protection does not protect users from Linux-based ransomware from Windows Store apps (eg. Ubuntu).

**Long Description: -**
When combined with our AppLocker bypass, it is possible to encrypt the device without additional permissions, regardless if apps are blocked from installing on the Windows Store using AppLocker. (Administrator must enable WSL from settings)

~~Ransomware tests were performed with our own ransomware-like shell script available @ https://github.com/SocialEngineeringNeo/Exploits/blob/master/Our%20Exploits/ransomware.sh~~ **REUPLOAD PLANNED**

The Controlled Folder Access protections prevent any programs from overwriting data in specific directories, this is a measure to reduce the damage performed by Windows-based ransomware attacks.

By default, ~\Documents, ~\Downloads, ~\Pictures, ~\Videos, ~\Music, ~\Favourites are protected locations, preventing unwanted modifications from software.

Simply enabling CFA and opening the bash prompt running $ echo > PoC.txt will overwrite the file, without additional permissions/configuration.

Opening command prompt and running echo > PoC.txt will fail with error "Access Denied". This should be the case for WSL but is not.

You may receive the following error: "-bash: echo: write error: Permission denied" Don’t worry, the error prompt is incorrect, and the file will be overwritten!

It is not possible to overwrite files with openssl for whatever reason, I'm sure many other software should work.
Proof of Concept: -

**Step 1.)**    Enable 'Windows Subsystem for Linux' through 'Turn Windows features On or Off'

**Step 1.a.)**  Enable Developer Mode through Windows settings. Reboot!

**Step 2.)**    Install Ubuntu from Windows store.

**Step 2.a.)**  Run any sort of Linux-based ransomware. Windows mount point is '/mnt/c/'

[PROTECTED FILE/DIRECTORY OVERWRITE SUCCESSFUL]

~~VIDEO: -  https://youtu.be/2-OS83YnpQQ~~ **REUPLOAD PLANNED**

**Expected Result: -**

Overwriting data within 'CFA' protected directories will be blocked by Windows Defender.

**Observed Result: -**

WSL allows users limited functionality of overwriting files within 'CFA' protected directories, which are not blocked by Windows Defender.

**NOTE: -** Not all Linux commands will work when overwriting files inside protected directories.