### PicGo图床上传

插件：Image auto upload Plugin

PicGo是一款便捷的图床工具，配合Image auto upload Plugin插件，Obsidian中的图片可以实现自动上传至PicGo，并在上传后自动替换图片链接。在开始使用前，需按照PicGo的[GitHub页面](https://github.com/Molunerfinn/PicGo)上的说明进行安装并配置。

### 快速Git上传

插件：Obsidian Git

Obsidian Git插件提供了直接在Obsidian进行Git上传的功能，便于文件版本的保存和管理。可以根据需要设置自动Git推送，但为了更好地控制版本，推荐进行手动推送。访问Git命令只需按下Ctrl + P打开Obsidian的命令面板，然后输入"git"即可查看所有可用的Git命令。提交代码一般只需执行`Obsidian Git:Commit all changes`和`Obsidian Git:Push`

### 文件元数据模板

插件：Templater

Templater插件使得在写博客文章时可以自动配置模板，提升写作效率。

下列路径存放了核心插件的模板：

```bash
Templates/
├── Template MOC.md # 手册
├── Template/ # 核心插件的模板
└── Templater Plugin/ # 社区插件的模板
```

`Template MOC.md`文件中描述了模板文件及其使用方式。将这个文件和其他模板文件移动到`Templater Plugin`目录后，在Templater Plugin设置界面的Template Folder Location项目中输入相应路径。

Templater Plugin的配置示例如下：

```yaml
---
title: <% tp.file.title %>
categories:
 - <% tp.file.folder(relative=true) %>
tags:
 - ''
date: <% tp.date.now(format="YYYY-MM-DD HH:mm:ss") %>
updated: ''
---
```

写作时，可使用Alt+ E快捷键调用模板。更详细的配置信息可参考Templater的[官方文档](https://silentvoid13.github.io/Templater/introduction.html)。

### 自动更新时间

插件：Update time on edit

Update time on edit插件在编辑文章时自动更新元数据中的时间戳，确保文章更新信息的准确性。
