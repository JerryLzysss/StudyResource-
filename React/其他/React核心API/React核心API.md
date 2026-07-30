[TOC]
# React 核心 API
## createElement
createElement(type, [props], [...children]) - 创建一个 React 元素或组件。
```javascript
import React from 'react';

const element = React.createElement('div', { className: 'container' }, 'Hello, World!');
```

## cloneElement
cloneElement(element, [props], [...children]) - 克隆并返回一个 React 元素，可以传递新的 props 和子元素。
```javascript
import React, { cloneElement } from 'react';
const parentElement = <div>Hello</div>;
const clonedElement = cloneElement(parentElement, { className: 'child' });
// clonedElement 是一个克隆的 React 元素，带有新的 className
```
## createFactory
createFactory(type) - 创建一个工厂函数，用于创建指定类型的 React 元素。
```javascript
import React from 'react';

const factory = React.createFactory('button');
const buttonElement = factory({ onClick: () => console.log('Button clicked') }, 'Click me');
// buttonElement 是一个工厂创建的 React 元素，一个可点击的按钮
```
## isValidElement
isValidElement(element) - 判断一个对象是否是有效的 React 元素。

```javascript
import React, { isValidElement } from 'react';

const element = <div>Hello</div>;
console.log(isValidElement(element)); // true
```
## Children.map
Children.map(children, function[(thisArg)]) - 遍历和映射 React 子元素。
```javascript
import React, { Children } from 'react';

const parentElement = (
  <ul>
    <li>Item 1</li>
    <li>Item 2</li>
    <li>Item 3</li>
  </ul>
);

const mappedChildren = Children.map(parentElement.props.children, child => (
  <li>{child}</li>
));
// mappedChildren 是映射后的子元素列表
```
# React 组件生命周期方法
## constructor
constructor(props) - 构造函数，在组件创建时调用，用于初始化 state 和绑定方法。

```javascript
import React, { Component } from 'react';

class MyComponent extends Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0
    };
  }

  render() {
    return <div>{this.state.count}</div>;
  }
}
```
## componentDidMount
componentDidMount() - 组件挂载后调用，通常用于数据获取、订阅等副作用操作。

```javascript
import React, { Component } from 'react';

class MyComponent extends Component {
  componentDidMount() {
    // 在组件挂载后订阅数据
    this.subscription = subscribeToData(data => {
      this.setState({ data });
    });
  }

  componentWillUnmount() {
    // 在组件卸载前取消订阅
    this.subscription.unsubscribe();
  }

  render() {
    return <div>{this.state.data}</div>;
  }
}
```
## componentDidUpdate
componentDidUpdate(prevProps, prevState) - 组件更新后调用，通常用于响应 props 或 state 的变化。

```javascript
import React, { Component } from 'react';

class MyComponent extends Component {
  componentDidUpdate(prevProps, prevState) {
    // 当 props 或 state 变化时更新数据
    if (this.props.userID !== prevProps.userId) {
      this.fetchData(this.props.userID);
    }
  }

  render() {
    return <div>{this.props.userID}</div>;
  }
}
```
## componentWillUnmount
componentWillUnmount() - 组件将被卸载前调用，用于清理定时器、取消订阅等资源释放。
```javascript
import React, { Component } from 'react';

class MyComponent extends Component {
  componentWillUnmount() {
    // 在组件卸载前清理资源
    clearInterval(this.timerID);
  }

  render() {
    return <div>{this.state.time}</div>;
  }
}
```
## static getDerivedStateFromProps
static getDerivedStateFromProps(props, state) - 用于替代 componentWillReceiveProps，在 props 变化时更新 state。

```javascript
import React, { Component } from 'react';

class MyComponent extends Component {
  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.userID !== prevState.userID) {
      return { userID: nextProps.userID };
    }
    return null;
  }

  render() {
    return <div>{this.state.userID}</div>;
  }
}
```
# React Hooks
## useState
useState(initialState) - 声明一个状态变量及其更新函数。

```javascript
import React, { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}
```
## useEffect
useEffect(callback, [dependencies]) - 声明一个副作用操作，类似于 componentDidMount 和 componentDidUpdate 的组合。
```javascript
import React, { useState, useEffect } from 'react';

function Timer() {
  const [seconds, setSeconds] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setSeconds(seconds => seconds + 1);
    }, 1000);

    return () => clearInterval(interval);
  }, []); // 空数组作为第二个参数表示仅在组件挂载和卸载时执行

  return <p>Timer: {seconds} seconds</p>;
}
```
## useContext
useContext(context) - 获取并订阅一个 React context。

```javascript
import React, { useContext } from 'react';

const MyContext = React.createContext('default');

function MyComponent() {
  const contextValue = useContext(MyContext);
  return <p>Context value: {contextValue}</p>;
}
```
## useReducer
useReducer(reducer, initialState) - 声明一个复杂状态逻辑的 reducer 和 dispatch 函数。

```javascript
import React, { useReducer } from 'react';

const initialState = { count: 0 };

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    default:
      throw new Error();
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <div>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: 'increment' })}>Increment</button>
      <button onClick={() => dispatch({ type: 'decrement' })}>Decrement</button>
    </div>
  );
}
```
## useCallback
useCallback(callback, [dependencies]) - 缓存一个回调函数，以便在依赖项变化时避免重复创建。
```javascript
import React, { useState, useCallback } from 'react';

function ParentComponent() {
  const [count, setCount] = useState(0);

  const increment = useCallback(() => {
    setCount(count + 1);
  }, [count]);

  return (
    <div>
      <ChildComponent onClick={increment} />
    </div>
  );
}

function ChildComponent({ onClick }) {
  return <button onClick={onClick}>Increment Count</button>;
}
```
## useMemo
useMemo(factory, [dependencies]) - 缓存计算值，以便在依赖项变化时避免重复计算。

```javascript
import React, { useMemo } from 'react';

function ExpensiveComponent({ data }) {
  const expensiveValue = useMemo(() => {
    return computeExpensiveValue(data);
  }, [data]);

  return <div>Expensive value: {expensiveValue}</div>;
}
```
## useRef
useRef(initialValue) - 创建一个持久化的引用，可用于访问 DOM 元素或缓存任何可变值。

```javascript
import React, { useRef, useEffect } from 'react';

function TextInputWithFocusButton() {
  const inputRef = useRef(null);

  useEffect(() => {
    inputRef.current.focus();
  }, []);

  return (
    <>
      <input ref={inputRef} type="text" />
      <button onClick={() => inputRef.current.focus()}>Focus Input</button>
    </>
  );
}
```
# ReactDOM

## ReactDOM.render
ReactDOM.render(element, container[, callback]) - 将 React 元素渲染到指定的 DOM 节点。

```javascript
import React from 'react';
import ReactDOM from 'react-dom';

const element = <h1>Hello, World!</h1>;
ReactDOM.render(element, document.getElementById('root'));
```
## ReactDOM.createRoot
ReactDOM.createRoot(container[, options]) - 创建一个 React 根实例，支持并发渲染特性。

```javascript
import ReactDOM from 'react-dom';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
```
## ReactDOM.unmountComponentAtNode
ReactDOM.unmountComponentAtNode(container) - 卸载指定 DOM 节点上的 React 组件。

```javascript
import React from 'react';
import ReactDOM from 'react-dom';

ReactDOM.unmountComponentAtNode(document.getElementById('root'));
```
## ReactDOMServer.renderToString
ReactDOMServer.renderToString(element) - 将 React 元素渲染为静态 HTML 字符串，用于服务器端渲染。

```javascript
import React from 'react';
import ReactDOMServer from 'react-dom/server';

const element = <div>Hello, World!</div>;
const htmlString = ReactDOMServer.renderToString(element);
```