# Retrieve all installed software properties
$installedSoftware = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"

# Filter out entries where DisplayName or Publisher is empty or null
$filteredSoftware = $installedSoftware | Where-Object { 
    $_.DisplayName -and $_.Publisher 
}

# Export the data to a CSV file with a semicolon delimiter
$filteredSoftware | Select-Object DisplayName, DisplayVersion, Publisher | 
    Export-Csv -Path "C:\Users\sotiriadis\Documents\install_software.csv" -NoTypeInformation -Force -Delimiter ";"
