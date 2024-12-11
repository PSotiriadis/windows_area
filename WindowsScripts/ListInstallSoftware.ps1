# Retrieve all installed software properties
$installedSoftware = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"


# Filter out entries where DisplayName or Publisher is empty or null
$filteredSoftware = $installedSoftware | Where-Object { 
    $_.DisplayName -and $_.Publisher 
}

# Specify the ethernet adapter to read the ip
$adapterName = "Ethernet 2"

# Retrieve the machine's IP address
#$ipAddress = (Test-Connection -ComputerName (hostname) -Count 1).IPv4Address.IPAddressToString
$ipAddress = (Get-NetIPAddress -InterfaceAlias $adapterName -AddressFamily IPv4).IPAddress


# Extract the last octet of the IP address
$lastOctet = $ipAddress.Split('.')[-1]
$pcNr = $lastOctet - 159
# Construct the export file name using the last octet
$exportFileNameBase = "installed_software_PC" + "$pcNr" + "_" + "IP$lastOctet"


# Full paths for the export files
$csvFilePath = "C:\Users\sotiriadis\Documents\$exportFileNameBase.csv"
$txtFilePath = "C:\Users\sotiriadis\Documents\$exportFileNameBase.txt"


# Export the data to a CSV file with a semicolon delimiter
$filteredSoftware | Select-Object DisplayName, DisplayVersion, Publisher | 
    Export-Csv -Path $csvFilePath -NoTypeInformation -Force -Delimiter ";"

# Export the data to a CSV file with a semicolon delimiter
$filteredSoftware | Select-Object DisplayName, DisplayVersion, Publisher | Out-File -FilePath $txtFilePath -Force
