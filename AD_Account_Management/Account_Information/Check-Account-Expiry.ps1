# ********************************************************************************
#
# Script Name: Check Account Expiry.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 27/11/2019
# Applies to: All Head Office Ad Accounts
#
# Description: 
#
#
# ********************************************************************************

#Sets up an array for data storage
$array=@()
#Sets the date to check against
$expdate = (get-date).AddDays(+20)
#Sets the path for the CSV to be exported to
$CsvPath = 'C:\Powershell\Logs\Ad Acount expiration.csv'

# Pulls in all Ad Accounts in the selected OU
$accounts = Get-ADUser -filter * -SearchBase "OU=Head Office Accounts,DC=technicalkiwi,DC=com" -Properties AccountExpirationDate 
# Finds all accounts where Account expiry is greaterh than $Expdate
$ExpAccounts = $accounts | Where-Object AccountExpirationDate -GT $expdate

# If no accounts are in breach of policy then end the script
If($null -eq $SortedExpAccounts) {
}Else{ 
#For Each Account with an expiry greater than $expdate add the Name and Expiry date to an array
foreach( $ExpAccount in $ExpAccounts){

  $export = [PScustomobject]@{
User      = $ExpAccount.SamAccountName
Expiry    = $ExpAccount.AccountExpirationDate
        }
$array += $export
}
#Export the array to a CSV
$array | Export-Csv -path $CsvPath -Force -NoTypeInformation

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
}