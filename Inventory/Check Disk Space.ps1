# ********************************************************************************
#
# Script Name: Check Disk Space.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 06/12/2019
# Applies to: Remote Pc's
#
# Description:
#
# ********************************************************************************

# Define Some Variables
# Arrays for holding Data
$FullDisks =@()
$OfflineArray = @()

$FullDiskCsvPath = 'C:\Powershell\Logs\Fulldisks.csv'
$OfflineMachineCsvPath = 'C:\Powershell\Logs\OfflineMachines.csv'

# Txt File of all POS Machine
$PosList = "C:\Powershell\txt-files\Computers\POS.txt"
$StoreMachines = Get-Content $PosList

ForEach($StoreMachine in $StoreMachines){

$Online = Test-Path "\\$StoreMachine\c$"
If($Online -eq $true){
# Pulls in the disk info for C Drive
$StoreMachineDisk = Get-WmiObject -class Win32_LogicalDisk -ComputerName $StoreMachine | Where-Object DeviceId -eq "C:"   
#Sets the Alert treshold to 10% of total Size.
$AlertTreshhold = 10

# Queries the amount of free space
$FreeDiskSpace = [math]::Round(($StoreMachineDisk.freespace) / 1GB)

# If the Free space is below the threshold add the machine to an Object
If($FreeDiskSpace -lt $AlertTreshhold){
    
    $TempFolder = Get-ChildItem "\\$StoreMachine\c$\windows\temp"
    $size = $TempFolder | Measure-Object -property Length -sum
    $TempSize = [math]::round(($size.sum) / 1GB)
    
    $FullArray = [PSCustomObject]@{
        Computer = $StoreMachine
        Status   = "Disk is below Treshold"
        FreeSpace = "$FreeDiskSpace" + " GB"
        TempSize  = "$TempSize" + " GB"
            }
# Adds the Alert to the Full Disks Array
    $FullDisks += $FullArray
        }
#If the machine is offline add machine to an object.
}elseif($online -eq $False){
    $Array = [PSCustomObject]@{
        Computer = $StoreMachine
        Status   = "Is Offline"
            }
    $OfflineArray += $Array   
        } 
  
}

$FullDisks | Export-Csv -path $FullDiskCsvPath -Force -NoTypeInformation
$OfflineArray | Export-Csv -path $OfflineMachineCsvPath -Force -NoTypeInformation 


#Create and send the Email with Attachment.

$mailsettings = @{
    'SmtpServer'  = "Mail server"
    'To' = "Emailaddress@domain"
    'From' = " Senders Name <sender@domain>"
    'Subject' = "Machines with FUll Disks"
    'Body' = "The attachted Accounts have an Disk Space below the threshold"
    'Attachments' = $FullDiskCsvPath, $OfflineMachineCsvPath
    }
    
    Send-MailMessage @mailsettings
    