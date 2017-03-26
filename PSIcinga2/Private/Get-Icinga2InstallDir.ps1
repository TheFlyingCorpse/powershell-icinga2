function Get-Icinga2InstallDir {
    [CmdletBinding()]
    Param([switch] $SuppressWarnings)
    $Icinga2InstallDir = $null
    if ((Get-AppxPackage -Name Icinga2).InstallLocation -ne $null) {
      Write-Verbose "Appx installed."
      $InstallLocation = Get-AppxPackage -Name Icinga2 | Select-Object InstallLocation
      $Icinga2InstallDir = $InstallLocation.InstallLocation
    }
    else {
      Write-Debug "Appx not installed"
    }

    if ($Icinga2InstallDir -eq $null -and (Test-Path "$env:PROGRAMFILES\Icinga2\sbin\icinga2.exe")) {    
      $Icinga2InstallDir = "$env:PROGRAMFILES\Icinga2"
    }
    else {
      if ($SuppressWarnings -eq $false){
        Write-Warning "Unable to locate the Icinga2.exe via Appx or MSI installation, please specify the path to this in every Icinga2 commandlet you use"
      }
    }
    return $Icinga2InstallDir
}