$txtfile = "C:\TEMP\missing_pic.txt"
$missingItems = Get-Content $txtfile
#$missingitems = "one off item"
$SourceDirectory = "\\xxxxxxxxxxxxxxxxxxxx"
$DestinationDirectory = "xxxxxxxxxxxxxx"

#$Folders = Get-ChildItem -Recurse $SourceDirectory

foreach($item in $missingitems){
$item
$pics = $folders | Where{$_.Name -Match "$item" }

foreach($pic in $pics){
$pic | copy-item -destination $DestinationDirectory
$name = $pic.name
$Testpath = "$DestinationDirectory\$name"


if (Test-Path $Testpath){
$string = $name + " Has been copied Successfully"
$string
$string | Out-File -FilePath "C:\temp\log\images.txt" -Append
        } 
        
    }
}
