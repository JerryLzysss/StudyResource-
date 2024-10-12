[TOC]

# Tailwindcss 响应式设计

目前常用分辨率包括有:
前缀|宽度|css
---|---|---
sm|640px|@media(min-width:640px)
md|768px|@media(min-width:768px)
lg|1024px|@media(min-width:1024px)
xl|1280px|@media(min-width:1280px)
2xl|1536px|@media(min-width:1536px)

需要采用这种指定分辨率的情况 name 需要在功能类前加上断点名称
例如:`<img class="w-16" md:w-32 lg:w-48" src="..">`

自定义断点可以通过在 tailwind.config.js 设置:

```
---tailwind.config.js---
module.exports={
  theme:{
    screens:{
      'tablet':'640px', // @media(min-width:640px)
      'laptop':'1024px', // @media(min-width:1024px)
      'desktop':'1280px',//@media(min-width:1280px)
    }
  }
}
```
