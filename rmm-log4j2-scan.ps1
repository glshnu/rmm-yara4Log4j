function Scan {
    param ($drive)
    process {
        clear-variable scanResult -ErrorAction SilentlyContinue
        $scanResult=cmd /c "log4j2-scan.exe `"$drive`"\ "
        if ($scanResult -contains "Found CVE-2021-44228 vulnerability") {
            $script:varFound=1
            write-host "!!! Found CVE-2021-44228 vulnerability !!!"
            write-host $scanResult
            if (!(test-path "detections.txt" -ErrorAction SilentlyContinue)) {set-content -path "detections.txt" -Value "! Found CVE-2021-44228 vulnerability !"}
            Add-Content "detections.txt" -Value $scanResult
        }
        else {
            write-host $scanResult
        }

    }
}

# Only for Tests
#$env:ScanScope = 3
#

if ($env:ScanScope -eq 1) 
{
    write-host "Scan Drive C:"
    scan -drive c:
} 
elseif ($env:ScanScope -eq 2) {
    $di = Get-WmiObject -Class Win32_logicaldisk | ? {$_.DriveType -eq 2 -or $_.DriveType -eq 3} | select DeviceID
    write-host "Scan Drive(s) " $di.DeviceID
    foreach($d in $di) {
         write-host "scanning ..." $d.DeviceID " please wait"
         scan -drive $d.DeviceID
    }

} elseif ($env:ScanScope -eq 3) {
    $di = Get-WmiObject -Class Win32_logicaldisk | select DeviceID
    write-host "Scan Drive(s) " $di.DeviceID
    foreach($d in $di) {
         write-host "scanning ..." $d.DeviceID " please wait"
         scan -drive $d.DeviceID
    }
}

if ($script:varFound -eq 1) {
    write-host "-----------------------------------------------------"
    write-host "!!! WARNING !!! - Found CVE-2021-44228 vulnerability"
    write-host "! Files containing exploit code have been found on the system."
    write-host "  These files are noted above and locally on the device as detections.txt."
} else {
    write-host "- No files matching exploit code were found on the scanned drives."
}

if ($env:usrUDF -ge 1) {
    write-host "- If any instances of Log4J found '#RISK' will be written to UDF"
    if ($varUDFString -eq "RISK") {
	    set-itemProperty -path "HKLM:\Software\CentraStage" -Name custom$env:usrUDF -Value '#RISK:' -Force
    } elseif ($varUDFString -eq "FAIL") {
        set-itemProperty -path "HKLM:\Software\CentraStage" -Name custom$env:usrUDF -Value '#FAIL' -Force
    } else {
	    set-itemProperty -path "HKLM:\Software\CentraStage" -Name custom$env:usrUDF -Value '#OK' -Force
    }
} else {
    write-host "- Not writing data to a UDF."
}


exit $script:varFound
