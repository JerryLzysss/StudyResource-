# webpack 懒加载与预加载
作用:同样的减少加载次数与时间，提高打包速度。
# 懒加载
当文件需要时才加载
```
<button id="btn">点击加载代码</button>
document.querySelector("#btn").addEventListener("click", function () {
  import(/* webpackChunkName: 'print' */ "./print.js")
    .then(() => {
      // 加载成功
    })
    .catch(() => {
      // 加载失败
    });
});
```
# 预加载
prefetch 会在使用前，提前加载js文件
正常加载可以认为是并行加载（同一时间加载多个文件） 预加载 prefetch：等其他资源加载完毕，浏览器空闲了，再偷偷加载资源
```
document.querySelector("#btn").addEventListener("click", function () {
  import(/* webpackChunkName: 'print', webpackPrefetch: true */ "./print.js")
    .then(() => {
      // 加载成功
    })
    .catch(() => {
      // 加载失败
    });
});
prefetch(预获取)：将来某些导航下可能需要的资源
preload(预加载)：当前导航下可能需要资源
import(/* webpackChunkName: 'print', webpackPrefetch: true */ "./print.js")
import(/* webpackChunkName: 'print', webpackPreload: true */ "./print.js")
```