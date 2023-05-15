# 自动更换下载源 (开发中)

$ConfigFilePath = Join-Path $PSScriptRoot "script" "config.yml"
$localContent = Get-Content $ConfigFilePath -Raw | ConvertFrom-Yaml

# Clone template repository to temporary directory and read version
git clone ['https://github.com/WRXinYue/efficient-obsidian-blog.git'] $tempDir
$templateContent = Get-Content -Path "$tempDir\config.yml"

# Compare versions
if ($templateContent -gt $localContent) {
    $readhostParams = @{
        'Prompt' = "A new version ($templateContent) is available. Do you want to update? (Y/N)"
    }
    $userInput = Read-Host @readhostParams
    if ($userInput -eq "Y") {
        # Continue with update...
    } else {
        Write-Host "Update cancelled by user."
        # Clean up and exit...
    }
} else {
    Write-Host "You are already using the latest version ($localContent)."
    # Clean up and exit...
}