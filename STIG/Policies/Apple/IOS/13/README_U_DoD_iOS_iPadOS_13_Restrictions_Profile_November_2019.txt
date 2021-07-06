Defence Information Systems Agency Compliant Department of Defence IOS 13 Security Policy by RGFulw


Additions based on the Apple iOS/iPadOS 13 Security Technical Implementation Guide Available @ https://vaulted.io/library/disa-stigs-srgs/apple_iosipados_13_security_technical_implementation_guide

Please note, this is NOT an official security policy released by the Defence Information Systems Agency, simply based on the U_Apple_iOS_iPadOS_13_STIG_V1R1_Manual-xccdf.xml checklist.


Created due to no avaliable DISA STIG compliant IOS mobileconfig designed for hardening Apple IOS device configuration @ https://public.cyber.mil/stigs/downloads



The following have been added since IOS 12 security policy: -

*   allowMailDrop - FALSE
*   SSL - TRUE
*   PreventMove - TRUE
*   allowSharingManagedDocuments - FALSE
*   allowShareMyLocation - FALSE
*   allowUSBRestrictedMode - FALSE
*   allowPasswordSharing - FALSE
*   allowFindMyFriends - FALSE
*   allowUSBDriveFileAccess - FALSE
*   allowAppDataBackup - FALSE
*   allowProximityPasswordRequest - FALSE
*   allowUnmanagedToWriteContactsToUnmanagedContacts - FALSE
*   allowCloudKeychainSync - FALSE


Main limitations users may encounter upon applying security profile may include: -

*   Voice dialling while locked not allowed
*   Show Notification Centre in Lock screen is disabled
*   Show Today view in Lock screen is disabled
*   iCloud Backup is disabled
*   Allow iCloud documents & data is disabled
*   iCloud keychain is disabled
*   Allow My Photo Stream is disabled
*   Allow iCloud Photos is disabled
*   Allow managed apps to store data in iCloud is disabled
*   Allow backup of enterprise books is disabled
*   Allow documents from managed apps in unmanaged apps is disabled
*   Allow sending diagnostic and usage data to Apple is disabled
*   Force limited ad tracking is enabled
*   Safari Enable autofill is disabled
*   Allow Handoff is disabled
*   Require passcode on first AirPlay pairing is enabled
*   Allow MailDrop is disabled
*   Allow Shared Albums is disabled
*   Allow messages to be moved is disabled
*   Treat AirDrop as an unmanaged destination is enabled
*   Family Sharing is disabled
*   Share My Location is disabled
*   Force Apple Watch wrist detection is enabled
*   Allow USB Restricted Mode is disabled
*   Allow managed apps to write contacts to unmanaged contacts accounts is disabled
*   Allow unmanaged apps to read contacts from managed contacts accounts is disabled
*   AirDrop is disabled
*   Paired Apple Watch is disabled
*   Safari Password Autofill is disabled
*   Proximity setup to a new device is disabled
*   Allow Password Proximity Requests is disabled
*   Password Sharing is disabled
*   Find My Friends is disabled
*   Allow USB drive access in Files access is disabled


Project currently under development, use at own risk.
Feel free to make modifications to this security policy.

