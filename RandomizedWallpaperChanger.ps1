"""Randomized Wallpaper Changer: 
This script changes the Windows desktop wallpaper to a randomly selected image from a specified directory. Here's the script:
"""

# requires PowerShell 5.0 or later

# set the directory containing the wallpaper images
$dir = "C:\Users\username\Pictures\Wallpapers"

# get a list of image files in the directory
$files = Get-ChildItem $dir | Where-Object { $_.Extension -match '\.(jpg|jpeg|png|bmp)$' }

# select a random image file
$file = $files | Get-Random

# set the desktop wallpaper to the selected image
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "Wallpaper" -Value $file.FullName
RUNDLL
