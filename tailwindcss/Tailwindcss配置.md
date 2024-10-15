# Tailwind 配置

下列提到的均为默认设置，可以通过修改值实现替换.
没有提到修改的值均保持为默认值.

```
-------tailwind.config.js--------
module.exports={
  theme:{
    screens:{
      sm:'480px',
      md:'768px',
      lg:'976px',
      xl:'1440px',
    },
    colors:{
      gray:colors;coolGray,
      blue:colors.lightBlue
    },
    //此处为拓展不影响原来的值
    extend:{
      spacing:{
        '128':'32rem'
      }
    }
  },
  corePlugins:{
    opacity:false // 禁用该插件，而不是设置为空对象{}
  }
}








```
