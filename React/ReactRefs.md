# React Refs
React 支持一种非常特殊的属性 Ref ,你可以用来绑定到 render() 输出的任何组件上。
这个特殊的属性允许你引用 render() 返回的相应的支撑实例（ backing instance ），这样就可以确保在任何时间总是拿到正确的实例。
在 React 中，Refs（引用）提供了一种访问 DOM 元素或组件实例的方法。使用 Refs 可以直接操作 DOM 元素或获取子组件实例，适用于处理焦点、文本选择、媒体播放、触发强制动画或集成第三方 DOM 库等场景。
使用 React.createRef 或 useRef 来创建和访问 refs。

React.createRef 通常用于类组件，而 useRef 是一个 Hook，通常用于函数组件。

此外，在事件处理函数中绑定 this 也可以通过类属性语法来避免每次渲染时都创建一个新的函数。

创建 Ref：在类组件的构造函数中使用 React.createRef 创建 ref 对象，并将其赋值给组件实例的一个属性。
绑定 Ref：在 render 方法中，将 ref 对象绑定到需要引用的 DOM 元素上。
访问 Ref：在组件的其它方法中，通过 this.myInputRef.current 访问绑定的 DOM 元素，可以操作该元素的属性和方法。
## 示例
```javascript
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.myInputRef = React.createRef();
  }
 
  handleClick = () => {
    // 使用原生的 DOM API 获取焦点
    this.myInputRef.current.focus();
  }
 
  render() {
    return (
      <div>
        <input type="text" ref={this.myInputRef} />
        <input
          type="button"
          value="点我输入框获取焦点"
          onClick={this.handleClick}
        />
      </div>
    );
  }
}
```
## 创建Refs
```javascript
import React from 'react';
import ReactDOM from 'react-dom';

class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.myRef = React.createRef();
  }

  componentDidMount() {
    this.myRef.current.focus();
  }

  render() {
    return <input type="text" ref={this.myRef} />;
  }
}

const root = ReactDOM.createRoot(document.getElementById("root"));
// 渲染 MyComponent 组件
root.render(<MyComponent />);
```
## 回调Refs
```javascript
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.setMyRef = element => {
      this.myRef = element;
    };
  }

  componentDidMount() {
    if (this.myRef) {
      this.myRef.focus();
    }
  }

  render() {
    return <input type="text" ref={this.setMyRef} />;
  }
}

const root = ReactDOM.createRoot(document.getElementById("root"));
// 渲染 MyComponent 组件
root.render(<MyComponent />);
```

## Refs访问DOM元素
```javascript
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.myRef = React.createRef();
  }

  handleClick = () => {
    this.myRef.current.style.backgroundColor = 'yellow';
  };

  render() {
    return (
      <div>
        <input type="text" ref={this.myRef} />
        <button onClick={this.handleClick}>Change Background</button>
      </div>
    );
  }
}

const root = ReactDOM.createRoot(document.getElementById("root"));
// 渲染 MyComponent 组件
root.render(<MyComponent />);
```

## 访问子组件
```javascript
class ChildComponent extends React.Component {
  focusInput = () => {
    this.inputRef.current.focus();
  };

  constructor(props) {
    super(props);
    this.inputRef = React.createRef();
  }

  render() {
    return <input type="text" ref={this.inputRef} />;
  }
}

class ParentComponent extends React.Component {
  constructor(props) {
    super(props);
    this.childRef = React.createRef();
  }

  handleClick = () => {
    this.childRef.current.focusInput();
  };

  render() {
    return (
      <div>
        <ChildComponent ref={this.childRef} />
        <button onClick={this.handleClick}>Focus Child Input</button>
      </div>
    );
  }
}

const root = ReactDOM.createRoot(document.getElementById("root"));
// 渲染 MyComponent 组件
root.render(<MyComponent />);
```
## useRef(Hook函数组件)
```javascript
import React, { useRef } from 'react';
import ReactDOM from 'react-dom';

const MyComponent = () => {
  const inputRef = useRef(null);

  const handleClick = () => {
    inputRef.current.focus();
  };

  return (
    <div>
      <input type="text" ref={inputRef} />
      <button onClick={handleClick}>Focus Input</button>
    </div>
  );
};

const root = ReactDOM.createRoot(document.getElementById("root"));
// 渲染 MyComponent 组件
root.render(<MyComponent />);
```
