$dir = "C:\Users"
$modifiedfiles = Get-ChildItem $dir -Recurse | Where-Object { $_.LastWriteTime -ge (Get-Date).AddDays(-1) }
foreach ($file in $modifiedfiles) {
    Write-Output "File: $($file.FullName) was modified on $($file.LastWriteTime)"
}
