$ErrorActionPreference = 'Stop';

$installed = Get-Content -Path $env:ChocolateyPackageFolder\tools\installed.csv -Raw | ConvertFrom-Csv -Delimiter ';'

$spliter = "path to executable:"
$7zLocation = "$(Split-Path -parent ((7z --shimgen-noop | Select-String $spliter) -split $spliter | ForEach-Object Trim)[1])"
$installLocation = "$(Join-Path $7zLocation "Codecs")"

Write-Output "Remove libraries"

ForEach($file in $installed) {
  Remove-Item "$(Join-Path $installLocation $file.RelativePath)" -Force
}

Write-Output "Remove completed"