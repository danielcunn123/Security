Microsoft Office365/ProPlus Integrity Validation/Execution Protection Bypass Vulnerability Report by RGFulw*


**Affected Platforms: -**
Microsoft Windows ≤10
Office365 & ProPlus Products ≤2019


**Tested On: -**
Windows 10 (build 17763.253, 18362.295 & 18362.356)
Office365/ProPlus (build 16.0.11727.20222, 16.0.11901.20170, 16.0.11901.20204 & 16.0.11929.202.88)
Most up to-date version of Microsoft Windows & Office365/ProPlus Products are affected.


**Base: -**
CWE-325 - Missing Required Cryptographic Step.
The software does not implement a required step in a cryptographic algorithm used to validate the original integrity of documents.


**Summary: -**
Improper Integrity Validation of Office Documents Resulting in Multiple Microsoft Office Products Suffering from a Protection Bypass Vulnerability. Allowing Auto-Execution of Macro Code Inside Macro-Enabled Office Documents.


**Short Description: -**
Overwriting an original macro-enabled document with a malicious document will bypass the built-in protections.


**Long Description: -**
A user creates a macro-enabled MS Word document and saves the document with text/data inside.
If the user deletes the document and downloads a completely different document with the same name, this can allow remote code execution.
When a document is opened/edited, Office apps keep a record of the name and permissions associated with the specific document.
This can be abused when downloading a malicious document to run code remotely on the machine.


**Proof of Concept: -**

Tested on Latest Versions of Access, Excel, InfoPath, OneNote, Outlook, PowerPoint, Project, Publisher, Visio, Word.

Affects Access, Excel, InfoPath, PowerPoint, Visio, Word.
Does not affect OneNote, Outlook, Project, Publisher.

ATTACKER: -
Step 0.) -  Knowledge of Office document names on VICTIM device.
Step 1.) -  Inject malicious VBA macro code & payload into Office document.    *preferably AV evasive*
Step 2.) -  Send malicious macro-enabled document to VICTIM through internet.
Step 3.) -  Setup bind/reverse connection.

VICTIM: -
Step 1.) -  Download document sent by ATTACKER.
Step 2.) -  Open Document in same location as previous document.

[CODE EXECUTION SUCCESSFUL]

~~VIDEO: -   https://youtu.be/YVF7gqWZSGE~~ **REUPLOAD PLANNED**



**Expected Result: -**
It shouldn't be possible to automatically execute macro code on the host machine without user consent or additional configuration.
(Clean Install)


**Observed Result: -**
Office document auto-executes macro code upon loading document without any user consent, in our case leading to remote code execution.
(User Level Access)


**Our Recommendation: -**
Generating a hash value of the document once changes have been made will greatly reduce the exploitability.
Once file is reopened by user, check whether the hash of the filename is the same as last changes.
If the current hash value and filename do not match the previous modification of document, open in protected view and prevent scripts from running.


**NOTE: -** These kinds of tactics may be used by workplaces & education providers to embed honeytokens into sensitive documents.
    : - Every user with Office365 & ProPlus products will be affected by this issue.


**TIMELINE: -** Discovery       20th Sep 2019
        : - Initial Report  21st Sep 2019
        : - MSRC Response   24th Sep 2019 *Case refused*
        : - Contact ZDI     24th Sep 2019
        : - ZDI Response    25th Sep 2019
        : - MSRC Report #2  27th Sep 2019
        : - MSRC Response   30th Sep 2019 *Case refused*