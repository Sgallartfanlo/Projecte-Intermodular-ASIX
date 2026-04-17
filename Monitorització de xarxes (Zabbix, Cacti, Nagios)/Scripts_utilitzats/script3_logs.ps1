$filePath = 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.log' #Canvia la ruta completa i el nom del registre a monitoritzar
$pattern = 'DC' #Canvia per la cadena que necessitis fer coincidir al registre
$oneMinute = 60  # Correspon a 60 segons 

# Obtenir la marca de temps actual
$currentTime = Get-Date

# Obtenir la marca de temps de l'última coincidència si existeix
$lastMatchTime = $null

if (Test-Path $filePath) {
    $lastMatch = Get-Content $filePath 2>$null | Select-String $pattern | Select-Object -Last 1

    if ($lastMatch) {
        $timestampRegex = '\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}.\d+'
        $lastMatchTime = [DateTime]::ParseExact([regex]::Match($lastMatch, $timestampRegex).Value, 'yyyy/MM/dd HH:mm:ss.ffffff', [System.Globalization.CultureInfo]::InvariantCulture)
    }
}

# Comprovar si ha passat més d'un minut des de l'última coincidència
if ($lastMatchTime -and ($currentTime - $lastMatchTime).TotalSeconds -le $oneMinute) {
    Write-Output "1"
} else {
    Write-Output "0"
}
