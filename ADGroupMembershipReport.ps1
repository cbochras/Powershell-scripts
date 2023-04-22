Import-Module ActiveDirectory

$outputFile = "C:\ADGroupMembershipReport.csv"

$groupName = "GroupNameHere"

$groupMembers = Get-ADGroupMember -Identity $groupName

$results = @()

foreach ($member in $groupMembers) {
    $memberDetails = Get-ADUser -Identity $member.SamAccountName -Properties DisplayName,EmailAddress

    $results += [PSCustomObject]@{
        Name = $memberDetails.DisplayName
        Email = $memberDetails.EmailAddress
        UserName = $member.SamAccountName
        Group = $groupName
    }
}

$results | Export-Csv -Path $outputFile -NoTypeInformation
$results | Export-Csv -Path $outputFile -NoTypeInformation
