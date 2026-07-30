# React组件

## 函数组件
接受props并返回react元素的js函数
```javascript
Welcome.js
import React from 'react'
function Welcome(props){
    return <h1>hello,{props.name}</h1>
}
export default Welcome;

index.js
import React from 'react'
import ReactDOM from 'react-dom'
import Welcome from './Welcome'
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<Welcome name="World"/>);
```

## 类组件
```javascript
import React,{Component} from 'react';
class Welcome extends Component{
    render(){
        return <h1>Hello,{this.props.name}!</h1>
    }
}
export default Welcome;


import React from 'react';
import ReactDOM from 'react-dom'
import Welcome from './Welcome'
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<Welcome name="World"/>);
```