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

$yes = "y", "Y", "yes", "Yes". "YES"

### Pick New computer name ###
$NewName = read-host -Prompt " Please enter a new name for the computer"

#Choose what to install
$VPNvar = read-host -Prompt "Do you want to Install the VPN Client?  (Y/N)"

if ($yes -ccontains $VPNVar){
$InstallVPN = "True" }
else {$InstallVPN = "False"}


### Copies accross Shortcuts ###
$Shortcuts = "\\bgr-fp02\Photocopy\IT\shortcuts\Headoffice"
$LocalShortcuts = "C:\Users\Public\Desktop"
$PublicShortcuts = Get-ChildItem $Shortcuts

foreach($Shortcut in $PublicShortcuts.fullname){

Copy-Item $Shortcut $LocalShortcuts}



### Adds in Printers ###
Add-Printer -ConnectionName \\bgr-prt-svr01\b-mor-cc-m -ErrorAction Ignore
Add-Printer -ConnectionName \\bgr-prt-svr01\b-mor-queue1 -ErrorAction Ignore


### Install Symantec ###
C:\Installs\Symantec-64bit\setup.exe /quiet /s /v

sleep -Seconds 300

Rename-Computer -ComputerName $NewName