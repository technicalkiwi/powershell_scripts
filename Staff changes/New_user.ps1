# ********************************************************************************
#
# Script Name: New_user.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 21/9/2019
# Applies to: Users
#
# Description: This script performs the normal steps involved in creating a new AD 
# user, including: disabling in AD, exporting security 
# group membership, removing user from security groups, exporting distribution 
# group member ship, removing user from distribution groups, forwarding their
# future emails, option to disable mailbox, and disabling ActiveSync.
#
# Note: Skips the following protected users; "user1", "user2", "user3", "user4", "user5"
#
# ********************************************************************************

#Import Modules
#Import-Module ActiveDirectory
#Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

# Set Variables 
$PathLog = "\\enter\network\path"
$Random = -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
$DTStamp = get-date -Format u | ForEach-Object{$_ -replace "z"}

# Welcome Banner
Write-Host "##############################################"
Write-Host "#                                            #"
Write-Host "#   Welcome to the User Creation Script!     #"
Write-Host "#                                            #"
Write-Host "##############################################"
Write-Host " "