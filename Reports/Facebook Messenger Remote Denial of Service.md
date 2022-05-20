Facebook Messenger Remote Denial of Service Vulnerability Report by RGFulw*


**Affected Platforms: -**
Messenger
Messenger Lite


**Tested On: -**
Android 6 & 7
IOS 11
Messenger (build 228.1.0.10.116)
Messenger Lite (build 65.0.1.18.236)


**Class: -**
Denial of Service.


**Summary: -**
All versions of Messenger Lite and Multiple Versions of Messenger are susceptible to a Remote Denial of Service Vulnerability.


**Short Description: -**
A user can remotely crash a user’s Messenger application by sending a message containing a single character.


**Long Description: -**
'ATTACKER' sends a single soft hyphen to 'VICTIM'
Upon opening the message, the Messenger application on 'VICTIM' device crashes when loading the single character.


**Proof of Concept: -**
####
Tested on Latest Version of Messenger Lite on Android 6

'ATTACKER' send single soft hyphen to 'VICTIM'
'VICTIM' open message sent by 'ATTACKER'
####

~~VIDEO: -   https://youtu.be/En1npDpgv_o~~ **REUPLOAD PLANNED**


**Expected Result: -**
It shouldn't be possible to remotely crash the application on a remote user’s device.


**Observed Result: -**
Application remotely crashes upon loading message.


**Our Recommendation: -**
Change the way soft hyphens are loaded in the application.


CVSS v3 Vector: -
AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:L/A:H/E:F/RL:O/RC:R/CR:X/IR:X/AR:X/MAV:N/MAC:L/MPR:N/MUI:N/MS:U/MC:N/MI:L/MA:H

CVSS Base Score: - 8.2
Impact Subscore: - 4.2
Exploitability Subscore: - 3.9
CVSS Temporal Score: - 7.3
CVSS Environmental Score: - 7.3
Modified Impact Subscore: - 4.2
Overall CVSS Score: - 7.3


CVSS v2 Vector: -
AV:N/AC:L/Au:N/C:N/I:P/A:C/E:F/RL:OF/RC:UR/CDP:LM/TD:M/CR:ND/IR:ND/AR:ND

CVSS Base Score: - 8.5
Impact Subscore: - 7.8
Exploitability Subscore: - 10.0
CVSS Temporal Score: - 6.7
CVSS Environmental Score: - 5.7
Modified Impact Subscore: - 7.8
Overall CVSS Score: - 5.7


TIMELINE: - Discovery      ~2017
        : - Initial Report 23rd August 2019
        : - Case Opened    23rd August 2019
        : - Added Detail   24th August 2019    *Public Disclosure Date: - Sep 18th 2019 UTC -08:00 (25 days from initial report)*
        : - Added Detail   27th August 2019
        : - Response       27th August 2019
        : - Added Detail   27th August 2019
        : - Response       29th August 2019    *Unable to Reproduce*
        : - ZDI contact    29th August 2019
        : - Added Detail   29th August 2019
        : - Response       1st September 2019
        : - Added Detail   1st September 2019
        : - Case Closed    5th September 2019  *PATCH RELEASED - 66.0.1.15.237*
        : - Added Detail   5th September 2019  *Public Disclosure Date: - Sep 6th 2019 UTC -08:00 (24 hours from patch)*

        : - We thank the Facebook Security team and Zero Day Initiative for their quick response & patch.