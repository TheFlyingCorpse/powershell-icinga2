function Initialize-Icinga2 {
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$false)]
        [String] $Icinga2Exe = $null,
      [Parameter(Mandatory=$false)]
        [String] $Icinga2DataDir = $null,
      [Parameter(Mandatory=$false)]
        [String] $Icinga2InstallDir = $null
    )
    $_Icinga2InstallDir = $null
    $_Icinga2DataDir = $null
    $_Icinga2Exe = $null
    $ErrorMessage = ""

    # User Supplied path to the installation directory of Icinga2
    if ($Icinga2InstallDir -ne "") {
      if (Test-Path "$Icinga2InstallDir\share\skel\etc\icinga2") {
        $_Icinga2InstallDir = $Icinga2InstallDir
      } else {
        $ErrorMessage = "${ErrorMessage}The specified parameter Icinga2InstallDir '${Icinga2InstallDir}' is not pointing at a valid Icinga2 installation directory. "
      }
    }
    elseif ($Icinga2InstallDir -eq "" -or $Icinga2InstallDir -eq $null){
      $_Icinga2InstallDir = Get-Icinga2InstallDir
    }

    # User Supplied path to the installation directory of Icinga2's exe file
    if (!($Icinga2Exe -eq "" -or $Icinga2Exe -eq $null)) {
      if (Test-Path "$Icinga2Exe") {
        $_Icinga2Exe = $Icinga2Exe
      } else {
        $ErrorMessage = "${ErrorMessage}The specified parameter Icinga2Exe '${Icinga2Exe}' is not pointing at a valid Icinga2 exe file. "
      }
    }
    elseif (($Icinga2Exe -eq "" -or $Icinga2Exe -eq $null) -and $Icinga2InstallDir -ne ""){
      $_Icinga2Exe = Get-Icinga2ExePath -Icinga2InstallDir $Icinga2InstallDir
    }
    elseif ($_Icinga2InstallDir -ne "") {
      $_Icinga2Exe = Get-Icinga2ExePath
    }

    # User Supplied path to the data directory of Icinga2
    if ($Icinga2DataDir -ne "") {
      if (Test-Path "$Icinga2DataDir\etc\icinga2") {
        $_Icinga2DataDir = $Icinga2DataDir
      } else {
        $ErrorMessage = "${ErrorMessage}The specified parameter Icinga2Data '${Icinga2DataDir}' is not pointing at valid directory. "
      }
    }
    elseif ($Icinga2DataDir -eq ""){
      $_Icinga2DataDir = Get-Icinga2DataDir
    }

    # Did we get a path to the Icinga2DataDir?
    if ($null -eq $_Icinga2DataDir -or $_Icinga2DataDir -eq "") {
      Write-Verbose "No programdata for Icinga2 found, this implies we have a fresh installation of Icinga2."
      $_Icinga2DataDir = "$env:PROGRAMDATA\icinga2"
      $Icinga2FreshInstall = $true

      mkdir "$_Icinga2DataDir" -Force | out-null
    }
    else {
      Write-Verbose "Icinga2 has already been configured, will copy over any new features if they exist"

      $Icinga2FreshInstall = $false
    }
    
    if (!($_Icinga2InstallDir -eq "" -or $null -eq $_Icinga2InstallDir )) {
      write-verbose "Resolved Icinga2InstallDir to: $_Icinga2InstallDir"

    }

    if (!($_Icinga2DataDir -eq "" -or $null -eq $_Icinga2DataDir)) {
      write-verbose "Resolved Icinga2DataDir to: $_Icinga2DataDir"
    }

    if (!($_Icinga2Exe -eq "" -or $null -eq $_Icinga2Exe)) {
      write-verbose "Resolved Icinga2Exe path to: $_Icinga2Exe"
    }


    if ($null -ne $Icinga2FreshInstall -and !($_Icinga2DataDir -eq "" -or $null -eq $_Icinga2DataDir) -and !($_Icinga2InstallDir -eq "" -or $null -eq $_Icinga2InstallDir)) {
      Copy-Icinga2Skeleton -Icinga2DataDir $_Icinga2DataDir -Icinga2InstallDir $_Icinga2InstallDir -FreshInstall $Icinga2FreshInstall
    } else {
      Write-Error $ErrorMessage
    }
}