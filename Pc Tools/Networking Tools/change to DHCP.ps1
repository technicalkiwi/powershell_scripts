$txtfile= "C:\temp\PC.txt"
$Computers= Get-Content $txtfile
#$computers = "one off"
$array=@()

foreach($computer in $computers){

$netAdapters = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $computer
foreach ($netadapter in $netadapters) {
 if($netadapter.ipenabled -eq "True") { $netadapter.EnableDHCP()}
  #ac -path 'C:\TEMP\log\dhcp.txt' "$computer has been set to dhcp" 
 }
 #$netadapters.EnableDHCP()
 ac -path 'C:\TEMP\log\dhcp.txt' "$computer has been set to dhcp" 
}
