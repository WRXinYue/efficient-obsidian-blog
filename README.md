<h1 align="center"><strong>⚡ Efficient Obsidian Blog ⚡</strong></h1>

This project provides a blog template that integrates Obsidian with  Hexo, enabling you to write blog articles in Obsidian and publish them  on the web through Hexo. This template comes pre-installed with many  useful plugins and automated scripts for user-friendly updates and  management.

***
<br>
<p align='center'>
<a href="https://efficient-obsidian-blog.vercel.app/">Live Demo</a>
</p>

<br>
<p align='center'>
<b>English</b> | <a href="https://github.com/WRXinYue/efficient-obsidian-blog/blob/master/README.zh-CN.md">简体中文</a>
</p>

<br>
<h2 align="center"><strong>🎯 Project Goals</strong></h2>

> "Our goal is to simplify and streamline the process of blog writing and  management. By integrating Obsidian and Hexo, you can write and manage  your blog posts in a powerful knowledge management tool, then  effortlessly publish your articles on the web through Hexo. We provide  pre-installed plugins and automation scripts to help you fully leverage  the advantages of these two tools."

<br>
<h2 align="center"><strong>💡 Recommendations for Beginners</strong></h2>

> "If you're a beginner, we recommend that you first familiarize yourself  with the basic usage of Obsidian and Hexo. Then, you can try creating  your blog using our provided template. If you encounter any issues  during this process, you can refer to the official documentation of  Obsidian and Hexo or ask questions on our project page. We welcome all  questions and suggestions."

<br>
<h2 align="center"><strong>🚀 Plugin Overview</strong></h2>

1. **Image auto upload Plugin** (PicGo image hosting upload): This plugin automatically uploads images from Obsidian to PicGo, and automatically replaces the image links after upload.
2. **Obsidian Git** (Fast Git upload): Provides a quick Git upload feature in Obsidian, allowing users to easily push changes to remote repositories like Github.
3. **Templater** (File metadata template): Automatically inserts a preset metadata template into new articles.
4. **Update time on edit** (Automatic timestamp update): Automatically updates the timestamp in metadata when editing an article.
5. **Husky**: Implements automated Husky configuration, which runs checks and tasks during Git commits.
6. `hexo-renderer-pug`: Hexo's Pug template engine renderer. Pug is an efficient, robust, feature-rich template engine used for generating HTML.
7. `hexo-renderer-stylus`: Hexo's Stylus renderer. Stylus is a powerful CSS preprocessor that allows you to write CSS with a more concise and flexible syntax.
8. `hexo-server`: Hexo's official server plugin. This plugin lets you easily preview your Hexo website locally.
9. `hexo-browsersync`: Hexo's BrowserSync plugin. BrowserSync is a tool that allows you to preview and test your website in real time across multiple devices.

<br>
<h2 align="center"><strong>📚 How to Use</strong></h2>

**Clone the Repository**: First, clone this template to your own repository. You can do this by clicking the 'Fork' button on the top right of this page.

**Download the Template**: Once you've cloned the repository, download it to a local directory on your computer. You can do this by clicking the 'Download' button in your repository.

**Run the Installation Script**: Navigate to the directory where you've downloaded the repository and open PowerShell. Run the `./install.ps` script to install the necessary components.

```bash
./install.ps
```

Please note, if you're running the script for the first time, you may need to change the execution policy. You can do this by running the following command in PowerShell:

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
After setting the execution policy, try running the `./install.ps` script again.

**Open Obsidian**: After the installation is complete, navigate to the `[your-repository]\source\_posts` directory and open Obsidian. Now, you are ready to start creating blog articles in Obsidian!

If you encounter any issues with configuring or using Obsidian plugins, you can refer to the detailed [Obsidian Plugin Usage Documentation](https://github.com/WRXinYue/efficient-obsidian-blog/blob/master/doc/OBSIDIAN.md) for assistance.

<br><h2 align="center"><strong>🔧 Configuration Guide</strong></h2>

- **Website Information Configuration**: You need to configure your website information in your `_config.yml` file, such as the website's title, description, author, etc. Additionally, you need to configure your theme information in the theme configuration file located in the `themes` directory.
- **PicGo Image Hosting Configuration**: If you want to use PicGo for image hosting, you need to configure your image hosting information in PicGo, then enable the Image auto upload plugin in Obsidian's settings and set PicGo as the upload service.
- **Git Configuration**: In order to use the Obsidian Git plugin, you need to enable the Git plugin in Obsidian's settings and configure your remote repository information in the plugin settings.
- **Templater Configuration**: If you want to use the Templater plugin, you need to enable the Templater plugin in Obsidian's settings and configure your template file in the plugin settings
- **Timestamp Update Configuration**: To automatically update timestamps, you need to enable the Update time on edit plugin in Obsidian's settings.

<br><h2 align="center"><strong>🔄 Update Instructions</strong></h2>

When we release new versions, you can update your template by running  our provided automation scripts. These scripts will automatically  compare your local version with the remote version. If the remote  version is newer, it will prompt you whether to update. If you choose to update, the script will automatically download the update and apply it  to your local environment.

<br><h2 align="center"><strong>📮  Feedback and Suggestions</strong></h2>

We hope you enjoy using our template. If you encounter any problems  during use, or have any suggestions, we welcome your feedback. Also, if  you believe there are any areas for improvement in this project, please  feel free to let us know.
