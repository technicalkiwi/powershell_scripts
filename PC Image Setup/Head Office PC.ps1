# ********************************************************************************
#
# Script Name: Head Office PC.ps1
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
$PublicShortcuts = "\\bgr-fp02\Photocopy\IT\shortcuts\Headoffice"

# Welcome Banner
Write-Host "##############################################"
Write-Host "#                                            #"
Write-Host "#   Welcome to the Head Office Setup Script! #"
Write-Host "#                                            #"
Write-Host "##############################################"
Write-Host " "


$PCname = Read-Host -Prompt "Please enter PC Name"
Rename-Computer -NewName $PCname -WhatIf

$credential = Get-Credential
Add-Computer -DomainName briscoes-nz.co.nz -Credential $credential -Restart -Force -WhatIf