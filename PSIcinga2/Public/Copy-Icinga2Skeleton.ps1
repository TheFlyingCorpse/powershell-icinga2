function Copy-Icinga2Skeleton {
  param(
  [Parameter(Mandatory=$true)]
  [ValidateScript({If(Test-Path $_){$true}else{Throw "Invalid path given: $_"}})]
    [String] $Icinga2DataDir,
  [Parameter(Mandatory=$true)]
  [ValidateScript({If(Test-Path $_){$true}else{Throw "Invalid path given: $_"}})]
    [String] $Icinga2InstallDir,
  [Parameter(Mandatory=$false)]
    [bool] $FreshInstall = $false
  )

  if ($FreshInstall) {
    write-verbose "Copying over the conf skeleton for Icinga2."

    Copy-Item -Path "$Icinga2InstallDir\share\skel\*" -Destination $Icinga2DataDir -Recurse -Force

    mkdir "$Icinga2DataDir/etc/icinga2/pki" -Force | out-null
    mkdir "$Icinga2DataDir/var/cache/icinga2" -Force | out-null
    mkdir "$Icinga2DataDir/var/lib/icinga2/pki" -Force | out-null
    mkdir "$Icinga2DataDir/var/lib/icinga2/agent/inventory" -Force | out-null
    mkdir "$Icinga2DataDir/var/lib/icinga2/api/config" -Force | out-null
    mkdir "$Icinga2DataDir/var/lib/icinga2/api/log" -Force | out-null
    mkdir "$Icinga2DataDir/var/lib/icinga2/api/repository" -Force | out-null
    mkdir "$Icinga2DataDir/var/lib/icinga2/api/zones" -Force | out-null
    mkdir "$Icinga2DataDir/var/log/icinga2/compat/archive" -Force | out-null
    mkdir "$Icinga2DataDir/var/log/icinga2/crash" -Force | out-null
    mkdir "$Icinga2DataDir/var/run/icinga2/cmd" -Force | out-null
    mkdir "$Icinga2DataDir/var/spool/icinga2/perfdata" -Force | out-null
    mkdir "$Icinga2DataDir/var/spool/icinga2/tmp" -Force | out-null
  }
  else {
    write-verbose "This is not a fresh install, copying just any new features that are available."

    $Source = "$Icinga2InstallDir\share\skel\etc\icinga2\features-available\"
    $Destination = "$Icinga2DataDir\etc\icinga2\features-available"

    $files = Get-ChildItem -Path "$Source\*"
    
    foreach ($file in $files) {
      $sourceFile = $Source + "/" + ${file}.Name
      $destinationFile = $Destination + "/" +  ${file}.Name

      if (!(Test-Path "$destinationFile")){
        Write-Verbose "Copied in new file $($file.Name)"
        Copy-Item -Path $sourceFile -Destination $destinationFile
        Write-Information "INFO: SourceFile: $sourceFile"
        Write-Information "INFO: DestinationFile: $destinationFile"
      } else {
        Write-Information "INFO: Not overwriting $($file.Name)"
      }
    }
  }
}