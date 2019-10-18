#set some variables
$txtfile = "C:\TEMP\mp.txt"
$missingItems = Get-Content $txtfile
#$missingitems = "one off item"
$SourceDirectory = "\\xxxxxxxxxxxxxxxxxxxx"
$DestinationDirectory = "xxxxxxxxxxxxxx"

#pull in directory
$Folders = Get-ChildItem -Recurse $SourceDirectory

#search through for images
foreach($item in $missingitems){
$item
$pics = $folders | Where-Object{$_.Name -Match "$item" }

#if image is found move to a folder.
foreach($pic in $pics){
$pic | copy-item -destination $DestinationDirectory
$name = $pic.name
$Testpath = "$DestinationDirectory\$name"

#if image has been moved succesfully the write to log
if (Test-Path $Testpath){
$string = $name + " Has been copied Successfully"
$string
$string | Out-File -FilePath "C:\temp\log\images.txt" -Append
        } 
        
    }
}
