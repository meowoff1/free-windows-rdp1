# Software Installation Script for GitHub Actions RDP
# يثبت البرامج المفيدة على النظام

Write-Host "📦 ====== SOFTWARE INSTALLATION ====== 📦" -ForegroundColor Cyan
Write-Host ""

# Function to download and install software
function Install-Software {
    param(
        [string]$Name,
        [string]$Url,
        [string]$Arguments = "/S"
    )
    
    Write-Host "📥 Installing $Name..." -ForegroundColor Yellow
    try {
        $fileName = Split-Path $Url -Leaf
        $downloadPath = "$env:TEMP\$fileName"
        
        # Download
        Invoke-WebRequest -Uri $Url -OutFile $downloadPath -UseBasicParsing
        
        # Install
        Start-Process -FilePath $downloadPath -ArgumentList $Arguments -Wait -NoNewWindow
        
        Write-Host "✅ $Name installed successfully!" -ForegroundColor Green
        Remove-Item $downloadPath -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Host "❌ Failed to install $Name`: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host ""
}

# Install Chocolatey (Package Manager)
Write-Host "🍫 Installing Chocolatey..." -ForegroundColor Yellow
try {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "✅ Chocolatey installed successfully!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to install Chocolatey" -ForegroundColor Red
}
Write-Host ""

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Install software using Chocolatey
$chocoPackages = @(
    "googlechrome",
    "firefox", 
    "vscode",
    "git",
    "python",
    "nodejs",
    "7zip",
    "notepadplusplus",
    "vlc",
    "putty"
)

Write-Host "📦 Installing packages via Chocolatey..." -ForegroundColor Yellow
foreach ($package in $chocoPackages) {
    Write-Host "Installing $package..." -ForegroundColor Cyan
    try {
        choco install $package -y --no-progress --limit-output
        Write-Host "✅ $package installed!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to install $package" -ForegroundColor Red
    }
}
Write-Host ""

# Install additional software manually
Write-Host "🔧 Installing additional software..." -ForegroundColor Yellow

# TeamViewer (for remote access)
Install-Software -Name "TeamViewer" -Url "https://download.teamviewer.com/download/TeamViewer_Setup.exe" -Arguments "/S"

# AnyDesk (alternative remote access)
Install-Software -Name "AnyDesk" -Url "https://download.anydesk.com/AnyDesk.exe" -Arguments "--install --start-with-win --silent"

# WinRAR
Install-Software -Name "WinRAR" -Url "https://www.rarlab.com/rar/winrar-x64-611.exe" -Arguments "/S"

# Install Windows Subsystem for Linux (WSL)
Write-Host "🐧 Installing WSL..." -ForegroundColor Yellow
try {
    wsl --install --no-launch
    Write-Host "✅ WSL installation initiated!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to install WSL" -ForegroundColor Red
}
Write-Host ""

# Enable useful Windows features
Write-Host "🔧 Enabling Windows features..." -ForegroundColor Yellow

$features = @(
    "Microsoft-Hyper-V-All",
    "Containers",
    "Microsoft-Windows-Subsystem-Linux"
)

foreach ($feature in $features) {
    Write-Host "Enabling $feature..." -ForegroundColor Cyan
    try {
        Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart
        Write-Host "✅ $feature enabled!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to enable $feature" -ForegroundColor Red
    }
}
Write-Host ""

# Configure Git (if installed)
Write-Host "⚙️ Configuring Git..." -ForegroundColor Yellow
try {
    git config --global user.name "GitHub Actions User"
    git config --global user.email "actions@github.com"
    git config --global init.defaultBranch main
    Write-Host "✅ Git configured!" -ForegroundColor Green
} catch {
    Write-Host "❌ Git not available for configuration" -ForegroundColor Red
}
Write-Host ""

# Create useful shortcuts on Desktop
Write-Host "🔗 Creating desktop shortcuts..." -ForegroundColor Yellow
$desktop = [Environment]::GetFolderPath("Desktop")

# Create shortcuts for installed programs
$shortcuts = @(
    @{Name="Chrome"; Target="C:\Program Files\Google\Chrome\Application\chrome.exe"},
    @{Name="Firefox"; Target="C:\Program Files\Mozilla Firefox\firefox.exe"},
    @{Name="VS Code"; Target="C:\Users\runneradmin\AppData\Local\Programs\Microsoft VS Code\Code.exe"},
    @{Name="Command Prompt"; Target="C:\Windows\System32\cmd.exe"},
    @{Name="PowerShell"; Target="C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"}
)

foreach ($shortcut in $shortcuts) {
    if (Test-Path $shortcut.Target) {
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$desktop\$($shortcut.Name).lnk")
        $Shortcut.TargetPath = $shortcut.Target
        $Shortcut.Save()
        Write-Host "✅ Created shortcut for $($shortcut.Name)" -ForegroundColor Green
    }
}
Write-Host ""

# Set up development environment
Write-Host "💻 Setting up development environment..." -ForegroundColor Yellow

# Create development folders
$devFolders = @(
    "C:\Dev",
    "C:\Dev\Projects", 
    "C:\Dev\Tools",
    "C:\Dev\Scripts"
)

foreach ($folder in $devFolders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force
        Write-Host "✅ Created folder: $folder" -ForegroundColor Green
    }
}
Write-Host ""

# Download useful portable tools
Write-Host "🛠️ Downloading portable tools..." -ForegroundColor Yellow

$portableTools = @(
    @{Name="Process Explorer"; Url="https://download.sysinternals.com/files/ProcessExplorer.zip"; Path="C:\Dev\Tools\ProcessExplorer.zip"},
    @{Name="Process Monitor"; Url="https://download.sysinternals.com/files/ProcessMonitor.zip"; Path="C:\Dev\Tools\ProcessMonitor.zip"}
)

foreach ($tool in $portableTools) {
    try {
        Invoke-WebRequest -Uri $tool.Url -OutFile $tool.Path -UseBasicParsing
        Write-Host "✅ Downloaded $($tool.Name)" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to download $($tool.Name)" -ForegroundColor Red
    }
}
Write-Host ""

# Final system optimization
Write-Host "⚡ Optimizing system..." -ForegroundColor Yellow

# Disable Windows Defender real-time protection (for performance)
try {
    Set-MpPreference -DisableRealtimeMonitoring $true
    Write-Host "✅ Disabled Windows Defender real-time protection" -ForegroundColor Green
} catch {
    Write-Host "❌ Could not disable Windows Defender" -ForegroundColor Red
}

# Set high performance power plan
try {
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Write-Host "✅ Set high performance power plan" -ForegroundColor Green
} catch {
    Write-Host "❌ Could not set power plan" -ForegroundColor Red
}

Write-Host ""
Write-Host "📦 ====== INSTALLATION COMPLETE ====== 📦" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎉 Your Windows RDP environment is ready!" -ForegroundColor Green
Write-Host "📋 Installed software:" -ForegroundColor Yellow
Write-Host "   • Google Chrome" -ForegroundColor White
Write-Host "   • Mozilla Firefox" -ForegroundColor White  
Write-Host "   • Visual Studio Code" -ForegroundColor White
Write-Host "   • Git" -ForegroundColor White
Write-Host "   • Python" -ForegroundColor White
Write-Host "   • Node.js" -ForegroundColor White
Write-Host "   • 7-Zip" -ForegroundColor White
Write-Host "   • Notepad++" -ForegroundColor White
Write-Host "   • VLC Media Player" -ForegroundColor White
Write-Host "   • PuTTY" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Happy coding!" -ForegroundColor Cyan
