$DNSServer = "DNS_Server_Name"
$DNSZone = "domain.com"

$Records = Get-DnsServerResourceRecord -ZoneName $DNSZone -Server $DNSServer

foreach ($Record in $Records) {
    $DuplicateRecords = Get-DnsServerResourceRecord -ZoneName $DNSZone -Server $DNSServer -Name $Record.Name -Type $Record.Type | Select-Object -Skip 1
    foreach ($DuplicateRecord in $DuplicateRecords) {
        Remove-DnsServerResourceRecord -ZoneName $DNSZone -Server $DNSServer -InputObject $DuplicateRecord -Force
        Write-Output "Removed duplicate record $($DuplicateRecord.Name) of type $($DuplicateRecord.Type) from $($DuplicateRecord.RecordData)"
    }
}


$UnusedRecords = Get-DnsServerResourceRecord -ZoneName $DNSZone -Server $DNSServer | Where-Object {$_.Timestamp -lt (Get-Date).AddDays(-30)}
foreach ($UnusedRecord in $UnusedRecords) {
    Remove-DnsServerResourceRecord -ZoneName $DNSZone -Server $DNSServer -InputObject $UnusedRecord -Force
    Write-Output "Removed unused record $($UnusedRecord.Name) of type $($UnusedRecord.Type) from $($UnusedRecord.RecordData)"
}
