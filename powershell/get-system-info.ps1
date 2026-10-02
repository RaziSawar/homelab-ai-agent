# Zeigt wichtige Systeminformationen des lokalen Windows-Rechners an

$computerInfo = Get-ComputerInfo
$ipAddress = Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object {
        $_.IPAddress -notlike "127.*" -and
        $_.IPAddress -notlike "169.254.*"
    } |
    Select-Object -First 1 -ExpandProperty IPAddress

[PSCustomObject]@{
    ComputerName   = $env:COMPUTERNAME
    WindowsVersion = $computerInfo.WindowsProductName
    WindowsBuild   = $computerInfo.WindowsBuildLabEx
    RAM_GB         = [math]::Round($computerInfo.CsTotalPhysicalMemory / 1GB, 2)
    IPv4Address    = $ipAddress
}
