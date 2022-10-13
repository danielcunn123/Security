# Snort Intrusion Detection & Prevention Firewall Rules



<h3>What is Snort</h3>
According to the official Snort frequently asked questions:
"Snort is an open source network intrusion prevention system, capable of performing real-time traffic analysis and packet logging on IP networks. It can perform protocol analysis, content searching/matching, and can be used to detect a variety of attacks and probes, such as buffer overflows, stealth port scans, CGI attacks, SMB probes, OS fingerprinting attempts, and much more."
­<br>
<br>
Snort is a well-known software solution aimed to defend networks from a variety of network-based attacks, known & unknown-vulnerabilities through detection and prevention techniques.
The cornerstone of Snort are the rules, there are many thousands of rules within each ruleset varying in power, precision, and flexibility. Snort provides a free ruleset for basic defence against emerging threats, also paid personal and business rulesets for advanced protection against known and unknown threats for system administrators and end-users.
<br>
<br>

An example of one rule is:
`alert tcp $HOME_NET any -> $EXTERNAL_NET [80,443,8200] (msg:"APP-DETECT GoToMyPC remote control attempt"; flow:to_server,established; content:"jedi"; nocase; content:"request="; distance:0; nocase; content:"jedi="; distance:0; nocase; metadata:service http; reference:url,www.gotomypc.com/remote_access/pc_remote_access; classtype:policy-violation; sid:7034; rev:6;)`
There are tens of thousands of rules developed by Snort, Security companies and security researchers with an interest in firewall security. I am not going to go in depth about rules, only discuss the rules within this repository.

<h3>Why</h3>
The first couple of rules ALERT upon detection of CVE-2022-35770 being exploited throughout the LAN, unfortunatly BLOCK is not possible.
Sensitive information is transmitted throughout the network, useful for attackers specifically capturing credentials, interception is not required for this exploit to work. Currently no Firewall I have tested mitigates this issue, so I needed to learn the Snort ruleset from scratch combined with the SMB packet structure.


<h3>Snort Rules</h3>

`alert tcp any any -> any 445 (msg:"BAD Responder"; content:"|01 4e fe 53 4d 42 40 00 01 00 16 00|"; rawbytes; sid:1234; rev:1;)`

`alert tcp any 445 -> any any (msg:"BAD Responder"; content:"|01 4e fe 53 4d 42 40 00 01 00 16 00|"; rawbytes; sid:1234; rev:1;)`

`alert tcp any any -> any 443 (msg:"Ledger Hardware Wallet Script"; content:"|20 73 63 72 69 70 74 72 75 6e 6e 65 72 2e 61 70 69 2e 6c 69 76 65 2e 6c 65 64 67 65 72 2e 63 6f 6d 00|"; metadata:policy max-detect-ips alert; reference:url,www.ledger.com/; sid:1234; rev:1;)`


