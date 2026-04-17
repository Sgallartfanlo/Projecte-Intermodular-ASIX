(Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4625 #editar el id segons la seva necessitat.
} | Sort-Object TimeCreated -Descending | Select-Object -First 1).Message
