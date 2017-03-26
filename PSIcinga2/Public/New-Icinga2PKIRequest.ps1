function New-Icinga2PKIRequest {
  param(
    [String] $CAHost,
    [int]    $CAPort = 5665,
  [Parameter(Mandatory=$true)]
    [String] $Hostname,
  [Parameter(Mandatory=$true)]
    [String] $TicketID,
  [Parameter(Mandatory=$false,HelpMessage='Path of the Icinga2 ProgramData Directory')]
    [String] $DataDir,
  [Parameter(Mandatory=$false,HelpMessage='Path to the icinga2.exe')]
    [String] $Icinga2Exe
  )

  if ($DataDir -eq "") {
    $DataDir = Get-Icinga2DataDir
  }

  if ($Icinga2Exe -eq "") {
    $Icinga2Exe = Get-Icinga2ExePath
  }

  $cert = "$DataDir/etc/icinga2/pki/${Hostname}.crt"
  $key = "$DataDir/etc/icinga2/pki/${Hostname}.key"
  $trustedcert = "$DataDir/etc/icinga2/pki/trusted-cert.crt"
  $ca = "$DataDir/etc/icinga2/pki/ca.crt"

  if ((Test-Path $trustedcert) -and (Test-Path $cert) -and (Test-Path $key)){
    & "${Icinga2Exe}" pki request --host "${CAHost}" --port $CAPort --cert "${cert}" --key "${key}" --trustedcert "${trustedcert}" --ca "${ca}" --ticket $TicketID
  } else {
    $NewCertWarning = $false
    if (!(Test-Path $trustedcert)) {
      Write-Warning "Did not find the expected trusted certificate file '${trustedcert}', not requesting the signed certificate from upstream."
      Write-Warning "Did you remember to run Set-Icinga2TrustedCertificate?"
    }

    if (!(Test-Path $key)) {
      Write-Warning "Did not find the expected cert file '${cert}', not requesting the signed certificate from upstream."
      $NewCertWarning = $true
    }
    if (!(Test-Path $trustedcert)) {
      Write-Warning "Did not find the expected key file '${key}', not requesting the signed certificate from upstream."
      $NewCertWarning = $true
    }
    if ($NewCertWarning){
      Write-Warning "Did you remember to run New-Icinga2PKICertificate?"
    }
  }
}