""" example of a PowerShell script that can be used to monitor network connectivity """



$ping = New-Object System.Net.NetworkInformation.Ping
$ip = "8.8.8.8"
$count = 3

while($true) {
    $reply = $ping.Send($ip, 1000)
    if($reply.Status -eq "Success") {
        Write-Host "Ping successful at $(Get-Date)"
    }
    else {
        Write-Host "Ping failed at $(Get-Date)"
    }
    Start-Sleep -Seconds $count
}
