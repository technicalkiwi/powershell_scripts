$Date = Get-Date
$Filter = 'Enabled -eq $true -and PasswordNeverExpires -eq $false -and Mail -like "*"'
$Properties = 'Mail', 'msDS-UserPasswordExpiryTimeComputed', 'PasswordExpired'
$Results = Get-ADUser -Filter $Filter -Properties $Properties |
    Where-Object {$_.PasswordExpired -eq $false} |
    Select-Object SamAccountName,
        Mail,
        @{
            Name       = 'ExpiryDate'
            Expression = {
                [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed')
            }
        },
        @{
            Name       = 'DaysRemaining'
            Expression = {
                (New-TimeSpan -Start $Date -End ([datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed'))).Days
            }
        }

        $Results | Where-Object {$_.DaysRemaining -lt 10}