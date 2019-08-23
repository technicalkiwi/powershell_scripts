#===================================================
# SET YOUR FOLDER NAME HERE
$userfolder = "xxxxxxxx"
#==================================================

#sets some variables
$Reb = "\\bgr-fp01\tmp_images\Rebel"
$TempLocation = "C:\Temp\"
$DestinationFolder = "xxxxxxxxxxxxxxx"
$userpath = "$DestinationFolder\$userfolder"

#defines folder location
$folders = Get-ChildItem c:\temp\images

#runs through each folder and creates variables
foreach ($folder in $folders) {
$MainFiles = Get-ChildItem C:\temp\images\$folder\main
$AltFiles = Get-ChildItem C:\temp\images\$folder\alt
$MainModelFiles = Get-ChildItem C:\temp\images\$folder\main-model
$altModelfiles = Get-ChildItem C:\temp\images\$folder\alt-model

#Rename files in the Main folder
foreach ($file in $MainFiles){
$path = "C:\temp\images\$folder\main\"
$filename = "$folder" + "_prod_default_1.jpg"
rename-item -Path $path\$file -NewName $Filename
Get-ChildItem $path | Copy-Item -destination "$userpath\main"
}


#Rename files in Main-Model Folder
foreach ($file in $MainModelFiles){
$path = "C:\temp\images\$folder\main-model\"
$filename = "$folder" + "_prod_model_1.jpg"
rename-item -Path $path\$file -NewName $Filename
Get-ChildItem $path | Copy-Item -destination "$userpath\main-model"
}


#Rename files in alt Folder
$altnum = 1
foreach ($file in $altFiles){
$path = "C:\temp\images\$folder\alt\"
$filename = "$folder" + "_prod_default_" + $altnum + ".jpg"
rename-item -Path $path\$file -NewName $Filename
$altnum = ($altnum + 1) 
Get-ChildItem $path | Copy-Item -destination "$userpath\alt"
}


#Rename files in alt Folder
$altmodelnum = 1
foreach ($file in $AltModelFiles){
$path = "C:\temp\images\$folder\alt-model\"
$filename = "$folder" + "_prod_model_" + $altModelnum + ".jpg"
rename-item -Path $path\$file -NewName $Filename
$altnum = ($altmodelnum + 1) 
Get-ChildItem $path | Copy-Item -destination "$userpath\alt-model"
}


}



