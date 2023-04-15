# Get list of servers to check
$servers = Get-Content "C:\serverlist.txt"

foreach ($server in $servers) {
    Write-Host "Checking disk space on $server..."

    $disks = Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter "DriveType=3" | Select-Object DeviceID,FreeSpace,Size

    foreach ($disk in $disks) {
        $percentFree = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 2)

        Write-Host "$server $($disk.DeviceID) $($disk.FreeSpace) bytes free out of $($disk.Size) bytes total ($percentFree% free)"
    }
}
