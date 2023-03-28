 #Read user details from the CSV file
$CSVRecords = Import-CSV "C:\AzureADUsers.csv"
$i = 0;
$TotalRecords = $CSVRecords.Count
  
#Array to add the status result
$UpdateResult=@()
  
#Iterate users one by one and set a random password 
Foreach($CSVRecord in $CSVRecords)
{
$UserId = $CSVRecord.'UserPrincipalName'
 
$i++;
Write-Progress -activity "Processing $UserId " -status "$i out of $TotalRecords users completed"
 
#Generate a random password
$random_password = ''
$random_password +=  ("ABCEFGHJKLMNPQRSTUVWXYZ".ToCharArray() | Get-Random -Count 4) -join ''
$random_password += ("@#%&*?![\]^".ToCharArray() | Get-Random -Count 2) -join ''
$random_password += ("abcdefghijkmnopqrstuvwxyz".ToCharArray() | Get-Random -Count 4) -join ''
$random_password += ("123456789".ToCharArray() | Get-Random -Count 2) -join ''
 
#Convert the random password to a secure string 
$NewPassword = ConvertTo-SecureString $random_password -AsPlainText -Force
 
try
{
#Set the random password value
Set-AzureADUserPassword -ObjectId $UserId -Password $NewPassword -ForceChangePasswordNextLogin $False
$ResetStatus = "Success"
}
catch
{
$ResetStatus = "Failed: $_"
}
  
#Add reset password status
$UpdateResult += New-Object PSObject -property $([ordered]@{
User = $UserId
NewPassword = $random_password
ResetPasswordStatus = $ResetStatus
})
}
  
#Display the reset password status result
$UpdateResult | Select User,NewPassword, ResetPasswordStatus| FT
  
#Export the reset password status report to a CSV file
$UpdateResult | Export-CSV "C:\BulkResetRandomPwdStatus.CSV" -NoTypeInformation -Encoding UTF8