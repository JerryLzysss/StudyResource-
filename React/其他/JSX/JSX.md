[TOC]
# JSX
JSX 是 JavaScript XML的简写，表示了在JavaScript 中书写XML格式的代码。它是React的核心内容.
JSX无法在浏览器中直接使用.
在React17x以上不需要导入，低版本则需要导入React.

## JSX的注意点
* 特殊属性写法 className htmlFor
* 没有内容的节点可以使用 单标签
* 必须有根节点,可以使用<></>
* 如果JSX换行,那么使用()包裹

## JSX语法

JSX是javascript XML的简写，表示在js中书写XML格式的代码，这是React的核心内容.
JSX是javascript的语法拓展，在脚手架中内置了@babel/plugin-transform-react-jsx插件来解析.

```javascript
// JSX是React的语法糖，更直观易读
const element = <h1 id="el">Hello React</h1>

// 在JSX中使用JavaScript表达式
const name = "React"
const element = <h1>Hello {name}</h1>

// JSX中的属性
const element = <div className="container" id="main">内容</div>
const element=(
    <>
    <div>header</div>
    <div>footer</div>
    </>
);
```

## JSX表达式

```javascript
嵌入表达式
const data={
    name:'tom',
    age:18
};

条件渲染
const getContent = () =>{
    if(loading){
        return <div>123</div>
    }
    else
    {
        return <div>1234</div>
    }
}

三元表达式
const element = (
    <div>
        {loading ? <div>正在加载...</div>:<div>数据加载完毕</div>}
    </div>
)

逻辑运算
const element=(
    <div>
        {loading && <div>正在加载...</div>}
        {loading||<div>数据加载完毕,这是显示数据</div>}
    </div>
)
```

## JSX列表渲染

```javascript
const list = [<li>tom</li>,<li>jack</li>,<li>tony</li>]
const element=<ul>{list}</ul>

const element=(<ul>{list.map((item)=>{<li key={item}>{item}</li>})})

```

## JSX样式
* style 接受小驼峰命名属性的JS对象，而不是CSS字符串
* style的key采用小驼峰命名是为了与JS访问DOM节点的属性保持一致.
* React会自动添加px后缀导内联样式为数字的属性后

### 内联样式
```javascript
// 内联样式使用对象形式，属性名使用驼峰命名法
const element = (
  <div style={{
    backgroundColor: 'lightblue',
    padding: '20px',
    borderRadius: '8px',
    fontSize: '16px'
  }}>
    这是内联样式的示例
  </div>
)
```

### CSS类名绑定
```javascript
// 使用className绑定CSS类
const element = (
  <div className="container primary-text">
    这是CSS类样式的示例
  </div>
)

// 动态类名绑定
function Button({ isActive }) {
  const buttonClass = isActive ? 'btn btn-active' : 'btn btn-inactive'
  
  return (
    <button className={buttonClass}>
      {isActive ? '激活状态' : '未激活状态'}
    </button>
  )
}
```

### 条件样式绑定
```javascript
function StatusBadge({ status }) {
  const getStatusStyle = () => {
    switch(status) {
      case 'success':
        return { backgroundColor: '#4CAF50', color: 'white' }
      case 'warning':
        return { backgroundColor: '#FF9800', color: 'white' }
      case 'error':
        return { backgroundColor: '#F44336', color: 'white' }
      default:
        return { backgroundColor: '#9E9E9E', color: 'white' }
    }
  }
  
  return (
    <span style={getStatusStyle()}>
      {status}
    </span>
  )
}
```

### 样式对象复用
```javascript
// 定义样式对象
const commonStyles = {
  padding: '10px 20px',
  margin: '10px',
  border: '1px solid #ccc',
  borderRadius: '4px'
}

const buttonStyles = {
  ...commonStyles,
  backgroundColor: '#007bff',
  color: 'white',
  cursor: 'pointer'
}

const inputStyles = {
  ...commonStyles,
  backgroundColor: 'white',
  color: '#333'
}

// 使用样式
const element = (
  <div>
    <input style={inputStyles} placeholder="输入框" />
    <button style={buttonStyles}>按钮</button>
  </div>
)
```

### 响应式样式
```javascript
function ResponsiveBox() {
  const [windowWidth, setWindowWidth] = useState(window.innerWidth)
  
  useEffect(() => {
    const handleResize = () => setWindowWidth(window.innerWidth)
    window.addEventListener('resize', handleResize)
    return () => window.removeEventListener('resize', handleResize)
  }, [])
  
  const boxStyle = {
    width: windowWidth > 768 ? '300px' : '100%',
    height: '200px',
    backgroundColor: windowWidth > 768 ? 'lightblue' : 'lightgreen',
    transition: 'all 0.3s ease'
  }
  
  return (
    <div style={boxStyle}>
      响应式样式示例
    </div>
  )
}
```

## JSX className

### 基础className使用
```javascript
// 静态类名
const element = <div className="container">基础容器</div>

// 多个类名
const element = <div className="container main-content sidebar">多类名元素</div>

// 使用变量
const theme = "dark"
const element = <div className={`app ${theme}-theme`}>主题应用</div>
```

### 动态className绑定
```javascript
function DynamicButton({ variant, size, disabled }) {
  // 基础类名
  const baseClass = "btn"
  
  // 动态类名
  const variantClass = variant ? `btn-${variant}` : "btn-primary"
  const sizeClass = size ? `btn-${size}` : "btn-md"
  const disabledClass = disabled ? "btn-disabled" : ""
  
  // 组合类名
  const buttonClass = [baseClass, variantClass, sizeClass, disabledClass]
    .filter(Boolean) // 过滤空字符串
    .join(" ")
  
  return (
    <button className={buttonClass} disabled={disabled}>
      动态按钮
    </button>
  )
}

// 使用示例
const element = (
  <div>
    <DynamicButton variant="success" size="lg" />
    <DynamicButton variant="danger" size="sm" disabled={true} />
  </div>
)
```

### 条件className
```javascript
function StatusCard({ status, isHighlighted }) {
  const getCardClass = () => {
    let classes = ["card"]
    
    // 根据状态添加类名
    if (status === "success") classes.push("card-success")
    else if (status === "warning") classes.push("card-warning")
    else if (status === "error") classes.push("card-error")
    
    // 高亮状态
    if (isHighlighted) classes.push("card-highlighted")
    
    return classes.join(" ")
  }
  
  return (
    <div className={getCardClass()}>
      <h3>状态卡片</h3>
      <p>当前状态: {status}</p>
    </div>
  )
}
```

### 使用classnames库（推荐）
```javascript
import classNames from 'classnames'

function SmartButton({ primary, danger, large, disabled, className, children }) {
  const buttonClass = classNames(
    'btn',                    // 基础类名
    {
      'btn-primary': primary, // 条件类名
      'btn-danger': danger,
      'btn-large': large,
      'btn-disabled': disabled
    },
    className                 // 外部传入的类名
  )
  
  return (
    <button className={buttonClass} disabled={disabled}>
      {children}
    </button>
  )
}

// 使用示例
const element = (
  <div>
    <SmartButton primary large>主要按钮</SmartButton>
    <SmartButton danger>危险按钮</SmartButton>
    <SmartButton className="custom-btn">自定义按钮</SmartButton>
  </div>
)
```

### 注意事项
- 使用`className`而不是`class`（HTML属性）
- 多个类名用空格分隔
- 动态类名可以使用模板字符串或数组方法
- 推荐使用`classnames`库来管理复杂的类名逻辑
- 条件类名可以使用对象形式或三元运算符
- 类名应该有意义且易于维护
