jest.useFakeTimers();

const { timerGame, infiniteTimerGame } = require('./timer');

test('等待 1 秒后调用回调', () => {
  const callback = jest.fn();
  timerGame(callback);

  expect(callback).not.toHaveBeenCalled();
  jest.runAllTimers();
  expect(callback).toHaveBeenCalledTimes(1);
});

test('advanceTimersByTime 前进 1 秒', () => {
  const callback = jest.fn();
  timerGame(callback);

  expect(callback).not.toHaveBeenCalled();
  jest.advanceTimersByTime(1000);
  expect(callback).toHaveBeenCalledTimes(1);
});

test('runOnlyPendingTimers 避免无限调度', () => {
  const callback = jest.fn();
  infiniteTimerGame(callback);

  expect(callback).not.toHaveBeenCalled();

  // 只跑当前挂起的 1s 定时器；期间新排入的 10s 定时器不会立刻执行
  jest.runOnlyPendingTimers();
  expect(callback).toHaveBeenCalledTimes(1);

  // 再跑挂起的 10s 定时器，会启动下一轮游戏（再排一个 1s）
  jest.runOnlyPendingTimers();

  // 再跑新一轮的 1s，回调第二次被调用
  jest.runOnlyPendingTimers();
  expect(callback).toHaveBeenCalledTimes(2);
});
