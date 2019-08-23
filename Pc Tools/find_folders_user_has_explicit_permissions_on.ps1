$directory = 'P:/'
$txtfile = "C:\Temp
$users = get-content $txtfile
$logpath = "C:\TEMP\permission log"
#$directory = "C:\TEMP"

$folders = get-childitem $directory -Recurse -erroraction ignore | where-object {$_.PSIsContainer} 


foreach ($user in $users)
{
foreach($folder in $folders) {
$ACL = $folder | get-acl
$aclaccess = $ACL.access


if ($aclaccess.IdentityReference -eq $user) {
$folder.FullName
$string = $user + " has permission on " + $folder.fullname
$string | out-file -FilePath "C:\TEMP\permission log\$user.txt" -append

        }
    }

}


