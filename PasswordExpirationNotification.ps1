$DaysBeforeExpiration = 7

$ExpirationDate = (Get-Date).AddDays($DaysBeforeExpiration)

$Users = Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $false -and PasswordExpired -eq $false -and PasswordLastSet -lt $ExpirationDate} -Properties EmailAddress

foreach ($User in $Users) {
    if ($User.EmailAddress) {
        $Subject = "Your password will expire in $DaysBeforeExpiration days"
        $Body = "Dear $($User.DisplayName),`n`nYour password will expire in $DaysBeforeExpiration days. Please change your password as soon as possible to avoid any disruptions.`n`nThank you.`n`nThe IT team."
        Send-MailMessage -To $User.EmailAddress -From "noreply@company.com" -Subject $Subject -Body $Body -SmtpServer "smtp.company.com"
    }
}
