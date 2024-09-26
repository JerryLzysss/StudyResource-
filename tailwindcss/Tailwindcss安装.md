<!--
 * @Description:
-->

[TOC]

# TailWinds 安装

参考地址:https://www.w3cschool.cn/tailwind_css/tailwind_css-ld2m3p8q.html

[next.js](https://www.w3cschool.cn/tailwind_css/tailwind_css-gdtu3p8x.html?RECACHE=1)
[Vue3(vite)](https://www.w3cschool.cn/tailwind_css/tailwind_css-izj53p90.html?RECACHE=1)
[Laravel](https://www.w3cschool.cn/tailwind_css/tailwind_css-pkmc3p92.html?RECACHE=1)
[Nuxt.js](https://www.w3cschool.cn/tailwind_css/tailwind_css-neqo3p9n.html?RECACHE=1)
[React](https://www.w3cschool.cn/tailwind_css/tailwind_css-vo983p9o.html?RECACHE=1)
[Gatsby](https://www.w3cschool.cn/tailwind_css/tailwind_css-udxm3p9p.html?RECACHE=1)

# 常用 npm 安装方式

1. 安装 postcss,tailwindcss,autoprefixer
   `npm install -D tailwindcss@latest postcss@latest autoprefixer@latest`
2. 作为 postcss 插件进行添加

```
---postcss.config.js---
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
```

# CDN 引入

在使用 CDN 之前，请注意，如果没有将 Tailwind 集成到您的构建过程中，那么许多使 Tailwind CSS 强大的功能将不可用。

- 您无法自定义 Tailwind 默认主题
- 您不能使用任何 指令， 如： ​@apply​， ​@variants​ 等等
- 您无法启用更多的变体，如： ​group-focus​
- 您无法下载第三方的插件
- 您无法 tree-shake 未使用到的 Styles
  总的来说就是删减版，如果只是使用基本的操作 name 就不会受到影响.

```
<link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="external nofollow" target="_blank"  rel="stylesheet">
```

# PostCSS 兼容性

`Error: PostCSS plugin tailwindcss requires PostCSS 8.`
出现上述提到的错误时说明出现兼容性错误.
解决方法如下所示:通过重新安装使用兼容性版本即可.

```
npm uninstall tailwindcss postcss autoprefixer
npm install -D tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9
```

# HTML 使用安装

1. 安装 tailwindcss(npm install -d tailwindcss)
2. 初始化 tailwindcss,生成 tailwind.config.js(npx tailwindcss init)
3. 添加 tailwind 指令到 css 文件

```
---style.css---
@tailwind base;
@tailwind components;
@tailwind utilities;
```

4.编译构建 style.css 到某个文件夹下
tailwindcss -i ./src/styles.css -o ./dist/styles.css

5.在 html 中引入相关文件

```
xxx.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8"/>
    <link href="./dist/styles.css" rel="stylesheet">
  </head>
  <body>
<h1 class="text-9xl font-bold underline mt-10 text-center"> Hello world! </h1>
  </body>
</html>

```

6.通过 cmd 进行监视 watch

```
tailwindcss -i ./src/styles.css -o ./dist/styles.css --watch
```
