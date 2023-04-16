#This script connects to the Exchange server, finds mailboxes with deleted items, sets the date range for deleted items, loops through each deleted mailbox, and removes deleted items older than the specified date.
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://<ExchangeServerName>/PowerShell/ -Authentication Kerberos
Import-PSSession $Session

$DeletedMailboxes = Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Where-Object { $_.DisconnectDate -ne $null }

$DeleteBeforeDate = (Get-Date).AddDays(-30)

foreach ($Mailbox in $DeletedMailboxes) {
    $MailboxName = $Mailbox.DisplayName
    $MailboxGuid = $Mailbox.MailboxGuid
    $DeletedItems = Get-MailboxFolderStatistics -Identity $MailboxName -FolderScope RecoverableItems | Where-Object { $_.ItemsInFolder -gt 0 }
    foreach ($Item in $DeletedItems) {
        $ItemDate = $Item.FolderPath.ToString().Split("/")[2]
        if ($ItemDate -lt $DeleteBeforeDate) {
            Write-Host "Removing item $($Item.Identity) from mailbox $MailboxName"
            Remove-RecoverableItems -Identity $MailboxGuid -ItemIds $Item.Identity -Confirm:$false
        }
    }
}

Remove-PSSession $Session
