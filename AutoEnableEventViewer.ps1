#This script sets a registry key to disable User Account Control (UAC) prompt for Event Viewer and then opens Event Viewer with logging enabled. Note that this script requires administrative privileges to run successfully.

$registryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$name = "EnableLUA"
$value = 0
Set-ItemProperty -Path $registryPath -Name $name -Value $value

$cmd = "eventvwr.msc /c /enablelogging"
Start-Process -FilePath $cmd -Verb RunAs
