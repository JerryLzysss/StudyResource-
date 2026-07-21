jest.mock('./models/user');

const user = require('./models/user');

test('使用手动模拟的 user 模块', () => {
  expect(user.getName()).toBe('模拟用户');
  expect(user.getAge()).toBe(99);
});
