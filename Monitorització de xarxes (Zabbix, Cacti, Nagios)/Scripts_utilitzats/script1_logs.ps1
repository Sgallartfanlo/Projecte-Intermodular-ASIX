(Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    ID = 4625 #editar el id según su necesidad.
} | Sort-Object TimeCreated -Descending | Select-Object -First 1).Message

