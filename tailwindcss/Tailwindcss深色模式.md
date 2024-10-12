[TOC]

# Tailwindcss 深色模式

在 tailwind 中包含一个 dark 变体，当启用深色模式的时候，您可以为您网站设置不同样式

```
<div class="bg-white dark:bg-gray-800">
  <h1 class="text-gray-900 dark:text-white">Dark Mode</h1>
  <p class="text-gray-600 dark:text-gray-300">Test</p>
</div>
```

## 默认情况下 Tailwind 并没有开启深色模式变体，如果需要启用深色模式，可以如下设置.

```
---tailwind.config.js---
module.exports={
  darkMode:'media'
}
```

如果需要为其他类启用深色模式可以采取如下操作
默认情况，只对 backgroundColor,borderColor,gradientColorStops,placeholderColor,textColor 启用.

```
---tailwind.config.js---
module.exports={
  variants:{
    extend:{
      textOpacity:['dark']
    }
  }
}
```

手动切换深色模式，可以将 darkMode 设置为 class

```
---tailwind.config.js---
module.exports={
  darkMode:'class'
}
```

## 在 html 与 js 中应用深色模式

```
没有启用dark模式:该情况下显示为白色
<html>
<body>
  <div class="bg-white dark:bg-black"></div>
</body>
</html>
启用dark模式:该情况下显示为黑色
<html class="dark">
<body>
  <div class="bg-white dark:bg-black"></div>
</body>
</html>
```

```
if(localStorage.theme==='dark'||(!('theme') in localStorage))
{
  document.documentElement.classList.add('dark')
}
else{
  document.documentElement.classList.remove('dark')
}
localStorage.theme='light'
localStorage.theme='dark'
localStorage.removeItem('theme')
```
