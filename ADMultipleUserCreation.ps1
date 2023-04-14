$users = Import-Csv -Path "users.csv"

foreach ($user in $users) {
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $username = $user.Username
    $password = $user.Password
    $email = $user.Email

    $name = "$firstName $lastName"

    New-ADUser -Name $name -GivenName $firstName -Surname $lastName -SamAccountName $username -UserPrincipalName "$username@contoso.com" -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -EmailAddress $email
}
