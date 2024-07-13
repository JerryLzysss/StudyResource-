# webpack 外部拓展
作用:通过对外部进行引入，避免打包的过程可以减少打包量
```
html导入:
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
webpack打包去除:
module.exports = {
  //...
  externals: {
    jquery: 'jQuery',
  },
  
};
js引入:
import $ from 'jquery';
$('.my-element').animate(/* ... */);
```