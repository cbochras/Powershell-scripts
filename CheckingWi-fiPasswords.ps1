$profileName = Read-Host "Enter the name of the Wi-Fi profile to check"

$wifidata = netsh wlan show profile name=$profileName key=clear
$password = $wifidata | Select-String "Key Content\s+:\s+(.+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }

if ($password) {
    Write-Output "The password for Wi-Fi profile '$profileName' is: $password"
} else {
    Write-Output "Password not found for Wi-Fi profile '$profileName'"
}
