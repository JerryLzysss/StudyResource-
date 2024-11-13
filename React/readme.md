# React
参考文档:https://react.docschina.org/ 
https://blog.csdn.net/weixin_56370772/article/details/142206148
React 是一个用于构建用户界面的 JavaScript 库。可以理解它只负责 MVC 中的视图层渲染，不直接提供数据模型和控制器功能。react-router 实现路由，redux 实现状态管理，可以使用它们来构建一个完整应用
用于构建 Web 和原生交互界面的库，类似于vue.
React 让你可以通过组件来构建用户界面。你可以创建像 Thumbnail、LikeButton 和 Video 这样的组件。然后将它们组合成整个应用程序。
React 组件接收数据并返回应该出现在屏幕上的内容。你可以通过响应交互（例如用户输入）向它们传递新数据。然后，React 将更新屏幕以匹配新数据。
React 是一个库。它允许你将组件放在一起，但不关注路由和数据获取。要使用 React 构建整个应用程序，我们建议使用像 Next.js 或 Remix 这样的全栈 React 框架。
React 也是一种架构。实现它的框架可以在服务端甚至是构建阶段使用异步组件来获取数据，也可以从文件或数据库读取数据，并将其传递给交互式组件。