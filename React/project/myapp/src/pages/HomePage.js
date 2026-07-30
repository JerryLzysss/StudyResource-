import { Link } from 'react-router-dom';
import { chapters } from '../lessons';

export default function HomePage() {
  return (
    <div className="page home-page">
      <h1>React 学习路由总览</h1>
      <p>
        通过左侧导航浏览「描述 UI」「添加交互」「状态管理」三章。
        带「演示」标签的小节可直接运行示例；「文本」小节展示笔记原文。
      </p>
      <div className="chapter-cards">
        {chapters.map((chapter) => (
          <section key={chapter.id} className="chapter-card">
            <h2>
              <Link to={chapter.path}>{chapter.title}</Link>
            </h2>
            <ul>
              {chapter.lessons.map((lesson) => (
                <li key={lesson.id}>
                  <Link to={`${chapter.path}/${lesson.id}`}>{lesson.title}</Link>
                  {lesson.Demo ? ' · 演示' : ' · 文本'}
                </li>
              ))}
            </ul>
          </section>
        ))}
      </div>
    </div>
  );
}
