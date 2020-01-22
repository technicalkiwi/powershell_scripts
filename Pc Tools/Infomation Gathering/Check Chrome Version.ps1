#sets the computers to check
$txtfile = "C:\Powershell\txt-files\...."
$Computers = get-content $txtfile
$array =@()


#runs through each computer and gets the chrome version number
foreach( $computer in $computers) {

$chrome = get-wmiobject win32_product -ComputerName $computer  | where-Object {$_.name -eq "google chrome"}

$chromename = $chrome.name
$chromever = $chrome.version

#Displays the machine name and chrome version on screen.
"$computer - $chromename - $chromever"

#Was going to exprt to txt file but decided on CSV
#$data = $computer + " - " + $chromename + " - " + $chromever

#casts the computer name, chromename and chrome version to a PSObject
$export= [pscustomobject]@{
Computer         = $computer
Chrome_Name      = $chromename
Chrome_Version   = $chromever

}
#adds the PSobject to an array
$array += $export
  } 

#Exports the array to a CSV file.
$array | Export-Csv -Path 'C:\TEMP\Chrome Version.csv' -force -NoTypeInformation
