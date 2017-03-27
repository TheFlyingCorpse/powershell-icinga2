function Set-Icinga2TrustedCertificate {
  [CmdletBinding(
    SupportsShouldProcess=$true,
    ConfirmImpact="Medium")]
  param(
  [Parameter(Mandatory=$true)]
    [String] $CAHost,
  [Parameter(Mandatory=$false)]
    [int]    $CAPort = 5665,
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
    $trustedcert = "$DataDir/etc/icinga2/pki/trusted-cert.crt"

    if (Test-Path $cert) {
      & "${Icinga2Exe}" pki save-cert --host ${CAHost} --port $CAPort --cert ${cert} --key ${key} --trustedcert ${trustedcert}
    } else {
      Write-Warning "Did not find the file '${cert}', not saving the trusted certificate as intended. Did you remember to run New-Icinga2PKICertificate?"
    }
  }
}
