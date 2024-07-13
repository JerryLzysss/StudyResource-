# webpack 第一匹配规则
当规则匹配时，只使用第一个匹配规则。
```
module.exports = {
  //...
  module: {
    rules: [
      {
        test: /\.css$/,
        oneOf: [
          {
            resourceQuery: /inline/, // foo.css?inline
            use: 'url-loader',
          },
          {
            resourceQuery: /external/, // foo.css?external
            use: 'file-loader',
          },
        ],
      },
    ],
  },
};
```