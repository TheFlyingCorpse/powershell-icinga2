function New-Icinga2PKICertificate {
  [CmdletBinding(
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
  param(
  [Parameter(Mandatory=$true)]
    [String] $Hostname,
  [Parameter(Mandatory=$false,HelpMessage='Path of the Icinga2 ProgramData Directory')]
    [String] $DataDir,
  [Parameter(Mandatory=$false,HelpMessage='Path to the icinga2.exe')]
    [String] $Icinga2Exe
  )

  PROCESS {
    if ($DataDir -eq "") {
      $DataDir = Get-Icinga2DataDir
    }

    if ($Icinga2Exe -eq "") {
      $Icinga2Exe = Get-Icinga2ExePath
    }

    $cert = "$DataDir/etc/icinga2/pki/${Hostname}.crt"
    $key = "$DataDir/etc/icinga2/pki/${Hostname}.key"

    & "${Icinga2Exe}" pki new-cert --cn "${Hostname}"--cert "${cert}" --key "${key}"
  }
}