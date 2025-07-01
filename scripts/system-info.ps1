# System Information Script for GitHub Actions RDP
# يعرض معلومات مفصلة عن النظام

Write-Host "🖥️ ====== SYSTEM INFORMATION ====== 🖥️" -ForegroundColor Cyan
Write-Host ""

# Operating System Info
$osInfo = Get-ComputerInfo
Write-Host "💻 Operating System:" -ForegroundColor Yellow
Write-Host "   Name: $($osInfo.WindowsProductName)" -ForegroundColor White
Write-Host "   Version: $($osInfo.WindowsVersion)" -ForegroundColor White
Write-Host "   Build: $($osInfo.WindowsBuildLabEx)" -ForegroundColor White
Write-Host ""

# Hardware Info
Write-Host "⚡ Hardware Information:" -ForegroundColor Yellow
Write-Host "   CPU: $($osInfo.CsProcessors[0].Name)" -ForegroundColor White
Write-Host "   Cores: $($osInfo.CsNumberOfProcessors)" -ForegroundColor White
Write-Host "   RAM: $([math]::Round($osInfo.TotalPhysicalMemory / 1GB, 2)) GB" -ForegroundColor White
Write-Host ""

# Disk Space
Write-Host "💾 Storage Information:" -ForegroundColor Yellow
$drives = Get-PSDrive -PSProvider FileSystem
foreach ($drive in $drives) {
    if ($drive.Used -and $drive.Free) {
        $totalGB = [math]::Round(($drive.Used + $drive.Free) / 1GB, 2)
        $freeGB = [math]::Round($drive.Free / 1GB, 2)
        $usedGB = [math]::Round($drive.Used / 1GB, 2)
        $freePercent = [math]::Round(($drive.Free / ($drive.Used + $drive.Free)) * 100, 1)
        
        Write-Host "   Drive $($drive.Name): $usedGB GB used / $freeGB GB free ($freePercent% free) of $totalGB GB total" -ForegroundColor White
    }
}
Write-Host ""

# Network Info
Write-Host "🌐 Network Information:" -ForegroundColor Yellow
try {
    $publicIP = Invoke-RestMethod -Uri 'https://api.ipify.org' -TimeoutSec 10
    Write-Host "   Public IP: $publicIP" -ForegroundColor White
} catch {
    Write-Host "   Public IP: Unable to retrieve" -ForegroundColor Red
}

$networkAdapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
foreach ($adapter in $networkAdapters) {
    Write-Host "   Adapter: $($adapter.Name) - $($adapter.LinkSpeed)" -ForegroundColor White
}
Write-Host ""

# RDP Status
Write-Host "🔐 RDP Service Status:" -ForegroundColor Yellow
$rdpEnabled = Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections"
if ($rdpEnabled.fDenyTSConnections -eq 0) {
    Write-Host "   RDP: ✅ Enabled" -ForegroundColor Green
} else {
    Write-Host "   RDP: ❌ Disabled" -ForegroundColor Red
}

$rdpService = Get-Service -Name "TermService"
Write-Host "   RDP Service: $($rdpService.Status)" -ForegroundColor White
Write-Host ""

# Firewall Status
Write-Host "🛡️ Firewall Status:" -ForegroundColor Yellow
$rdpRules = Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Where-Object {$_.Enabled -eq $true}
Write-Host "   RDP Firewall Rules: $($rdpRules.Count) enabled" -ForegroundColor White
Write-Host ""

# User Information
Write-Host "👤 User Information:" -ForegroundColor Yellow
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "   Current User: $currentUser" -ForegroundColor White

$runnerAdmin = Get-LocalUser -Name "runneradmin" -ErrorAction SilentlyContinue
if ($runnerAdmin) {
    Write-Host "   runneradmin: ✅ Exists" -ForegroundColor Green
    Write-Host "   Last Login: $($runnerAdmin.LastLogon)" -ForegroundColor White
} else {
    Write-Host "   runneradmin: ❌ Not found" -ForegroundColor Red
}
Write-Host ""

# Running Processes (Top 10 by CPU)
Write-Host "🔄 Top Processes (by CPU):" -ForegroundColor Yellow
$processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
foreach ($proc in $processes) {
    if ($proc.CPU) {
        $cpuTime = [math]::Round($proc.CPU, 2)
        Write-Host "   $($proc.ProcessName): $cpuTime seconds" -ForegroundColor White
    }
}
Write-Host ""

# Available Memory
Write-Host "🧠 Memory Usage:" -ForegroundColor Yellow
$memory = Get-CimInstance -ClassName Win32_OperatingSystem
$totalMemory = [math]::Round($memory.TotalVisibleMemorySize / 1MB, 2)
$freeMemory = [math]::Round($memory.FreePhysicalMemory / 1MB, 2)
$usedMemory = $totalMemory - $freeMemory
$memoryPercent = [math]::Round(($usedMemory / $totalMemory) * 100, 1)

Write-Host "   Total: $totalMemory GB" -ForegroundColor White
Write-Host "   Used: $usedMemory GB ($memoryPercent%)" -ForegroundColor White
Write-Host "   Free: $freeMemory GB" -ForegroundColor White
Write-Host ""

# System Uptime
Write-Host "⏰ System Uptime:" -ForegroundColor Yellow
$uptime = (Get-Date) - $memory.LastBootUpTime
Write-Host "   Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes" -ForegroundColor White
Write-Host ""

# Installed Software (Sample)
Write-Host "📦 Key Installed Software:" -ForegroundColor Yellow
$software = @(
    "Google Chrome",
    "Mozilla Firefox", 
    "Microsoft Edge",
    "Visual Studio Code",
    "Git",
    "Python",
    "Node.js"
)

foreach ($app in $software) {
    $installed = Get-Package -Name "*$app*" -ErrorAction SilentlyContinue
    if ($installed) {
        Write-Host "   ✅ $app" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $app" -ForegroundColor Red
    }
}
Write-Host ""

Write-Host "🖥️ ====== END SYSTEM INFO ====== 🖥️" -ForegroundColor Cyan
