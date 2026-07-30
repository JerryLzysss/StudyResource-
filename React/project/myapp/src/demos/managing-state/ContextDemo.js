import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext('light');

function Button({ children }) {
  const theme = useContext(ThemeContext);
  return (
    <button type="button" className={`theme-btn ${theme}`}>
      {children}（当前主题：{theme}）
    </button>
  );
}

function Panel({ title, children }) {
  const theme = useContext(ThemeContext);
  return (
    <section className={`panel theme-panel ${theme}`}>
      <h3>{title}</h3>
      {children}
    </section>
  );
}

export default function ContextDemo() {
  const [theme, setTheme] = useState('light');

  return (
    <ThemeContext.Provider value={theme}>
      <section className="stack">
        <label className="row">
          <input
            type="checkbox"
            checked={theme === 'dark'}
            onChange={(e) => setTheme(e.target.checked ? 'dark' : 'light')}
          />
          使用 dark 主题
        </label>
        <Panel title="欢迎">
          <Button>注册</Button>
          <Button>登录</Button>
        </Panel>
      </section>
    </ThemeContext.Provider>
  );
}
