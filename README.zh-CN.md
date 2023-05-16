<h1 align="center"><strong>⚡ Efficient Obsidian Blog ⚡</strong></h1>

该项目提供了一个通过Obsidian与Hexo结合的博客模板，以便您在Obsidian中撰写博客文章，并通过Hexo将文章发布到网站。这个模板预安装了许多实用的插件，并配有自动化脚本以便用户进行更新和管理。

***
<br>
<p align='center'>
<a href="">在线 Demo</a>
</p>

<br>
<p align='center'>
<a href="https://github.com/WRXinYue/efficient-obsidian-blog/blob/main/README.md">English</a> | <b>简体中文</b>
</p>

<br>
<h2 align="center"><strong>🎯 项目目标</strong></h2>

> 我们的目标是让博客写作和管理变得更加简单和高效。通过Obsidian和Hexo的结合，您可以在一个强大的知识管理工具中编写和管理您的博客文章，然后通过Hexo将您的文章轻松发布到网站。我们提供了一些预装的插件和自动化脚本，来帮助您更好地利用这两个工具的优势。

<br>
<h2 align="center"><strong>💡 初学者建议</strong></h2>

> 如果您是初学者，我们建议您首先熟悉Obsidian和Hexo的基本使用方式。然后，您可以尝试使用我们提供的模板来创建您的博客。在使用过程中，如果您遇到任何问题，您可以查阅Obsidian和Hexo的官方文档，或者在我们的项目页面上提出问题。我们欢迎所有的问题和建议。


<br>
<h2 align="center"><strong>🚀 插件一览</strong></h2>

1. **Image auto upload Plugin**（PicGo图床上传）：自动将Obsidian中的图片上传到PicGo图床，并在上传后自动替换图片链接。
2. **Obsidian Git**（快速Git上传）：在Obsidian中提供快速Git上传功能，方便用户将更改推送到Github等远程仓库。
3. **Templater**（文件元数据模板）：自动在新的文章中插入预设的元数据模板。
4. **Update time on edit**（自动更新时间）：在编辑文章时自动更新元数据中的时间戳。
5. **Husky**: 实现了自动化的Husky配置，用于在Git提交时运行一些检查和任务。

1. `hexo-renderer-pug`：Hexo 的 Pug 模板引擎渲染器。Pug 是一种高效、健壮、功能丰富的模板引擎，可以用于生成 HTML。
2. `hexo-renderer-stylus`Hexo 的 Stylus 渲染器。Stylus 是一种强大的 CSS 预处理器，它可以让你使用更简洁、更灵活的语法来编写 CSS。
3. `hexo-server`：Hexo 的官方服务器插件。这个插件可以让你在本地轻松地预览你的 Hexo 网站。
4. `hexo-browsersync`：Hexo 的 BrowserSync 插件。BrowserSync 是一个能够让你在多个设备上实时预览和测试你的网站的工具。

<br>
<h2 align="center"><strong>📚 如何使用</strong></h2>

**克隆仓库**：首先，将此模板克隆到您自己的仓库。您可以通过点击本页面右上角的 'Fork' 按钮来实现。

**下载模板**：克隆仓库后，将其下载到您电脑上的一个本地目录。您可以通过在您的仓库中点击 'Download' 按钮来实现。

**运行安装脚本**：导航到您下载仓库的目录并打开 PowerShell。运行 `./install.ps` 脚本以安装必要的组件。

```bash
./install.ps
```

请注意，如果您是第一次运行脚本，您可能需要更改执行策略。您可以通过在 PowerShell 中运行以下命令来实现：

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
设置执行策略后，尝试再次运行 `./install.ps` 脚本。

**打开 Obsidian**：安装完成后，导航到 `[您的仓库]\source\_posts` 目录并打开 Obsidian。现在，您已经准备好在 Obsidian 中开始创建博客文章了！

<br>
<h2 align="center"><strong>🔧 配置指南</strong></h2>

- **网站信息配置**：您需要在您的 `_config.yml` 文件中配置您的网站信息，例如网站的标题、描述、作者等信息。此外，您还需要在 `themes` 目录下的主题配置文件中配置您的主题信息。
- **PicGo图床配置**：如果您想使用PicGo图床，您需要在PicGo中配置您的图床信息，然后在Obsidian的设置中启用Image auto upload插件，并设置PicGo为上传服务。
- **Git配置**：为了能够使用Obsidian Git插件，您需要在Obsidian的设置中启用Git插件，并在插件设置中配置您的远程仓库信息。
- **Templater配置**：如果您想使用Templater插件，您需要在Obsidian的设置中启用Templater插件，并在插件设置中配置您的模板文件。
- **时间戳更新配置**：为了能够自动更新时间戳，您需要在Obsidian的设置中启用Update time on edit插件。

<br>
<h2 align="center"><strong>🔄 更新说明</strong></h2>

当我们发布新版本时，您可以通过运行我们提供的自动化脚本来更新您的模板。这个脚本会自动比较您的本地版本和远程版本，如果发现远程版本较新，会提示您是否进行更新。如果您选择更新，脚本会自动下载更新并应用到您的本地环境。

<br>
<h2 align="center"><strong>📮 反馈建议</strong></h2>

我们希望您能享受使用我们的模板。如果您在使用过程中遇到任何问题，或者有任何建议，欢迎向我们提供反馈。同时，如果您认为这个项目有任何可以改进的地方，也请随时向我们提出。
