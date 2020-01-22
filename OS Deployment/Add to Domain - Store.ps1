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
$OU = "OU=HO Computers,OU=Computers OU Technical Kiwi,DC=technicalkiwi,DC=com"

# Welcome Banner
Write-Host "##############################################"
Write-Host "#                                            #"
Write-Host "#   Welcome to the Head Office Setup Script! #"
Write-Host "#                                            #"
Write-Host "##############################################"
Write-Host " "

$hostname = read-host "Enter new Host name"
$credential = (Get-Credential TechnicalKiwi\Admin)

Add-Computer -DomainName technicalkiwi.com -Credential $credential -newname $hostname -OUPath $OU -Restart -Force

