### PicGo Image Hosting

Plugin: Image auto upload Plugin

PicGo is a convenient image hosting tool that, in conjunction with the Image auto upload Plugin, enables automatic uploading of images in Obsidian to PicGo, and automatically replaces the image links after upload. Before getting started, PicGo should be installed and configured according to the instructions on PicGo's [GitHub page](https://github.com/Molunerfinn/PicGo).

### Quick Git Upload

Plugin: Obsidian Git

The Obsidian Git plugin provides the ability to perform Git uploads directly from Obsidian, facilitating file version saving and management. Depending on the need, automatic Git pushes can be set, but for better version control, manual pushes are recommended. To access Git commands, simply press Ctrl + P to open Obsidian's command panel and type "git" to view all available Git commands. Code commits typically require only the execution of Obsidian Git:Commit all changes and Obsidian Git:Push.

### File Metadata Template

Plugin: Templater

The Templater plugin enables automatic configuration of templates when writing blog articles, improving writing efficiency.

The following path stores the core plugin templates:

```bash
Templates/
├── Template MOC.md # Manual
├── Template/ # Core plugin templates
└── Templater Plugin/ # Community plugin templates
```

The `Template MOC.md` file describes the template files and how to use them. This file, along with other template files, should be moved to the `Templater Plugin` directory. The path to the template folder should then be entered in the Template Folder Location item on the Templater Plugin settings page.

The configuration example for the Templater Plugin is as follows:

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

When writing, the Alt+ E shortcut key can be used to invoke the template. More detailed configuration information can be found in the Templater's [official documentation](https://silentvoid13.github.io/Templater/introduction.html).

### Automatic Time Update

Plugin: Update time on edit

The Update time on edit plugin automatically updates the timestamp in the metadata when editing an article, ensuring the accuracy of article update information.