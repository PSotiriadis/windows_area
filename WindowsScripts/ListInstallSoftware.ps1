# Retrieve all installed software properties
$installedSoftware = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

# List all properties of the retrieved software
$installedSoftware | Select-Object *  # To view all available properties

# Optionally, display specific properties (e.g., DisplayName, Publisher, etc.)
$installedSoftware | Select-Object DisplayName, DisplayVersion, Publisher >> C:\Users\sotiriadis\Documents\install_software.txt