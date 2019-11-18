$array =@()

#Define the Computers to be tested
#Pulls the list from a text file.
$TxtFile = "C:\Powershell\txt-files\Computers\All Computers.txt"
$Computers = Get-Content $TxtFile

#Goes through each computer in the file
$Offline = "C:\temp\offline.txt"


foreach($computer in $Computers)
{
    $ONLINE = Test-Path \\$Computer\C$\
If($ONLINE -eq $false) {$computer | out-file -filepath $Offline -Append 
    }elseif ($online -eq $true) { 
    
#Defines the variables used in getting the Required Information.
    $computerSystem = get-wmiobject Win32_ComputerSystem -Computer $Computer
    $computerOS = get-wmiobject Win32_OperatingSystem -Computer $Computer
    $computerCPU = get-wmiobject Win32_Processor -Computer $Computer
    $Networkconfig = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName $Computer

    $IPAddress = $NetworkConfig.IpAddress -join "-"
    $CPU = $computerCPU.Name -join "-"
   
$export = [PScustomobject]@{
Computer         = $computerSystem.Name
Make             = $computerSystem.Manufacturer
Model            = $computerSystem.Model
OS               = $computerOS.Caption
Architecture     = $computerOS.OSArchitecture
CPU              = $CPU
RAM              = ($computerSystem.TotalPhysicalMemory/1GB)
IP               = $IPAddress
}

$array += $export

        }
    }


 $array

$array | Export-Csv -Path "C:\Powershell\Inventory\pc info\pc.csv" -force -NoTypeInformation -Append
