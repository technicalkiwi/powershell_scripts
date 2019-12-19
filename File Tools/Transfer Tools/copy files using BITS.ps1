# ********************************************************************************
#
# Script Name: copy files using BITS.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 20/12/2019
# Applies to: Transfer of files to remote PC
#
# Description: Transfer files to remote Pc using Background Intelligent Transfer Service
#
# ********************************************************************************

# Begin Script

# Import BitsTransfer Module
Import-Module BitsTransfer

# Set Some Variables
$Description = " Description of Transfer"
$svrs = get-content "Paht\to\txt\file"
$filepath = "Path\to\transfer\folder"

# Pull in all 
$Files = Get-ChildItem $filepath

foreach($svr in $svrs){
    $Destination = "\\" + $svr + "\C$\installs"
$test = Test-Path $Destination

if($test -eq $false){
mkdir -Path $Destination
Foreach($file in $Files){
Start-BitsTransfer -Source $file.FullName -Destination $Destination\ -Description $Description -DisplayName $Description -transfertype Download
}

}elseif($test -eq $true){

Foreach($file in $Files){
    Start-BitsTransfer -Source $file.FullName -Destination $Destination\ -Description $Description -DisplayName $Description -transfertype Download
    }
}

}