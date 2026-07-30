# ReactAPI
React 组件 API 涉及多个重要的方面，包括生命周期方法、状态管理、属性传递和事件处理。

## 生命周期
分为三个主要阶段:挂载/更新/卸载

### 挂载阶段
constructor(props): 构造函数，用于初始化状态或绑定方法。
static getDerivedStateFromProps(props, state): 每次在调用 render 方法之前调用，用于更新状态。
componentDidMount(): 组件挂载后调用，此时可以进行 DOM 操作或数据请求。
```javascript
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    if (nextProps.reset) {
      return { count: 0 };
    }
    return null;
  }

  componentDidMount() {
    console.log('Component mounted');
  }

  render() {
    return <div>{this.state.count}</div>;
  }
}
```
### 更新阶段
static getDerivedStateFromProps(props, state): 与挂载阶段相同，用于更新状态。
shouldComponentUpdate(nextProps, nextState): 返回布尔值，决定组件是否重新渲染。
render(): 渲染组件的 UI。
getSnapshotBeforeUpdate(prevProps, prevState): 在 DOM 更新之前调用，用于捕获一些信息（如滚动位置）。
componentDidUpdate(prevProps, prevState, snapshot): 在组件更新后调用。
```javascript
class MyComponent extends React.Component {
  shouldComponentUpdate(nextProps, nextState) {
    return nextState.count !== this.state.count;
  }

  getSnapshotBeforeUpdate(prevProps, prevState) {
    return { scrollPosition: window.scrollY };
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (snapshot) {
      window.scrollTo(0, snapshot.scrollPosition);
    }
    console.log('Component updated');
  }

  render() {
    return <div>{this.state.count}</div>;
  }
}
```
### 卸载阶段
componentWillUnmount(): 组件即将卸载时调用，用于清理资源（如定时器、事件监听等）。
```javascript
class MyComponent extends React.Component {
  componentWillUnmount() {
    console.log('Component will unmount');
  }

  render() {
    return <div>{this.state.count}</div>;
  }
}
```

## 状态管理
状态是一个组件内部的数据，使用 this.state 来定义和管理。通过 setState 方法更新状态。

### 关于setState
设置状态:setState
setState 是 React 中用于更新组件状态的方法。

语法格式如下：

setState(object nextState[, function callback])
参数说明
object nextState: 一个对象，包含要更新的状态键值对。React 会将这个对象合并到当前状态中。
function callback: 一个可选的回调函数，会在状态更新并重新渲染完成后执行。
合并 nextState 和当前 state，并重新渲染组件。
不能在组件内部通过 this.state 修改状态，因为该状态会在调用 setState() 后被替换。

setState() 并不会立即改变 this.state，而是创建一个即将处理的 state。setState() 并不一定是同步的，为了提升性能 React 会批量执行 state 和 DOM 渲染。
setState 是 React 事件处理函数中和请求回调函数中触发 UI 更新的主要方法。
setState()总是会触发一次组件重绘，除非在 shouldComponentUpdate() 中实现了一些条件渲染逻辑。

通过合理使用 setState，可以有效地管理组件状态，并确保在状态更新后执行必要的操作，从而提高应用的响应性和可靠性。
```javascript
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
  }

  increment = () => {
    this.setState((prevState) => ({ count: prevState.count + 1 }));
  };

  render() {
    return (
      <div>
        <p>Count: {this.state.count}</p>
        <button onClick={this.increment}>Increment</button>
      </div>
    );
  }
}
```

## 属性传递
通过 this.props 访问传递给组件的属性，可以使用 PropTypes 进行类型检查。
```javascript
import PropTypes from 'prop-types';

class MyComponent extends React.Component {
  render() {
    return <div>{this.props.title}</div>;
  }
}

MyComponent.propTypes = {
  title: PropTypes.string.isRequired,
};

// 使用组件并传递属性
<MyComponent title="Hello, World!" />
```

## 事件处理
通过事件处理函数处理用户交互。需要使用 .bind(this) 或箭头函数来确保 this 指向正确。
```javascript
class MyComponent extends React.Component {
  handleClick = () => {
    console.log('Button clicked');
  };

  render() {
    return <button onClick={this.handleClick}>Click me</button>;
  }
}
```