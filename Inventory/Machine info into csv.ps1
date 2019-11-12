$array =@()

#Define the Computers to be tested
#Pulls the list from a text file.
$TxtFile = "C:\Powershell\txt-files\Computers\All Computers.txt"
$Computers = Get-Content $TxtFile

#Goes through each computer in the file

$Offline = "C:\temp\offline.txt"

#Clears the live computers file.

#checks to see if PC's are live, if they are puts them into a text file.
foreach($computer in $Computers)
{
    $ONLINE = Test-Path \\$Computer\C$\
If($ONLINE -eq $false) {$computer | out-file -filepath $Offline -Append 
    }elseif ($online -eq $true) { 
    
#Defines the variables used in getting the Required Information.
    $computerSystem = get-wmiobject Win32_ComputerSystem -Computer $Computer
    $computerOS = get-wmiobject Win32_OperatingSystem -Computer $Computer
    $computerCPU = get-wmiobject Win32_Processor -Computer $Computer
   
$export = [PScustomobject]@{
Computer         = $computerSystem.Name
Make             = $computerSystem.Manufacturer
Model            = $computerSystem.Model
OS               = $computerOS.Caption
Architecture     = $computerOS.OSArchitecture
CPU              = $computerCPU.name 
RAM              = ($computerSystem.TotalPhysicalMemory/1GB)
}

$array += $export

        }
    }
}

 $array

$array | Export-Csv -Path "C:\Powershell\Inventory\pc info\pc.csv" -force -NoTypeInformation -Append