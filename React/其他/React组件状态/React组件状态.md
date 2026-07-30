# React组件状态
组件可以拥有状态，它是组件数据的私有部分，可以用来管理动态数据.
状态仅适用于类组件,或者使用React的Hook
React把组件看成是状态机,通过与用户的交互实现不同状态，然后渲染UI,让用户界面和数据保持一致.
React里只需要更新组件的state，然后根据state重新渲染用户界面.

# 状态管理示例
```javascript

Counter.js

import React, { Component } from 'react';
class Counter extends Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
  }

  increment = () => {
    this.setState({ count: this.state.count + 1 });
  }

  render() {
    return (
      <div>
        <p>Count: {this.state.count}</p>
        <button onClick={this.increment}>Increment</button>
      </div>
    );
  }
}

export default Counter;

index.js
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import Counter from './Counter';

const root = ReactDOM.createRoot(document.getElementById("root"));
// 渲染 Counter 组件
root.render(<Counter />);
```