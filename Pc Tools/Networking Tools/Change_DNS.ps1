# ********************************************************************************
#
# Script Name: Change_DNS.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 05/03/2020
# Applies to: Briscoes Workstations
#
# Description: Change Machines in store to use BGR-FP03 as the secondary DNS Address.
#
# ********************************************************************************

############ Setup the Variables.
$export =@()

$textfile = "C:\temp\computers.txt"
$computers = get-content $textfile
$Offline = C:\Powershell\Logs\Offine_DNS.txt

$StoreDNSServer = "192.168.71.68"
$HODNSServer = "192.168.10.80"
$DNSServers = $StoreDNSServer,$HODNSServer

############ SET NEW DNS INFO

foreach($computer in $computers){
    $ONLINE = Test-Path \\$Computer\C$\
If($ONLINE -eq $false) {$computer | out-file -filepath $Offline -Append 
    }elseif ($online -eq $true) {

$NICs = Get-WMIObject Win32_NetworkAdapterConfiguration -computername $computer |Where-Object{$_.IPEnabled -eq “TRUE”}
  Foreach($NIC in $NICs) {
 $NIC.SetDNSServerSearchOrder($DNSServers)
 $NIC.SetDynamicDNSRegistration(“TRUE”)
}
    }
        }

######## Query new DNS Info
foreach($computer in $computers){
    $ONLINE = Test-Path \\$Computer\C$\
If($ONLINE -eq $true){
    $Networks = Get-WMIObject Win32_NetworkAdapterConfiguration -computername $computer |Where-Object{$_.IPEnabled -eq “TRUE”}
    
    foreach($network in $Networks){    
     $DNSServers = $Network.DNSServerSearchOrder
      $PrimaryDNSServer = $DNSServers.Item(0)
      $SecondaryDNSServer = $DNSServers.Item(1)
    
     $array = [pscustomobject]@{ 
      computer = $computer
      PrimaryDNSServer = $PrimaryDNSServer
      SecondaryDNSServer = $SecondaryDNSServer
      }
     $export += $array
    }
      }
        }
    
$export | Export-Csv -Path C:\powershell\logs\dns_change_log.csv -NoTypeInformation -Force