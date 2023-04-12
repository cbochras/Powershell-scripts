# Get basic device information
$osInfo = Get-CimInstance Win32_OperatingSystem
$computerSystem = Get-CimInstance Win32_ComputerSystem
$processor = Get-CimInstance Win32_Processor
$networkAdapter = Get-CimInstance Win32_NetworkAdapterConfiguration | where { $_.IPAddress -ne $null }
$disk = Get-CimInstance Win32_LogicalDisk | where { $_.DeviceID -eq 'C:' }

# Create an empty hashtable to store the information
$deviceInfo = @{}

# Add operating system information
$deviceInfo.Add('OS Name', $osInfo.Caption)
$deviceInfo.Add('OS Version', $osInfo.Version)
$deviceInfo.Add('OS Architecture', $osInfo.OSArchitecture)

# Add computer system information
$deviceInfo.Add('Computer Name', $computerSystem.Name)
$deviceInfo.Add('Manufacturer', $computerSystem.Manufacturer)
$deviceInfo.Add('Model', $computerSystem.Model)
$deviceInfo.Add('Serial Number', $computerSystem.SerialNumber)
$deviceInfo.Add('System Type', $computerSystem.SystemType)

# Add processor information
$deviceInfo.Add('Processor Name', $processor.Name)
$deviceInfo.Add('Number of Cores', $processor.NumberOfCores)
$deviceInfo.Add('Clock Speed', "$($processor.MaxClockSpeed / 1000) GHz")

# Add network adapter information
$deviceInfo.Add('MAC Address', $networkAdapter.MACAddress)

# Add disk information
$deviceInfo.Add('Drive Letter', $disk.DeviceID)
$deviceInfo.Add('Total Capacity', "{0:N2} GB" -f ($disk.Size / 1GB))
$deviceInfo.Add('Free Space', "{0:N2} GB" -f ($disk.FreeSpace / 1GB))

# Export the device information to a CSV file
$deviceInfo.GetEnumerator() | Export-Csv -Path "C:\Users\CherifaBochra\Desktop\DeviceInfo.csv" -NoTypeInformation
