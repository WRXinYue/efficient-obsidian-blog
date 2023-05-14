# 使用管理员权限运行PowerShell

$separator = @"
===================================================================
"@
$logo = @"
   ____    ______    ______    ___     _   __
  / __ \  / ____/   / ____/   /   |   / | / /
 / / / / / /       / __/     / /| |  /  |/ /
/ /_/ / / /___    / /___    / ___ | / /|  /
\____/  \____/   /_____/   /_/  |_|/_/ |_/
"@

$version = "1.0.0"
$padding = "                                           "
Write-Host $separator
Write-Host $logo
Write-Host ($padding + $version)
Write-Host $separator

# 检查管理员权限
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (!$isAdmin) {
    Write-Host "Attempting to relaunch script with administrator privileges..." -ForegroundColor Yellow
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
} else {
    Write-Host "Script is running with administrator privileges." -ForegroundColor Green
}

# 检查执行策略
$policy = Get-ExecutionPolicy
Write-Host "Current execution policy: $policy"

if ($policy -eq "Restricted") {
    Write-Host "Attempting to change execution policy..."
    Set-ExecutionPolicy RemoteSigned -Scope Process
    $policy = Get-ExecutionPolicy
    Write-Host "New execution policy: $policy"
}

if ($policy -eq "Restricted") {
    Write-Host "Please manually set the execution policy to RemoteSigned or Unrestricted and re-run the script."
    exit 1
}

Write-Host "`n------------------------- Installation tools -------------------------`n" -ForegroundColor Cyan

Write-Host "Your confirmation for installation tools? (Y/N)" -ForegroundColor Yellow
$confirm = Read-Host
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Aborted." -ForegroundColor Red
    exit
}

if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found, installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed." -ForegroundColor Green
}

if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js not found, installing..."
    choco install nodejs
} else {
    Write-Host "Node.js is already installed." -ForegroundColor Green
}

if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git not found, installing..."
    choco install git
} else {
    Write-Host "Git is already installed." -ForegroundColor Green
}

if (!(Get-Command pnpm -ErrorAction SilentlyContinue)) {
    Write-Host "pnpm not found, installing..."
    npm install -g pnpm
} else {
    Write-Host "pnpm is already installed." -ForegroundColor Green
}

if (!(Get-Command hexo -ErrorAction SilentlyContinue)) {
    Write-Host "hexo-cli not found, installing..."
    pnpm install -g hexo-cli
} else {
    Write-Host "hexo-cli is already installed." -ForegroundColor Green
}

Write-Host "`n------------------------- Version Information -------------------------`n" -ForegroundColor Cyan

Write-Host "Version information:"
Write-Host "Chocolatey:" -NoNewline; choco --version
Write-Host "Node.js:" -NoNewline; node --version
Write-Host "Git:" -NoNewline; git --version
Write-Host "pnpm:" -NoNewline; pnpm --version
Write-Host "hexo-cli:" -NoNewline; hexo version

Write-Host "`n------------------------- Compile operation -------------------------`n" -ForegroundColor Cyan

pnpm install

Write-Host "Are you sure you want to run the commands? (Y/N)" -ForegroundColor Yellow
$confirm = Read-Host
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Aborted." -ForegroundColor Red
    exit
} else {
    hexo clean
    hexo d
    hexo server
}

