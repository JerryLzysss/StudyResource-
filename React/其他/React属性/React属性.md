[TOC]
# React Props
Props是用于将数据从父组件传递到子组件的机制,props是只读的，子组件不能直接修改，而是应该由父组件来管理和更新.
state和props的主要区别在于props是不可变的，而state可以根据用户交互来改变.

## 普通Props

```javascript
function HelloMessage(props) {
    return <h1>Hello {props.name}!</h1>;
}
 
const element = <HelloMessage name="Runoob"/>;
 
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
    element
);
```

## 默认Props

```javascript
class HelloMessage extends React.Component {
  render() {
    return (
      <h1>Hello, {this.props.name}</h1>
    );
  }
}
 
HelloMessage.defaultProps = {
  name: 'Runoob'
};
 
const element = <HelloMessage/>;
 
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  element
);
```

## 多个Props
```javascript
const UserCard = (props) => {
  return (
    <div>
      <h2>{props.name}</h2>
      <p>Age: {props.age}</p>
      <p>Location: {props.location}</p>
    </div>
  );
};

const App = () => {
  return (
    <UserCard name="Alice" age={25} location="New York" />
  );
};

ReactDOM.render(<App />, document.getElementById('root'));
```

## PropTypes验证
propTypes是React提供的一种工具，用于对组件props进行类型检查.
```javascript
import PropTypes from 'prop-types';

const Greeting = (props) => {
  return <h1>Hello, {props.name}!</h1>;
};

Greeting.propTypes = {
  name: PropTypes.string.isRequired
};

const App = () => {
  return (
    <div>
      <Greeting name="Alice" />
      {/* <Greeting />  // 这行代码会导致控制台警告，因为 name 是必需的 */}
    </div>
  );
};

ReactDOM.render(<App />, document.getElementById('root'));
```

## 传递回调函数作为Props
```javascript
class ParentComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = { message: '' };
  }

  handleMessage = (msg) => {
    this.setState({ message: msg });
  };

  render() {
    return (
      <div>
        <ChildComponent onMessage={this.handleMessage} />
        <p>Message from Child: {this.state.message}</p>
      </div>
    );
  }
}

const ChildComponent = (props) => {
  const sendMessage = () => {
    props.onMessage('Hello from Child!');
  };

  return (
    <div>
      <button onClick={sendMessage}>Send Message</button>
    </div>
  );
};

ReactDOM.render(<ParentComponent />, document.getElementById('root'));
```

## 解构props
```javascript
const Greeting = ({ name }) => {
  return <h1>Hello, {name}!</h1>;
};

const App = () => {
  return <Greeting name="Alice" />;
};

ReactDOM.render(<App />, document.getElementById('root'));
```

## PropTypes不同类型
基本数据类型
PropTypes.string：字符串
PropTypes.number：数字
PropTypes.boolean：布尔值
PropTypes.object：对象
PropTypes.array：数组
PropTypes.func：函数
PropTypes.symbol：Symbol
特殊类型
PropTypes.node：任何可以被渲染的内容：数字、字符串、元素或数组（包括这些类型）
PropTypes.element：React元素
PropTypes.instanceOf(Class)：某个类的实例
组合类型
PropTypes.oneOf(['option1', 'option2'])：枚举类型，值必须是所提供选项之一
PropTypes.oneOfType([PropTypes.string, PropTypes.number])：多个类型中的一个
PropTypes.arrayOf(PropTypes.number)：某种类型组成的数组
PropTypes.objectOf(PropTypes.number)：某种类型组成的对象
PropTypes.shape({ key: PropTypes.string, value: PropTypes.number })：具有特定形状的对象
其他

PropTypes.any：任何类型
PropTypes.exact({ key: PropTypes.string })：具有特定键的对象，且不能有其他多余的键
```javascript
import React from 'react';
import ReactDOM from 'react-dom/client';
import PropTypes from 'prop-types';

class MyComponent extends React.Component {
  static propTypes = {
    title: PropTypes.string.isRequired, // 必须是字符串且必需
    age: PropTypes.number,              // 可选的数字
    isAdmin: PropTypes.bool,            // 可选的布尔值
    user: PropTypes.shape({             // 必须是具有特定形状的对象
      name: PropTypes.string,
      email: PropTypes.string
    }),
    items: PropTypes.arrayOf(PropTypes.string), // 必须是字符串数组
    callback: PropTypes.func,           // 可选的函数
    children: PropTypes.node,           // 可选的可以渲染的内容
    options: PropTypes.oneOf(['option1', 'option2']), // 必须是特定值之一
  };

  render() {
    return (
      <div>
        <h1>{this.props.title}</h1>
        {this.props.age && <p>Age: {this.props.age}</p>}
        {this.props.isAdmin && <p>Admin</p>}
        {this.props.user && (
          <div>
            <p>Name: {this.props.user.name}</p>
            <p>Email: {this.props.user.email}</p>
          </div>
        )}
        {this.props.items && (
          <ul>
            {this.props.items.map((item, index) => (
              <li key={index}>{item}</li>
            ))}
          </ul>
        )}
        {this.props.callback && (
          <button onClick={this.props.callback}>Click me</button>
        )}
        {this.props.children}
        {this.props.options && <p>Option: {this.props.options}</p>}
      </div>
    );
  }
}

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <MyComponent 
    title="Hello, World!"
    age={30}
    isAdmin={true}
    user={{ name: "John Doe", email: "john@example.com" }}
    items={['Item 1', 'Item 2', 'Item 3']}
    callback={() => alert('Button clicked!')}
    options="option1"
  >
    <p>This is a child element</p>
  </MyComponent>
);
```