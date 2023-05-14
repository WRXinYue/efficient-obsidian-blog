# hexo

## 前言

我已经写了很长时间的博客，最初使用Halo搭建的博客，但现在转移到了Hexo。以下是我转移的原因：

1. 写文章不方便。每次在本地使用Typora完成一篇笔记后，都需要登录网站并将内容粘贴进去，非常麻烦。
2. 网站需要定期维护。虽然网站相对稳定，但我使用的腾讯服务器经常出现故障，这给我带来了很多麻烦。

## 插件配置

本次使用了以下插件：

- Image auto upload Plugin（PicGo图床上传）
- Obsidian Git（快速Git上传）
- Templater（文件元数据模板）
- Update time on edit（自动更新时间）

## 如何使用？

把仓库文件下载到你的电脑上，然后去掉.git文件夹，替换曾你的仓库即可

首次安装：

```bash
pnpm install
```



在线预览：

```bash
hexo s
```



更换下载源：

```bash
pnpm config set registry https://registry.npmmirror.com
```



## 配置

- Obsidian: 这是核心编辑器，我配置好了各种插件。
- Husky + Husky: 实现了自动化的Husky配置。

## 主题地址

我使用的主题是 [hexo-theme-arknights](https://github.com/Yue-plus/hexo-theme-arknights)。

## 依赖

你可以通过以下命令安装所需的依赖：

```bash
npm install hexo-server hexo-browsersync hexo-renderer-pug --save
```

或者使用 yarn：

```bash
yarn add hexo-server hexo-browsersync hexo-renderer-pug
```
