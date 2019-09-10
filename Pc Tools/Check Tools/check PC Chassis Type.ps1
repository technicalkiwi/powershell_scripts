$array =@()
$TxtFile = "C:\temp\j.txt"
$Computers = Get-Content $TxtFile
#$Computers = "bri-bgr-a0318"
$laptop = ""


foreach($computer in $Computers){
$laptop = ""
$Chassis = Get-WmiObject -Class win32_systemenclosure -ComputerName $computer

$chassisType = $Chassis.chassistypes

if($chassisType -eq 1 -or $chassisType -eq 2 -or $chassisType -eq 3 -or $chassisType -eq 4){
$laptop = $false
}else {$laptop = $true}
#if(Get-WmiObject -Class win32_battery -ComputerName $computer){ 
#$Laptop = $true }

if($laptop -eq $false){
$export = [PScustomobject]@{
Computer = $computer
Chassis  = "Deskptop"
}}elseif($laptop -eq $true){
$export = [PScustomobject]@{
Computer = $computer
Chassis  = "Laptop"
}}
$array += $export

$laptop
}

$array | Export-Csv -Path 'C:\Temp\chassis check.csv' -force -NoTypeInformation