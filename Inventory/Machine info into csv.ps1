# ********************************************************************************
# Script Name: Remote Computer Info Into CSV.ps1
# Version: 1.0
# Author: Aaron Buchan
# Date: 07/1/2020
# Applies to: Remote Computers
#
# Description: This script Pulls in system information from remote computers and
# exports to a csv, once the CSV has been created the script will update only those
# Computers that are currently online,
# 
# Gets the Following information: ComputerName, User, Make, Model, OS, Architecture, CPU, RAM, MAC, ChassisType
#
# ********************************************************************************

$array=@()

$computers = Import-Csv -path "C:\Powershell\Inventory\pc info\Ho-pc.csv" -Delimiter "," 


foreach($Pc in $computers){
$Computer = $Pc.Computername

$testpath = "\\$computer\c$"
$online = Test-Path $testpath

if($online -eq $true){

# Information Gathering 
    $computerSystem = get-wmiobject Win32_ComputerSystem -Computer $Computer
    $computerOS = get-wmiobject Win32_OperatingSystem -Computer $Computer
    $computerCPU = get-wmiobject Win32_Processor -Computer $Computer
    $Networkconfig = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName $Computer
    $CPU = $computerCPU.Name -join "-"
    $Chassis = (Get-WmiObject -Class win32_systemenclosure -ComputerName $computer).chassistypes
    $chassisType = "$chassis"
  

$export = [PScustomobject]@{
ComputerName     = $computerSystem.Name
User             = $computerSystem.username
Make             = $computerSystem.Manufacturer
Model            = $computerSystem.Model
OS               = $computerOS.Caption
Architecture     = $computerOS.OSArchitecture
CPU              = $CPU
RAM              = ($computerSystem.TotalPhysicalMemory/1GB)
MAC              = $Networkconfig.MACAddress
ChassisType      = $chassistype
        }
$array += $export
    }elseif($online -eq $false){

$export = [PScustomobject]@{
ComputerName     = $PC.ComputerName
User             = $PC.User
Make             = $PC.Make
Model            = $PC.Model
OS               = $PC.OS
Architecture     = $PC.Architecture
CPU              = $PC.CPU
RAM              = $PC.RAM
MAC              = $PC.MAC
ChassisType      = $PC.ChassisType
        }
$array += $export
    }

}

$array | Export-Csv -Path "C:\Powershell\Inventory\pc info\Ho-pc-new.csv" -Force -NoTypeInformation
Remove-Item -Path "C:\Powershell\Inventory\pc info\Ho-pc.csv"
Rename-Item -Path "C:\Powershell\Inventory\pc info\Ho-pc-new.csv" -NewName "Ho-pc.csv"