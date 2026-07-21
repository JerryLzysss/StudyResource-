// 模拟异步：返回 Promise
function fetchData() {
  return Promise.resolve('peanut butter');
}

function fetchDataFail() {
  return Promise.reject(new Error('error'));
}

// 模拟回调风格 API
function fetchDataCallback(callback) {
  setTimeout(() => {
    callback(null, 'peanut butter');
  }, 0);
}

module.exports = { fetchData, fetchDataFail, fetchDataCallback };
