$filePath = 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.log' #Cambiar la ruta y nombre completo del log a monitorear
$pattern = 'DC' #Cambiar por el string que necesiten hacer match en el log
$oneMinute = 60  # Corresponde a 60 segundos 

# Obtener la marca de tiempo actual
$currentTime = Get-Date

# Obtener la marca de tiempo de la última coincidencia si existe
$lastMatchTime = $null

if (Test-Path $filePath) {
    $lastMatch = Get-Content $filePath 2>$null | Select-String $pattern | Select-Object -Last 1

    if ($lastMatch) {
        $timestampRegex = '\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}.\d+'
        $lastMatchTime = [DateTime]::ParseExact([regex]::Match($lastMatch, $timestampRegex).Value, 'yyyy/MM/dd HH:mm:ss.ffffff', [System.Globalization.CultureInfo]::InvariantCulture)
    }
}

# Comprobar si ha pasado más de un minuto desde la última coincidencia
if ($lastMatchTime -and ($currentTime - $lastMatchTime).TotalSeconds -le $oneMinute) {
    Write-Output "1"
} else {
    Write-Output "0"
}
