# React Hooks
React Hooks 是一种函数式组件的增强机制，它允许你在不编写类组件的情况下使用 React 的特性。主要的 Hooks 包括 useState, useEffect, useContext, useReducer, useCallback, useMemo, useRef, 和 useImperativeHandle 等。这些 Hooks 提供了访问 React 特性的方式，使得你可以更好地组织和重用你的代码。

## 常用Hooks

* useState - 用于在函数组件中添加 state，你可以使用它来跟踪随时间变化的数据。
* useEffect - 用于执行副作用操作，比如数据获取、订阅或手动更改 DOM，它与类组件中的 componentDidMount、componentDidUpdate 和 componentWillUnmount 生命周期类似。
* useContext - 用于访问 React context 在组件树中传递的数据，而不必通过每个组件传递 props。
* useReducer - 用于更复杂的 state 逻辑，它接收一个 reducer 函数和初始状态，然后返回当前的状态和派发 action 的 dispatch 函数。
* useMemo - 用于对计算结果进行记忆，避免在每次渲染时重复计算。
* useRef - 用于创建对 DOM 元素或值的引用，可以在渲染之间保持状态。
* useImperativeHandle - 用于使用 ref 时暴露 DOM 元素的方法。
* useLayoutEffect - 与 useEffect 类似，但它在所有的 DOM 变更之后同步执行。这在需要读取 DOM 布局并同步触发重渲染时非常有用。
* useDebugValue - 用于在 React 开发者工具中显示自定义 hook 的标签。

## 使用 React Hooks 的好处
更简洁的组件逻辑：无需编写类组件，可以使用函数组件和 Hooks 来管理状态和生命周期。
提高代码复用性：Hooks 可以帮助你将逻辑提取到可重用的函数中，减少重复代码。
更好的性能优化：使用 useEffect, useCallback, useMemo 等 Hooks 可以更精确地控制副作用和性能消耗。
## 注意事项
仅在顶层使用 Hooks：不要在循环、条件或嵌套函数中调用 Hook，确保 Hooks 在每次渲染时都以相同的顺序被调用。
使用 ESLint 插件：React 官方提供了 eslint-plugin-react-hooks 插件来帮助你检查 Hook 的使用是否正确。