#----------------------------------------------------------------
#	Type:	Script
#	Desc:	Fill UDF20 with specific KB presence
#	Author:	Nathan Gemmill
#	Ver:	1.0
#----------------------------------------------------------------

#----------------------------------------------------------------
# Variables
#----------------------------------------------------------------
$KBString = "KB5007575","KB5012121"
[array]$KBArray = @($KBString -Split(","))

#----------------------------------------------------------------
# Loop through KB array to find KB's and write presence to UDF20
#----------------------------------------------------------------
foreach ($KB in $KBArray)
{
  Write-Host Checking for $KB presence
  Get-HotFix -Id $KB -ErrorAction Ignore
  if (Get-HotFix | Where-Object {$_.HotfixID -eq $KB}) 
  {
  Write-Host $KB present
  New-ItemProperty HKLM:\SOFTWARE\CentraStage -Name Custom20 -Value "$KB present"
  break
  }
  else
  {
  New-ItemProperty HKLM:\SOFTWARE\CentraStage -Name Custom20 -Value "Required update is not present"
  }
}