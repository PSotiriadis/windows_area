# Retrieve all installed software properties
$installedSoftware = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"


# Filter out entries where DisplayName or Publisher is empty or null
$filteredSoftware = $installedSoftware | Where-Object { 
    $_.DisplayName -and $_.Publisher 
}

# Retrieve the machine's IP address
$ipAddress = (Test-Connection -ComputerName (hostname) -Count 1).IPv4Address.IPAddressToString

# Extract the last octet of the IP address
$lastOctet = $ipAddress.Split('.')[-1]

# Construct the export file name using the last octet
$exportFileNameBase = "installed_software_PC$lastOctet"

# Full paths for the export files
$csvFilePath = "C:\Users\sotiriadis\Documents\$exportFileNameBase.csv"
$txtFilePath = "C:\Users\sotiriadis\Documents\$exportFileNameBase.txt"


# Export the data to a CSV file with a semicolon delimiter
$filteredSoftware | Select-Object DisplayName, DisplayVersion, Publisher | 
    Export-Csv -Path $csvFilePath -NoTypeInformation -Force -Delimiter ";"

# Export the data to a CSV file with a semicolon delimiter
$filteredSoftware | Select-Object DisplayName, DisplayVersion, Publisher | Out-File -FilePath $txtFilePath -Force
