# slot
1.让父组件向子组件指定位置插入html
2.默认1插槽，具名插槽，作用域插槽
3.
```
默认:
父组件:<category></category>
子组件<template ><div></div></template>
```

```
具名:
父组件:<category></category>
子组件<template slot="xxx"><div></div></template>
```
```
作用域:
1.数据在组件自身，但是根据需要生成的结构进行修改
父组件:<category>
<ul>
<li v-for="g in scopeData">{{g}}
</category>
<category><h4 v-for="g in scopeData"></category>
子组件:<slot :games="games"></slot>
<script>
    export default{
        name:'Category',
        props:['title'],
        data()
        {
            return games:['1','2','3','4']
        }
    }
```

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

