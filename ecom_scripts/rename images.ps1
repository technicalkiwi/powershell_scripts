#set some variables
$txtfile = "C:\TEMP\missing_pic.txt"
$imageSkus = Get-Content $txtfile
#$missingitems = "one off item"
$SourceDirectory = "\\xxxxxxxxxxxxxxxxxxxx"
$DestinationDirectory = "xxxxxxxxxxxxxx"


#pull in directory
$Folders = Get-ChildItem $SourceDirectory

foreach ($Folder in $folders){

    

#search through for images
foreach($imageSku in $imageSkus){
$item
$pics = $folders | Where{$_.Name -Match "$item" }



}