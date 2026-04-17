$now = Get-Date
$event = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4625
} | Sort-Object TimeCreated -Descending | Select-Object -First 1

if ($event) {
    $eventTime = $event.TimeCreated
    $timeDifference = New-TimeSpan -Start $eventTime -End $now
    if ($timeDifference.TotalMinutes -le 1) {
        "1"
    } else {
        "0"
    }
} else {
    "0"
}
