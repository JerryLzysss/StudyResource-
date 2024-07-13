# webpack 离线访问
名称: progressive web application 渐进式网络开发应用程序（离线可访问）
步骤:
1.添加 workbox-webpack-plugin 插件
npm install workbox-webpack-plugin --save-dev
2.配置 webpack.config.js
const WorkboxPlugin = require('workbox-webpack-plugin');
module.exports = {
    plugins: [
     new WorkboxPlugin.GenerateSW({
       // 这些选项帮助快速启用 ServiceWorkers
       // 不允许遗留任何“旧的” ServiceWorkers
       clientsClaim: true,
       skipWaiting: true,
     }),
    ]
};
3.注册 Service Worker
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
     navigator.serviceWorker.register('/service-worker.js').then(registration => {
       console.log('SW registered: ', registration);
     }).catch(registrationError => {
       console.log('SW registration failed: ', registrationError);
     });
    });
}
4.修改 package.json ESLint配置
让其支持浏览器变量（window、navigator等全局变量）
"eslintConfig": {
    "extends": "airbnb-base",
    "env": {
        "browser": true
    }
}
5.启动本地服务器
npm install http-server --save-dev
$ npx http-server dist
# 或者
npm i serve
$ npx serve dist