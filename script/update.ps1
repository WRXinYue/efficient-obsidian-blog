# 在脚本中创建一个临时的目录，用于存放从模板仓库拉取的更新
$tempDir = [System.IO.Path]::GetTempFileName()
Remove-Item $tempDir # Remove the temporary file, because we want a directory
New-Item -ItemType Directory -Path $tempDir

# 在临时目录中，使用git clone命令拉取模板仓库的最新代码
Set-Location $tempDir
git clone [你的模板仓库的URL]

# 将临时目录中的更新复制到用户的仓库，注意需要排除.git目录和用户可能已经修改过的文件
Set-Location [用户的仓库的路径]
Copy-Item "$tempDir\*" -Destination . -Recurse -Force -Exclude ".git", "其他需要排除的文件或目录"

# 删除临时目录
Remove-Item $tempDir -Recurse
