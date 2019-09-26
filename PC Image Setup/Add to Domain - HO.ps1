# ********************************************************************************
#
# Script Name: Add to Domain - HO.ps1
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

# Set Variables 
$DesktopOU = "OU=Desktops,OU=HO Computers,OU=Computers OU Briscoe Group,DC=briscoes-nz,DC=co,DC=nz"
$LaptopOU = "OU=Laptops,OU=HO Computers,OU=Computers OU Briscoe Group,DC=briscoes-nz,DC=co,DC=nz"
$StandardOU = "OU=HO Computers,OU=Computers OU Briscoe Group,DC=briscoes-nz,DC=co,DC=nz"

# Welcome Banner
Write-Host "##############################################"
Write-Host "#                                            #"
Write-Host "#   Welcome to the Head Office Setup Script! #"
Write-Host "#                                            #"
Write-Host "##############################################"
Write-Host " "

$Chassis = Get-WmiObject -Class win32_systemenclosure
$chassisnum = $Chassis.chassistypes

if($chassisnum -eq 3 -or $chassisnum -eq 4 -or $chassisnum -eq 6 -or $chassisnum -eq 7){
$chassistype = "Desktop"
}elseif($chassisnum -eq 8 -or $chassisnum -eq 9 -or $chassisnum -eq 10 -or $chassisnum -eq 30){
$chassistype = "Laptop"
}else{$Chassistype = "Unknown"}


if($chassistype -eq "Laptop") {
$OU = $LaptopOU
}Elseif($chassistype -eq "Desktop"){
$OU = $DesktopOU
}elseif($chassistype -eq "Unknown"){
$OU = $StandardOU
}

$credential = Get-Credential
Add-Computer -DomainName briscoes-nz.co.nz -Credential $credential -OUPath $OU -Restart -Force

