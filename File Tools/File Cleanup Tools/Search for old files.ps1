
$array =@()                               # Create Array
$SouceDirectory = "P:\"                   # Set Directory to search
$CurrentDate = Get-Date                   # Gets Current date
$OldDate = $CurrentDate.AddDays(-365)     # Search for files older than this

#Pull in full directory Structure
$Directories = Get-ChildItem  -Recurse  -Path "$SouceDirectory" -erroraction ignore

#Select files older than the specified time fram
$UnusedFiles = $Directories | Where-Object {$_.LastAccessTime -lt $OldDate}

# Go through each file and check the size
#if its bigger than 1MB then write the files data to CSV
foreach($file in $UnusedFiles){

$lastaccessdate = $file.lastaccesstime      # Set file last access time 
$filesize = [math]::round($file.Length/1MB) # Convert file length to MB's
$filepath = $file.fullname                  # Set the files full filepath
$filesize
if($filesize -gt 1){
  # If File is bigger than 1 MB then cast the variables to an customobject
$export = [PScustomobject]@{
      LastAccessTime = $lastaccessdate
      FileSize_MB = $filesize
      File_Path = $filepath
      }
      # Add the data from the Custom Object to the Array
      $array+= $export

    }else {} # If file smaller than 1MB ignore it.
      }
    # Export the Array to a CSV
      $array | Export-Csv -Path 'C:\temp\oldfiles.csv' -force -NoTypeInformation -Append
