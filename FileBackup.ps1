#The script prompt the user to choose what file/directory to back it up to the C dir and after that check in the users if there's onedrive dir opened, if so a copy of the backuped file/folder will be made and stherefore synced.
$sourcePath = Read-Host "Enter the path of the file or folder you want to backup"
$backupDir = "C:\Backup"

if(!(Test-Path -Path $backupDir -PathType Container)){
    New-Item -ItemType Directory -Path $backupDir
}

$zipFileName = (Get-Date).ToString("yyyyMMdd-HHmmss") + ".zip"
$zipFilePath = Join-Path -Path $backupDir -ChildPath $zipFileName

Compress-Archive -Path $sourcePath -DestinationPath $zipFilePath

Write-Host "Backup completed. Backup file saved at $zipFilePath"

$onedriveFolders = Get-ChildItem -Path "$env:USERPROFILE" -Directory -Recurse -Filter "*onedrive*"
if ($onedriveFolders.Count -gt 0) {
    $onedriveFolder = $onedriveFolders | Select-Object -First 1
    $onedrivePath = Join-Path -Path $onedriveFolder.FullName -ChildPath "Backup"
    if (!(Test-Path -Path $onedrivePath -PathType Container)){
        New-Item -ItemType Directory -Path $onedrivePath
    }
    $onedriveFilePath = Join-Path -Path $onedrivePath -ChildPath $zipFileName
    Copy-Item $zipFilePath $onedriveFilePath
    Write-Host "Backup file copied to OneDrive folder at $onedriveFilePath"
}
else {
    Write-Host "No OneDrive folder found."
}
