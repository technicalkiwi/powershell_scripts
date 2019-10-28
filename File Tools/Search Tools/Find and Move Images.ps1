#set some variables
$logpath = "C:\Powershell\Logs"
$txtfile = "C:\TEMP\missingitems.txt"
$missingItems = Get-Content $txtfile
#$missingitems = "one off item"
$SourceDirectory = "\\xxxxxxxxxxxxxxxxxxxx"
$DestinationDirectory = "xxxxxxxxxxxxxx"

#pull in directory
$Folders = Get-ChildItem -Recurse $SourceDirectory

#search through for images
foreach($MissingItem in $MissingItems){
$MissingItem
$items =""
$items = $folders | Where-Object{$_.Name -Match "$MissingItem" }

If($item.count -eq "0"){
    $log = ""
    $log = "There are no Items for " + $item
    $log | Out-File -FilePath $logpath -Append
}else {
#if image is found move to a folder.
foreach($item in $items){
$item | copy-item -destination $DestinationDirectory
$name = $item.name
$Testpath = "$DestinationDirectory\$name"

#if image has been moved succesfully the write to log
if (Test-Path $Testpath){
$string = ""
$string = $name + " Has been copied Successfully"
$string
$string | Out-File -FilePath $logpath -Append
            }
        } 
    }
}
