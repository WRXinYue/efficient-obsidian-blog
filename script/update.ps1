# Create a temporary directory
$tempDir = [System.IO.Path]::GetTempFileName()
Remove-Item $tempDir # Remove the temporary file
New-Item -ItemType Directory -Path $tempDir

# Save the current directory
$originalDir = Get-Location

Set-Location $tempDir

# Access to local repository configuration file content
$ConfigFilePath = Join-Path $PSScriptRoot "./config.yml"
$localContent = Get-Content $ConfigFilePath -Raw | ConvertFrom-Yaml

# GitHub API URL
$url = "https://api.github.com/repos/WRXinYue/efficient-obsidian-blog/contents/script/config.yml"
$response = Invoke-RestMethod -Uri $url -Method Get
$fileContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($response.content))

# Save the content to a temporary file
$templateConfigFilePath = Join-Path $tempDir "./config.yml"
Set-Content -Path $templateConfigFilePath -Value $fileContent

$templateContent = Get-Content $templateConfigFilePath -Raw | ConvertFrom-Yaml
$localVersion = $localContent.version
$templateVersion = $templateContent.version

# Compare the version number
if ($templateVersion -gt $localVersion) {
    $readhostParams = @{
        'Prompt' = "有新版本 ($templateVersion) 可用，(本地版本：$localVersion)是否进行更新？ (Y/N)"
    }
    $userInput = Read-Host @readhostParams
    if ($userInput -eq "Y") {
        # Ruled out. The git directory and the user may have modified files
        Set-Location [localVersion.url]
        Copy-Item "$tempDir\*" -Destination . -Recurse -Force -Exclude ".git", "其他需要排除的文件或目录"
    } else {
        Write-Host "用户取消更新。"
    }
} else {
    Write-Host "你已经在使用最新版本 ($templateVersion)。" -ForegroundColor Green
}

# Retry loop for git clone
$maxAttempts = 10
$attempt = 0
$success = $false

while (($attempt -lt $maxAttempts) -and (!$success)) {
  try {
    git clone 'https://api.github.com/repos/WRXinYue/efficient-obsidian-blog.git'
    $success = $true
  } catch {
    $attempt++
    Write-Host "下载失败，正在尝试第 $attempt 次..."
    Start-Sleep -Seconds 5
  }
}

if (!$success) {
  Write-Host "下载失败，已达到最大尝试次数。"
  exit 1
}

# 删除临时目录
Set-Location $originalDir
Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
