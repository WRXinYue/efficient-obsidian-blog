# Create a temporary directory
$tempDir = [System.IO.Path]::GetTempFileName()
Remove-Item $tempDir # Remove the temporary file
New-Item -ItemType Directory -Path $tempDir

Set-Location $tempDir
git clone 'https://github.com/WRXinYue/efficient-obsidian-blog.git'

# Access to local and template repository configuration file content
$ConfigFilePath = Join-Path $PSScriptRoot "script" "config.yml"
$localContent = Get-Content $ConfigFilePath -Raw | ConvertFrom-Yaml
$templateConfigFilePath = Join-Path $tempDir "script" "config.yml"
$templateContent = Get-Content $templateConfigFilePath -Raw | ConvertFrom-Yaml

# Compare the version number
if ($templateContent.version -gt $localContent.version) {
    $readhostParams = @{
        'Prompt' = "有新版本 ($templateContent.version) 可用，是否进行更新？ (Y/N)"
    }
    $userInput = Read-Host @readhostParams
    if ($userInput -eq "Y") {
        # Ruled out. The git directory and the user may have modified files
        Set-Location [用户的仓库的路径]
        Copy-Item "$tempDir\*" -Destination . -Recurse -Force -Exclude ".git", "其他需要排除的文件或目录"
    } else {
        Write-Host "用户取消更新。"
    }
} else {
    Write-Host "你已经在使用最新版本 ($localContent.version)。"
}

# 删除临时目录
Remove-Item $tempDir -Recurse
