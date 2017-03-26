function Get-Icinga2ExePath {
    param(
      [Parameter(Mandatory=$false)]
        [String] $Icinga2InstallDir = $null
    )

    $Icinga2InstallDir = Get-Icinga2InstallDir -SuppressWarnings
    if ($Icinga2InstallDir -ne $null) {
       if (Test-Path "$Icinga2InstallDir\sbin\icinga2.exe") {
         return "$Icinga2InstallDir\sbin\icinga2.exe"
       }
    }
    return $null
}