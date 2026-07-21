# ES6 类模拟

参考文档: [ES6 类模拟](https://jest.nodejs.cn/docs/es6-class-mocks)

对应实现见 `jest/SoundPlayer.js`、`jest/sound-player-consumer.js`、`jest/es6-class-mock.test.js`。

## 要点

ES6 class 本质是构造函数，模拟必须是「可 `new` 的函数」或另一个 class。

## 自动模拟

```js
jest.mock('./SoundPlayer');
```

类被换成模拟构造函数，方法默认返回 `undefined`，可监视构造与方法调用：

```js
SoundPlayer.mock.instances[0].playSoundFile.mock.calls
```

## 模块工厂

```js
jest.mock('./SoundPlayer', () => {
  return jest.fn().mockImplementation(() => {
    return { playSoundFile: mockPlay };
  });
});
```

工厂须返回「构造函数」（高阶：函数返回函数）。

## 替换实现

对已模拟的类用 `mockImplementation` / `mockImplementationOnce` 按测试改行为。

## 手动模拟类

也可在 `__mocks__` 里放同名 class；能注入实现，但不自动提供调用监视，需再包一层 `jest.fn`。
