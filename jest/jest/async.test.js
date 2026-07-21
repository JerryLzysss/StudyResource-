const { fetchData, fetchDataFail, fetchDataCallback } = require('./async');

test('Promise', () => {
  return fetchData().then((data) => {
    expect(data).toBe('peanut butter');
  });
});

test('async/await', async () => {
  const data = await fetchData();
  expect(data).toBe('peanut butter');
});

test('callback', (done) => {
  function callback(error, data) {
    if (error) {
      done(error);
      return;
    }
    try {
      expect(data).toBe('peanut butter');
      done();
    } catch (err) {
      done(err);
    }
  }
  fetchDataCallback(callback);
});

test('resolves', async () => {
  await expect(fetchData()).resolves.toBe('peanut butter');
});

test('rejects', async () => {
  await expect(fetchDataFail()).rejects.toThrow('error');
});
