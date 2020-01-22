# ********************************************************************************
#
# Script Name: HO PC Setup.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 26/9/2019
# Applies to: New or Rebuilt Head Office PC's
#
# Description: 
#
#
# ********************************************************************************
#

$PrintSvr = " Printer Server Name"
$PrinterName = " Printer Name"


$yes = "y", "Y", "yes", "Yes". "YES"
$no = "n", "N", "no", "No", "NO"

### Pick New computer name ###
$NewPCName = read-host -Prompt " Please enter a new name for the computer"

#Choose what to install
$VPNvar = read-host -Prompt "Do you want to Install the VPN Client?  (Y/N)"

if ($yes -ccontains $VPNVar){
$InstallVPN = "True" }
else {$InstallVPN = "False"}

### Install VPN ###
If ($InstallVPN -eq "True"){
    C:\Installs\VPN.exe /quiet
    }
    

### Copies accross Shortcuts ###
$Shortcuts = "\\bgr-fp02\Photocopy\IT\shortcuts\Headoffice"
$LocalShortcuts = "C:\Users\Public\Desktop\"
$PublicShortcuts = Get-ChildItem $Shortcuts

foreach($Shortcut in $PublicShortcuts.fullname){

Copy-Item $Shortcut $LocalShortcuts}



### Adds in Printers ###
Add-Printer -ConnectionName \\$PrintSvr\$PrinterName -ErrorAction Ignore


### Install Antivirus ###
C:\Installs\Antivirus\setup.exe /quiet /s /v

Start-sleep -Seconds 300

Rename-Computer -ComputerName $NewPCName