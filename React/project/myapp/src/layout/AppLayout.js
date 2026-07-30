import { NavLink, Outlet } from 'react-router-dom';
import { chapters } from '../lessons';

export default function AppLayout() {
  return (
    <div className="app-shell">
      <aside className="sidebar">
        <NavLink to="/" className="brand" end>
          React 学习
        </NavLink>
        <nav className="nav">
          {chapters.map((chapter) => (
            <div key={chapter.id} className="nav-chapter">
              <NavLink
                to={chapter.path}
                end
                className={({ isActive }) =>
                  isActive ? 'nav-chapter-title active' : 'nav-chapter-title'
                }
              >
                {chapter.title}
              </NavLink>
              <ul>
                {chapter.lessons.map((lesson) => (
                  <li key={lesson.id}>
                    <NavLink
                      to={`${chapter.path}/${lesson.id}`}
                      className={({ isActive }) => (isActive ? 'active' : undefined)}
                    >
                      {lesson.title}
                      {lesson.Demo ? (
                        <span className="tag demo">演示</span>
                      ) : (
                        <span className="tag text">文本</span>
                      )}
                    </NavLink>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </nav>
      </aside>
      <main className="main">
        <Outlet />
      </main>
    </div>
  );
}
