#set some variables
$txtfile = "C:\TEMP\missing_pic.txt"
$itemSkus = Get-Content $txtfile
#$itemSkus = "8137011", "8137014", "8136981"
$mainDirectory = "C:\TEMP\images\main"
$main_modelDirectory = "C:\TEMP\images\main-model"
$altDirectory = "C:\TEMP\images\alt"
$Alt_modelDirectory = "C:\TEMP\images\alt-model"

$mainlog = "C:\TEMP\log\mainlog.txt"
$main_modellog = "C:\TEMP\log\main_modellog.txt"
$altlog = "C:\TEMP\log\altlog.txt"
$alt_modellog = "C:\TEMP\log\alt_modellog.txt"

$MainImages = Get-ChildItem $mainDirectory
$main_ModelImages = Get-ChildItem $main_ModelDirectory
$altImages = Get-ChildItem $altDirectory
$alt_modelImages = Get-ChildItem $alt_modelDirectory

foreach ($ItemSku in $ItemSkus){

#FOR MAIN FOLDER IMAGES

#set main image to null
$mainImage = ""
$mainImage = $MainImages | Where-Object{$_.Name -Match "$ItemSku"}
#if more than one image is present write to error log
if ($mainimage.count -gt "1") {
   $outfile = ""
   $outfile = "There Is more than one main image for " + $itemSku
   $outfile | Out-File -FilePath $mainlog -Append
   }elseif ($mainImage.count -eq "0"){
   $outfile = ""
   $outfile = "There is no main image for " + $itemSku
   $outfile | Out-File -FilePath $mainlog -Append
   }elseif ( $mainimage.count -eq "1") {   #rename the file to match convention
    $newfilename = ""
    $newfilename = "$itemsku" + "_prod_default_1.jpg"
    $mainimage | Rename-Item -NewName $newfilename 
    }


#FOR MAIN MODEL FOLDER IMAGES

#set main image to null
$main_ModelImage = ""
$main_ModelImage = $Main_ModelImages | Where-Object{$_.Name -Match "$ItemSku"}
#if more than one image is present write to error log
if ($main_Modelimage.count -gt "1") {
   $outfile = ""
   $outfile = "There Is more than one main model image for " + $itemSku
   $outfile | Out-File -FilePath $mainlog -Append
   }elseif ($main_ModelImage.count -eq "0"){
   $outfile = ""
   $outfile = "There are no main model images for " + $itemSku
   $outfile | Out-File -FilePath $main_modellog -Append
   }elseif ( $main_Modelimage.count -eq "1") {   #rename the file to match convention
    $newfilename = ""
    $newfilename = "$itemsku" + "_prod_model_1.jpg"
    $main_Modelimage | Rename-Item -NewName $newfilename 
    }



    #FOR ALT FOLDER IMAGES

#set main variable to null
$altImage = ""
$altImage = $altImages | Where-Object{$_.Name -Match "$ItemSku"}
$altcount = 2
#Run through all images adding 1 at the end
foreach($altimag in $altImage){
    $newfilename = ""
    $newfilename = "$itemsku" + "_prod_default_" + $altcount + ".jpg"
    $altimag | Rename-Item -NewName $newfilename 
    $altcount = ($altcount + 1)
    }

        #FOR ALT MODEL FOLDER IMAGES

#set main variable to null
$alt_modelImage = ""
$alt_modelImage = $alt_modelImages | Where-Object{$_.Name -Match "$ItemSku"}
$alt_modelcount = 2
foreach($alt_modelimag in $alt_modelImage){
    $newfilename = ""
    $newfilename = "$itemsku" + "_prod_model_" + $alt_modelcount + ".jpg"
    $alt_modelimag | Rename-Item -NewName $newfilename 
    $alt_modelcount = ($alt_modelcount + 1)
    }

}
