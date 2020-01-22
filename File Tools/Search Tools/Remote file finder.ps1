$TxtFile = "C:\TEMP\XXXXX.txt"
$pcs = Get-Content $TxtFile
#$pcs = "Ad hoc search"

foreach($pc in $pcs){

$searchpath = "\C$\path to search"
	
$path = "\\" + $pc + $searchpath
#$path

$location = Get-ChildItem -Path $path -Recurse -Filter "*file to look for*"
$FoundItems = $location.fullname
$FoundItems

}

