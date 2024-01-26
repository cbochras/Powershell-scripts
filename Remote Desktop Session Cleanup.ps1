# Define the remote computer name
$remoteComputer = "RemoteComputerName"

# Get all disconnected sessions on the remote computer
$disconnectedSessions = quser /server:$remoteComputer | Where-Object { $_ -match 'Disc' }

# Log off disconnected sessions
foreach ($session in $disconnectedSessions) {
    # Extract session ID
    $sessionId = $session -replace '\s+', ',' -split ',' | Select-Object -Index 2

    # Log off the disconnected session
    logoff $sessionId /server:$remoteComputer
}

Write-Host "Remote Desktop Session cleanup completed."
