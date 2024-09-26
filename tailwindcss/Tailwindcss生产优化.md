<!--
 * @Description:
-->

[TOC]

# Tailwindcss 生产优化

# purgeCSS 优化

当生产的时候 Tailwindcss 中内置的[purgeCSS 库](https://purgecss.com/)会对未使用的 CSS 进行清除，从而提供对生产商的优化.
其正则表达式为:

```
/[^<>"'`\s"]*[^<>"'`\s:"]/g
```

当需要使用 purge 进行优化时，需要在 tailwind.config.js 中进行路径提供.

```
tailwind.config.js
module.exports={
  purge:[
    './src/**/*.html',
    './src/**/*.vue',
    './src/**/*.jsx',
  ],
  theme:{},
  variants:{},
  plugins:[],
  <!-- 手动开启 -->
  purge:{
    enabled:true,
    content:['./src/**/*.html']
    <!-- 安全类，放置被从CSS中删除 -->
    safelist:['bg-blue-500','text-center','hover:opacity-100']
    <!-- 转换,用于将非HTML文件转为HTML文件后进行提取-->
    transform:{
      md:(content)=>{
        return remark().process(content)
      }
    }
    <!-- 保留HTML -->
    preserveHtmlElements:false
    <!-- 清理特定层:默认情况下，tailwind将清除base,components和utilities层的所有样式 -->
    layers:['components','utilities']
    <!-- 删除未使用的keyframes -->
    options:{
      keyframes:true
      <!-- 其他选项可以查阅地址https://purgecss.com/configuration.html#options -->
    }
    <!-- 禁用核心插件与变体:用来减少打包体积 -->
    corePlugins:{
      float:false
    }
    <!-- 或者是仅选择需要使用的 -->
    corePlugins:['margin','padding']
    <!-- 或者是设置变体为空数组，通过这种方式相当于禁用了响应式 -->
    variants:{
      appearance:[]
    }
  }

}
```
