<h2>Apple iPadOS/iPhoneOS 14 STIG mobileconfig</h2>


Defence Information Systems Agency Compliant iOS 14 Security Policy by RGFulw.

Additions based on the Apple iOS/iPadOS 14 Security Technical Implementation Guide [here](https://vaulted.io/library/disa-stigs-srgs/apple_iosipados_14_security_technical_implementation_guide), configured using the *U_Apple_iOS_iPadOS_14_STIG_V1R1_Manual-xccdf.xml* [checklist](https://stigviewer.com/stig/apple_iosipados_14/2021-02-24/MAC-3_Sensitive/xml).

Please note, this is **NOT** an official security policy released by the Defence Information Systems Agency. Requirements are derived from the National Institute of Standards and Technology (NIST) [800-53](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final) and related documents.

<img src="./media/4b3968c92edc383fc063d68bdb4826b3f888d755.png" width="250px"/>

This configuration package was created due to no avaliable DISA STIG compliant iOS mobileconfig all-in-one package designed for hardening Apple iOS endpoint device [configuration](https://public.cyber.mil/stigs/downloads).

Features **bold** are features users may regularly use, please read the following table to determine wether to continue or modify the package contents to better suit your preferences.

Feature Name | Feature Enabled
------------ | ---------------- |
**AirDrop** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
AirPlay Incoming Pairing Password | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
AirPlay Outgoing Pairing Password | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**AirPlay Incoming Requests** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**App Installation** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
App Removal | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Apple Personalized Advertising | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
**Assistant (Siri)** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Assistant While Locked (Siri)** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Automatic App Downloads | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Camera** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Chat (iMessage)** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Cloud Backup (iCloud)** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Cloud Document Sync | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Cloud Keychain Sync | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
**Cloud Photo Library (iCloud)** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Definition Lookup | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Device Name Modification | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Diagnostic Submission** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Dictation | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Encrypted Backup | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Enterprise App Trust | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Erase Content And Settings | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Files Network Drive Access | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Files USB Drive Access | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
**Find My Device** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Find My Friends | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
**Fingerprint For Unlock** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Game Center | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**InApp Purchases** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**iTunes** | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Limit Ad Tracking | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Lock Screen Notifications View** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Managed Apps Cloud Sync | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Multiplayer Gaming | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Music Service | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
News | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Paired Watch** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
**Password AutoFill** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Password Proximity Requests | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Password Sharing | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Radio Service | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Safari | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Safari Cookies | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Safari AutoFill | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Safari JavaScript | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Safari Popups | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Safari Fraud Warning | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Screenshot | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Spell Check | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Spotlight Internet Results | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
System App Removal | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
UIApp Installation | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
UIConfiguration Profile Installation | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
USB Restricted Mode | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Unpaired External Boot To Recovery | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Video Conferencing | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
**Voice Dialing** | <img src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Flat_cross_icon.svg" alt="FeatureDisabled" width="17px"/>
Wallpaper Modification | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>
Watch Wrist Detection | <img src="https://upload.wikimedia.org/wikipedia/commons/7/73/Flat_tick_icon.svg" alt="FeatureEnabled" width="17px"/>



The following configurations have been changed since the iOS 13 mobile configuration policy: -
COMING SOON!


Project currently under development, use at own risk.
Feel free to make modifications to this security policy.

[![Watch the video](./media/f50291c07544c2882f8bdf324ded7ca887c831f7.png)](https://youtu.be/RpyJ_l9gflg)

[![Watch the video]()](https://youtu.be/Aj9NyRTDb-4)