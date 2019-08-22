#sets file to pull in
$txtfile= "c:\temp\style_codes.txt"
$StyleCs= Get-Content $txtfile

#sets some variables
$SourceDirectory = "\\bgr-fp01\tmp_images\Rebel"
#$Reb = "c:\temp\images"
$templocation = "c:\temp\images"

#Creates the folder structure
foreach($StyleC in $StyleCs) {

New-Item -Path "$templocation\$stylec" -ItemType Directory
New-Item -Path "$templocation\$stylec\main" -ItemType Directory
New-Item -Path "$templocation\$stylec\alt" -ItemType Directory
New-Item -Path "$templocation\$stylec\main-model" -ItemType Directory
New-Item -Path "$templocation\$stylec\alt-model" -ItemType Directory
New-Item -Path "$templocation\$stylec\swatches" -ItemType Directory

#finds the images and puts them into the top level folder
$images = Get-ChildItem $SourceDirectory -Recurse | Where{$_.Name -Match "$stylec"} 
$images | copy-item -destination "$templocation\$stylec\"

 }   
