while ($true) {
    $command = Read-Host "Enter your command"
    $output = Invoke-Expression $command
    Write-Host $output
}
