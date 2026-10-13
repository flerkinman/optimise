# Define where to temporarily save the file on the user's PC
$localPath = "$env:TEMP\my-program.exe"

Write-Host "Downloading application components..." -ForegroundColor Cyan

# Download the compiled .exe from GitHub Releases
Invoke-WebRequest -Uri "https://github.com" -OutFile $localPath

Write-Host "Launching program..." -ForegroundColor Green

# Execute the program
Start-Process -FilePath $localPath -Wait
