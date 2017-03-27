function Get-Icinga2ExePath {
    param(
      [Parameter(Mandatory=$false)]
        [String] $Icinga2InstallDir = $null
    )

    $Icinga2InstallDir = Get-Icinga2InstallDir -SuppressWarnings
    if ($null -ne $Icinga2InstallDir) {
       if (Test-Path "$Icinga2InstallDir\sbin\icinga2.exe") {
         return "$Icinga2InstallDir\sbin\icinga2.exe"
       }
    }
    return $null
}