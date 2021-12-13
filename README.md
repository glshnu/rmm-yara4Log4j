# Scan for Log4j 
there are now two components. the first **YARA4Log4j** uses yara. the second uses **log4j2-scan** from logpresso.  
yara scans for infections, logpresso scans for vulnerable jar files.  
log4j2-scan is the prevention, YARA4Log4j is for searching on infected systems.  

**It is important to keep the program files always up to date.**

## log4j2-scan
the scanner engine is from logpresso  
https://github.com/logpresso/CVE-2021-44228-Scanner

**!!! i cannot say yet if logpresso is a trusted source !!!**  
**you can check the source on https://github.com/logpresso/CVE-2021-44228-Scanner/releases**


## YARA4Log4j 
a datto component to scan for the log4j vulnerability with yara 
 
I modify the DATTO RMM Component FireEye Red Team Countermeasure Scanner. 
 
the all-yara.yar file have only the rules from Florian Roth. 
https://gist.github.com/Neo23x0/e4c8b03ff8cdf1fa63b7d15db6e3860b 
 
i use the yara32.exe and yare64.exe in version v4.1.3-1755. 
  
## Links  
  
Direktlink to the .yar file  
https://github.com/Neo23x0/signature-base/blob/master/yara/expl_log4j_cve_2021_44228.yar  
(please update frequently)  
  
Direktlink to Datto Community  
https://community.datto.com/t5/Community-ComStore/RMM-with-YARA-to-find-Log4j-vulnerability-CVE-2021-44228/m-p/90902#M2149  
  
FullLog4j Scanner  
https://github.com/logpresso/CVE-2021-44228-Scanner  
  
