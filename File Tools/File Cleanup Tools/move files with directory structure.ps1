#This Script Will Move files to new location while maintaining directory structure

#Set the max age of files
$currentdate = Get-Date
$deletedate = $currentdate.AddDays(-500)

#Set source and Target Directory
$sourcedir = "\\Enter Source Directory"
$targetdir = "\\Enter Target Directory"

#Pull in source file structure and then recreate it in the target directory
Get-ChildItem $sourceDir -Recurse |  Where-Object{$_.LastWriteTime -lt $deletedate}| ForEach-Object {
   $dest = $targetDir + $_.FullName.SubString($sourceDir.Length)

   If (!($dest.Contains('.')) -and !(Test-Path $dest))
   {
        mkdir $dest
   }
#Move the item to the same place within the desitination folder structure
   move-Item $_.FullName -Destination $dest -Force -WhatIf
}
