# 请使用管理员权限运行PowerShell

# 下一步，Chocolatey替换下载源，pnpm替换下载源，读取配置文件进行设置

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

# 检查管理员权限
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (!$isAdmin) {
    Write-Host "试图重启脚本与管理员特权..." -ForegroundColor Yellow
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
} else {
    Write-Host "脚本是用管理员权限运行." -ForegroundColor Green
}

# 检查执行策略
$policy = Get-ExecutionPolicy
Write-Host "目前的执行政策: $policy"

if ($policy -eq "Restricted") {
    Write-Host "试图改变执行政策..."
    Set-ExecutionPolicy RemoteSigned -Scope Process
    $policy = Get-ExecutionPolicy
    Write-Host "执行新政策: $policy"
}

if ($policy -eq "Restricted") {
    Write-Host "请手动设置执行政策RemoteSigned或无限制并重新运行脚本."
    exit 1
}


Write-Host "`n------------------------- Installation tools -------------------------`n" -ForegroundColor Cyan

Write-Host "你确认安装工具吗? (Y/N)" -ForegroundColor Yellow
$confirm = Read-Host
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Aborted." -ForegroundColor Red
    exit
}

pnpm setup
. $profile
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

if (!(Get-Module -ListAvailable -Name powershell-yaml)) {
    Write-Host "powershell-yaml未找到,安装..."
    Install-Module -Name powershell-yaml
} else {
    Write-Host "powershell-yaml已经安装." -ForegroundColor Green
}

if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey 没有找到,安装..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey 已经安装." -ForegroundColor Green
}

try {
    nvm | Out-Null
    Write-Host "NVM is 已经安装." -ForegroundColor Green
} catch {
    Write-Host "NVM 没有找到,安装..."
    choco install nvm -y
    Write-Output "NVM 成功安装."
}

if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js 没有找到,安装..."
    nvm install stable
    nvm use stable
} else {
    Write-Host "Node.js is 已经安装." -ForegroundColor Green
}

if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git 没有找到,安装..."
    choco install git
} else {
    Write-Host "Git is 已经安装." -ForegroundColor Green
}

if (!(Get-Command pnpm -ErrorAction SilentlyContinue)) {
    Write-Host "pnpm 没有找到,安装..."
    npm install -g pnpm
} else {
    Write-Host "pnpm is 已经安装." -ForegroundColor Green
}

if (!(Get-Command hexo -ErrorAction SilentlyContinue)) {
    Write-Host "hexo-cli 没有找到,安装..."
    pnpm install -g hexo-cli
    pnpm install hexo-renderer-pug hexo-renderer-stylus --save
} else {
    Write-Host "hexo-cli is 已经安装." -ForegroundColor Green
}

$packages = 'hexo-renderer-pug', 'hexo-renderer-stylus', 'hexo-server', 'hexo-browsersync'
foreach ($package in $packages) {
    if (!(pnpm list $package -g)) {
        Write-Host "$package 没有找到,安装..."
        pnpm install $package --save
    } else {
        Write-Host "$package is 已经安装." -ForegroundColor Green
    }
}

Write-Host "`n------------------------- Version Information -------------------------`n" -ForegroundColor Cyan

Write-Host "Version information:"
Write-Host "Chocolatey:" -NoNewline; choco --version
Write-Host "nvm:" -NoNewline; choco --version
Write-Host "Node.js:" -NoNewline; node --version
Write-Host "Git:" -NoNewline; git --version
Write-Host "pnpm:" -NoNewline; pnpm --version
Write-Host "hexo-cli:" -NoNewline; hexo version

# pnpm config set registry https://registry.npmmirror.com

$ConfigFilePath = Join-Path $PSScriptRoot "script" "config.yml"
$ConfigContent = Get-Content $ConfigFilePath -Raw | ConvertFrom-Yaml
$version = $ConfigContent.version
$padding = "                                           "
Write-Host $separator
Write-Host $logo
Write-Host ($padding + $version)
Write-Host $separator


Write-Host "`n------------------------- 安装仓库 -------------------------`n" -ForegroundColor Cyan



Write-Host "`n------------------------- 编辑操作 -------------------------`n" -ForegroundColor Cyan

pnpm install

Write-Host "你确定你想要运行的命令吗? (Y/N)" -ForegroundColor Yellow
$confirm = Read-Host
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "Aborted." -ForegroundColor Red
    exit
} else {
    hexo clean
    hexo d
    hexo server
}

