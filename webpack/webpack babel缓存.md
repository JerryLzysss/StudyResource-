# webpack 缓存
在启用后将能够提供更快的打包速度.
```
module.exports = {
  //...
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            // 预设，提示babel怎么样做兼容性处理
            // 基本的兼容性处理，
            presets: [
              [
                "@babel/preset-env",
                {
                  // 按需加载
                  useBuiltIns: "usage",
                  // 指定core-js版本
                  corejs: {
                    version: 3,
                  },
                  // 指定兼容性到哪个版本浏览器
                  targets: {
                    chrome: "60",
                    firefox: "60",
                    ie: "9",
                    safari: "10",
                    edge: "17",
                  },
                },
              ],
            ],
            // 开启编译缓存
            cacheDirectory: true
          },
        },
      },
    ],
  },
};
```