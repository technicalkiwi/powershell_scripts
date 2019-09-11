$txtfile = "C:\TEMP\missing_pic1.txt"
$missingItems = Get-Content $txtfile
#$missingitems = "8131440"
$SourceDirectory = "\\bgr-fp01\WEBSITE IMAGES2312"
$DestinationDirectory = "\\bgr-fp01\tmp_images\DestinationFolders\aaron"
$log = "C:\powershell\logs\missingskulog.txt"

$Filestructure = Get-ChildItem -Recurse $SourceDirectory

foreach($itemsku in $missingitems){
$itemsku
#$images = ""
$images = $Filestructure | Where-Object{$_.Name -Match "$itemsku" }
$images
if($images.count -eq "0") {
   $outfile = ""
   $outfile = "There are no images for " + $itemsku
   $outfile | Out-File -FilePath $log -Append

} else{ foreach($image in $images){
$image | copy-item -destination $DestinationDirectory
$name = $image.name
$Testpath = "$DestinationDirectory\$name"


if (Test-Path $Testpath){
$string = $name + " Has been copied Successfully"
$string
$string | Out-File -FilePath "C:\powershell\logs\images.txt" -Append
        } 
        
    }
    }
   }