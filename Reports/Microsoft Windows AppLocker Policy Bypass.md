Windows AppLocker 'Packaged App' Installation Policy Bypass by RGFulw*


**Affected Platforms: -**
Windows 10 Enterprise & Education


**Tested On: -**
Windows 10 (build 17763.253, 18362.295, 18362.356 & 18363.535)


**Summary: -**
Restricted Users can Completely Bypass Enforced AppLocker 'Packaged App' Rules Through the Windows Store, Simply by Scrolling Down.


**Short Description: -**
Automatically Generating Rules for Packaged App Access Control rules will restrict apps allowed to be installed locally from the Windows Store.
These restrictions can easily be bypasses by simply scrolling down in the Windows Store and clicking 'Install' in the top right corner, rendering this protection feature useless in this case.


**Long Description: -**
AppLocker for Windows Enterprise versions allow administrators to restrict which applications are allowed to run on their systems.
Configuring AppLocker rules through 'secpol.msc', navigating to Application Control Policies, AppLocker, Packaged app Rules is supposed to prevent apps from being installed onto the local machine.
An example of a restricted app could be the Ubuntu Subsystem, there are many reasons why system administrators would not like clients running Linux Subsystems on their machines.
When configuring rules with 'Automatically Generate Rules' will seem like low level users do not have the ability to install restricted apps.
By default, enforcing the 'Automatically Generate Rules' will only allow apps previously installed on the machine to run, but no additional apps can be installed from the windows store.
When trying to install a restricted app from the store, a user will be shown a message "This app has been blocked due to company policy." and the Install button will be greyed out and unable to be clicked.
Simply scrolling down to the end of the page will show an install button on the top right corner of the windows store app, allowing restricted users to install blocked apps.
Any app from the windows store should install successfully, if there is an error upon installing, leave the store open and wait for a while after pressing 'install'. It will work;)


**Proof of Concept: -**

Step 1.)    Enforce AppLocker rules through Group Policy Rules to prevent any additional Packaged Apps from being installed form the Windows Store.
Step 1.1.)  Selecting 'Automatically Generate Rules' will automatically enforce a whitelist only, prevent new installations except for the apps previously installed.
Step 2.)    Open Windows Store and Navigate to your desired application.
Step 2.1.)  Scroll to bottom of page, click install button on top right corner.

[APPLICATION INSTALLATION SUCCESSFUL]

~~VIDEO: -   https://youtu.be/D7fWopNGldw~~ **REUPLOAD PLANNED**



**Expected Result: -**
Restricted users shouldn't be able to bypass enforced AppLocker whitelist rules.


**Observed Result: -**
Restricted users can completely bypass enforced AppLocker rules preventing installation of the app.


**TIMELINE: -** Discovery           30th Oct 2019
        : - Report to Microsoft 4th Nov 2019    *Potential Changes Down the Line - Report Declined*
        : - Added Detail        4th Nov 2019    *Disclosure date set 24 hours from case refusal*