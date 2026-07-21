function forEach(items, callback) {
  for (let index = 0; index < items.length; index++) {
    callback(items[index]);
  }
}

test('mock 函数记录调用', () => {
  const mockCallback = jest.fn((x) => 42 + x);
  forEach([0, 1], mockCallback);

  expect(mockCallback.mock.calls.length).toBe(2);
  expect(mockCallback.mock.calls[0][0]).toBe(0);
  expect(mockCallback.mock.calls[1][0]).toBe(1);
  expect(mockCallback.mock.results[0].value).toBe(42);
});

test('mockReturnValue', () => {
  const myMock = jest.fn();
  myMock.mockReturnValueOnce(10).mockReturnValueOnce('x').mockReturnValue(true);

  expect(myMock()).toBe(10);
  expect(myMock()).toBe('x');
  expect(myMock()).toBe(true);
});

test('mock 断言匹配器', () => {
  const filter = jest.fn();
  filter.mockReturnValueOnce(true).mockReturnValueOnce(false);

  const result = [11, 12].filter((num) => filter(num));

  expect(result).toEqual([11]);
  expect(filter).toHaveBeenCalledTimes(2);
  expect(filter).toHaveBeenCalledWith(11);
  expect(filter).toHaveBeenLastCalledWith(12);
});

test('mockResolvedValue', async () => {
  const asyncMock = jest.fn().mockResolvedValue('peanut butter');
  await expect(asyncMock()).resolves.toBe('peanut butter');
});
