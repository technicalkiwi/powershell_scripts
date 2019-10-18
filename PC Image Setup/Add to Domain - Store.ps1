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
$OU = "OU=HO Computers,OU=Computers OU Briscoe Group,DC=briscoes-nz,DC=co,DC=nz"

# Welcome Banner
Write-Host "##############################################"
Write-Host "#                                            #"
Write-Host "#   Welcome to the Head Office Setup Script! #"
Write-Host "#                                            #"
Write-Host "##############################################"
Write-Host " "

$hostname = read-host "Enter new Host name"
$credential = (Get-Credential BRISCOES\sharron)

Add-Computer -DomainName briscoes-nz.co.nz -Credential $credential -newname $hostname -OUPath $OU -Restart -Force

