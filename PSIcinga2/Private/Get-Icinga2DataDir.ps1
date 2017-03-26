function Get-Icinga2DataDir {
    if (Test-Path "$env:PROGRAMDATA\icinga2") {
        return "$env:PROGRAMDATA\icinga2"
    }
    return $null
}