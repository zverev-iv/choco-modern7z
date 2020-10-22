$ErrorActionPreference = 'Stop';

$installed = Get-Content -Path $env:ChocolateyPackageFolder\tools\installed.json -Raw | ConvertFrom-Json

$spliter = "path to executable:"
$7zLocation = "$(Split-Path -parent ((7z --shimgen-noop | Select-String $spliter) -split $spliter | ForEach-Object Trim)[1])"
$installLocation = "$(Join-Path $7zLocation "Codecs")"

Write-Host "Remove libraries" -ForegroundColor Blue
ForEach($file in $installed) {
  Remove-Item "$(Join-Path $installLocation $file)" -Force
}
Write-Host "Remove completed" -ForegroundColor Blue