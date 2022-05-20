Mozilla Firefox <72 Denial of Service by RGFulw*


**Affected Platforms: -**
Windows
Linux
MacOS


**Tested On: -**
Firefox 68.0, 69.0, 70.0, 71.0, Multiple ESR versions.
TOR browser


**Summary: -**
The regexp 'looksLikeURL' Suffers from a Denial of Service Issue Due to Improperly Handling Specific Characters, Allowing Attackers to Send a Specially Crafted URLs to Crash/Hang a Remote Users Browser.


**Short Description: -**
All versions of Firefox except ESR & Mobile platforms are affected by a specially crafted URL causing the browser to crash/hang on all desktop platforms.


**Long Description: -**
The function 'looksLikeURL' in 'toolkit/components/places/UnifiedComplete.jsm' does not properly handle characters ('_' & '?') when these characters are appended onto a URL containing ~26 '.' symbols this can cause the browser to crash, resulting in complete loss of information (unrecoverable) on all other tabs.
This patch replaces the regexp with splitting the string on "." and then checking a smaller regexp against each of the parts.

Snippet of modified code from 'toolkit/components/places/UnifiedComplete.jsm' (lines 526-535)

 function looksLikeUrl(str, ignoreAlphanumericHosts = false) {
   // Single word including special chars.
   return (
     !REGEXP_SPACES.test(str) &&
     (["/", "@", ":", "["].some(c => str.includes(c)) ||
       (ignoreAlphanumericHosts
-        ? /^([\[\]A-Z0-9.:-]+[\.:]){3,}[\[\]A-Z0-9.:-]+$/i.test(str)   #OLD
+        ? /^([\[\]A-Z0-9.-]+\.){3,}[^.]+$/i.test(str)                  #NEW
         : str.includes(".")))
   );
 }

More info @ https://bugzilla.mozilla.org/show_bug.cgi?id=1587867

**Proof of Concept: -**

Remove 'https:// & .com/' from the following URL 'https://firefoxcrash.com/.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a.a_'
Make sure to include the underscore '_' at the end of the URL string.

~~VIDEO: -   https://youtu.be/KJkCVUIaUEI~~ **REUPLOAD PLANNED**



**Expected Result: -**
It shouldn't be possible to crash/hang remote browser upon inserting URL into address bar.


**Observed Result: -**
Remote browser crashes upon loading character '_' or '?' appended to end of URL.



Special Thanks to Drew Willcoxon (adw) and Marco Bonardo (mak) for the quick response & patch.