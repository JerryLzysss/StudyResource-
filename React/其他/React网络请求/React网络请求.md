# React网络请求
可以通过ajax和axios两种方式进行请求.
## ajax
以下是使用这两种方法的基本说明：

使用 fetch API 进行 AJAX 请求
fetch 是一个在浏览器中内置的 API，用于发起网络请求。以下是使用 fetch 在 React 组件中发起 AJAX 请求的基本步骤：
* 引入 fetch 
如果你使用的是现代浏览器，通常不需要引入 fetch。但是，如果你需要支持旧浏览器，可以使用 unfetch 这样的 polyfill。
* 使用 useEffect 钩子 
利用 useEffect 钩子来处理副作用，比如发起网络请求。
* 发起请求 
使用 fetch 发起 GET 或 POST 请求。
* 处理响应 
使用 .then() 来处理响应数据。
* 错误处理 
使用 .catch() 来捕获并处理错误。
* 更新状态 
使用 useState 钩子来存储请求的数据，并在请求成功后更新状态。
```javascipt
import React, { useState, useEffect } from 'react';

const MyComponent = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('https://api.example.com/data');
        const result = await response.json();
        setData(result);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      <h1>Data from API:</h1>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
};

export default MyComponent;
```

## axios
axios 是一个基于 Promise 的 HTTP 客户端，适用于浏览器和 Node.js。

以下是使用 axios 的基本步骤：

* 安装 axios 
通过 npm 或 yarn 安装 axios。
`npm install axios`
* 引入 axios 
在组件中引入 axios。
* 发起请求 
使用 axios 发起 GET 或 POST 请求。
* 处理响应和错误 
使用 .then() 和 .catch() 来处理响应和捕获错误。
* 更新状态 
与使用 fetch 类似，使用 useState 更新状态。
```javascript
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const MyComponent = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('https://api.example.com/data');
        setData(response.data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      <h1>Data from API:</h1>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
};

export default MyComponent;
```