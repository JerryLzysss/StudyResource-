[TOC]
# React 基本使用

## 1. 引入包
```javascript
import React from 'react'
import ReactDOM from 'react-dom'
```

## 2.创建React元素
参数1:标签名称
参数2:属性集合 特殊:class==>className,for => htmlFor
参数3:标签内容
const element = React.createElement('h1',{id:'el'},'HelloReact')


## 3.渲染React元素
const root=ReactDOM.createRoot(document.getElementById('root'))
root.render(element)




