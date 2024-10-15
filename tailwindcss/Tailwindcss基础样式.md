# Tailwind 基础样式

对于基础样式来说默认情况下就是
@tailwind base;
@tailwind components;
@tailwind utilities;
在上述提到的 config 配置之后呢，就能够实现 tailwindcss 的基本样式.
其样式的基本特点包括有:

- 去掉默认外边距 margin:0
- 标题无样式
- 列表无样式
- 图片是块级元素
- ul 不宣布为列表，除非设置<ul role="list">
- 边框样式已被全局重置
- 按钮默认有轮廓
