# Scipt to set new user passwords

$logpath = "c:\powershell\log\password changes.txt"

Import-Csv -Delimiter "," -Path "C:\powershell\docs\csv\new passwords.csv"

$user =
$pass = 

$newpass = ConvertTo-SecureString -AsPlainText $pass -Force
set-adaccountpassword  -identity $user -newpassword $newpass